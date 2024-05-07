// lib/services/auth_service.dart
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:testapp/services/storage_service.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  final RxBool isLoggedIn = false.obs;

  final _storageService = Get.find<StorageService>();


  bool get isLoggedInValue => isLoggedIn.value;

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
    print('>>>>>>>>>>>>>>>>>&checkLoginStatus');
    print(token);
    // 토큰 유효성 검사
    final isValid = await _validateToken(token);
    isLoggedIn.value = isValid;
    if (!isValid) {
      // 토큰이 유효하지 않은 경우 로그아웃 처리
      logout();
    }
    }

  Future<bool> checkAccount(String token) async {
    try {
      final response = await http.get(
        Uri.parse('http://api.teamwaf.app/v1/auth/checkAccount'),
        headers: {'Authorization': 'Paseto $token'},
      );
      // json 형태를 디코딩하여 변수에 저장
      final data = jsonDecode(response.body);
      // 변수에 저장된 값을 출력
      final accessToken = data['access_token'].toString().trim();
      final refreshToken = data['refresh_token'].toString().trim();

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
      final response = await http.get(
        Uri.parse('http://localhost:8080/auth/validate'),
        headers: {'Authorization': token},
      );
      return response.statusCode == 200;
    } catch (e) {
      print(e.toString());
      return false;
    }
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
