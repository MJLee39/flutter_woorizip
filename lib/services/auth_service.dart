// lib/services/auth_service.dart
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  final RxBool isLoggedIn = false.obs;
  final _storage = GetStorage();
  final _tokenKey = 'auth_token';

  bool get isLoggedInValue => isLoggedIn.value;

  @override
  void onInit() {
    super.onInit();
    // 초기값 설정
    isLoggedIn.value = _storage.read(_tokenKey) != null;
    // 앱 시작 시 로그인 상태 확인
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final token = _storage.read(_tokenKey);
    if (token != null) {
      // 토큰 유효성 검사
      final isValid = await _validateToken(token);
      isLoggedIn.value = isValid;
      if (!isValid) {
        // 토큰이 유효하지 않은 경우 로그아웃 처리
        logout();
      }
    } else {
      isLoggedIn.value = false;
    }
  }

  Future<bool> _validateToken(String token) async {
    try {
      final response = await http.get(
        Uri.parse('https://test.teamwaf.app/auth'),
        headers: {'Authorization': token},
      );
      return response.statusCode == 200;
    } catch (e) {
      // 예외 처리 로직 추가
      print(e.toString());
      return false;
    }
  }

  void login(String token) {
    // 토큰 저장
    _storage.write(_tokenKey, token);
    isLoggedIn.value = true;
  }

  void logout() {
    // 토큰 삭제
    _storage.remove(_tokenKey);
    isLoggedIn.value = false;

    Get.offAllNamed('/login');
  }
}
