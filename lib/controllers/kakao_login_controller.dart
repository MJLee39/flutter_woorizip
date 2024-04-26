import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:testapp/services/auth_service.dart';

class KakaoLoginController extends GetxController {
  final RxBool isLoggedIn = false.obs;
  final RxString accessToken = ''.obs;
  final RxString userId = ''.obs;
  final RxString nickname = ''.obs;
  final RxString profileImageUrl = ''.obs;
  final _authService = Get.find<AuthService>();


  Future<void> loginWithKakao() async {
    Get.put(AuthService());
    try {
      OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
      print('카카오계정으로 로그인 성공 ${token.accessToken}');
      isLoggedIn.value = true;
      _authService.CheckAccount(token.accessToken);
    } catch (error) {
      print('카카오계정으로 로그인 실패 $error');
      isLoggedIn.value = false;
      accessToken.value = '';
    }
  }

  Future<void> logoutFromKakao() async {
    try {
      await UserApi.instance.unlink();
      print('카카오계정으로부터 로그아웃 성공');
      isLoggedIn.value = false;
      accessToken.value = '';
      userId.value = '';
      nickname.value = '';
      profileImageUrl.value = '';
    } catch (error) {
      print('카카오계정으로부터 로그아웃 실패 $error');
    }
  }

  Future<void> getUserInfo() async {
    try {
      User user = await UserApi.instance.me();
      print('사용자 정보 요청 성공'
        '\n회원번호: ${user.id}'
        '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
        '\n프로필사진: ${user.kakaoAccount?.profile?.profileImageUrl}');

      userId.value = user.id.toString();
      nickname.value = user.kakaoAccount?.profile?.nickname ?? '';
      profileImageUrl.value = user.kakaoAccount?.profile?.profileImageUrl ?? '';
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
  }
}