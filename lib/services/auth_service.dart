// lib/services/auth_service.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:testapp/account/account_controller.dart';
import 'package:testapp/models/account.dart';
import 'package:testapp/services/storage_service.dart';
import 'package:testapp/utils/api_config.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();
  
  final RxBool isLoggedIn = false.obs;

  final _storageService = Get.find<StorageService>();

  bool get isLoggedInValue => isLoggedIn.value;

  AccountController accountController = Get.find<AccountController>();

  @override
  void onInit() {
    super.onInit();
    
    // 초기값 설정
    isLoggedIn.value = _storageService.hasToken();
    print('>>>>>>>>>>>>>>>>>&isLoggedIn.value');
    print(isLoggedIn.value);
    // 앱 시작 시 로그인 상태 확인
    // checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final token = _storageService.getAccessToken();
    // 토큰 유효성 검사
    final isValid = await _validateToken(token);
    isLoggedIn.value = isValid;
    if (!isValid) {
      // 토큰이 유효하지 않은 경우 로그아웃 처리
      logout();
    } else {
      // 토큰이 유효한 경우 계정 정보 재설정
      checkAccount(accountController.provider, accountController.providerUserId);
    }
  }

  Future<bool> checkAccount(String provider, String providerUserId) async {
    try {
      debugPrint('provider: $provider, providerUserId: $providerUserId');
      debugPrint('apiCheckAccountUrl: ${ApiConfig.apiLoginUrl}');
      final response = await http.post(
        Uri.parse(ApiConfig.apiLoginUrl),
       headers: {'Content-Type': 'application/json; charset=utf-8'},
        body: jsonEncode(
            {'provider': provider, 'providerUserId': providerUserId}),
      );
      // json 형태를 디코딩하여 변수에 저장
      final data =  jsonDecode(utf8.decode(response.bodyBytes));
      debugPrint('data: $data');
      // 변수에 저장된 값을 출력
      final accessToken = data['access_token'].toString().trim();
      final refreshToken = data['refresh_token'].toString().trim();

      // 계정 정보 추출
      final accountData = data['account'];
      final account = Account.fromJson(accountData);

      // 계정 정보 저장
      setAccount(account);

      setTokenData(accessToken, refreshToken);

      return response.statusCode == 200;
    } catch (e) {
      // 예외 처리 로직 추가
      print(e.toString());
      return false;
    }
  }

  Future<bool> _validateToken(String token) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.apiValidationUrl),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
        body: jsonEncode({'token': token}),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  void setAccount(Account account) async {
    _storageService.setAccount(account);
  }

  void setTokenData(String accessToken, String refreshToken) {
    // 토큰 저장
    _storageService.setAccessToken(accessToken);
    _storageService.setRefreshToken(refreshToken);

    isLoggedIn.value = true;

    _storageService.read('intendedRoute') != null
        ? Get.offAllNamed(_storageService.read('intendedRoute'))
        : Get.offAllNamed('/home');
  }

  void logout() {
    // 토큰 삭제
    _storageService.removeAccessToken();
    _storageService.removeRefreshToken();
    _storageService.removeAccount();

    isLoggedIn.value = false;
    Get.snackbar(
      '로그아웃',
      '로그아웃 되었습니다.',
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
    );
    Get.offAllNamed('/');
  }
}
