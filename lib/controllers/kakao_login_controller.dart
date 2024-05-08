import 'dart:convert';

import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:testapp/services/auth_service.dart';
import 'package:http/http.dart' as http;

class KakaoLoginController extends GetxController {
  final RxBool isLoggedIn = false.obs;
  final RxString accessToken = ''.obs;
  final RxString userId = ''.obs;
  final RxString nickname = ''.obs;
  final RxString profileImageUrl = ''.obs;
  final _authService = Get.find<AuthService>();


    Future<void> loginWithKakao() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();

      OAuthToken token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();

      final url = Uri.https('kapi.kakao.com', '/v2/user/me');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${token.accessToken}',
        },
      );

      final profileInfo = jsonDecode(response.body);
      
      userId.value = profileInfo['id'].toString();
      nickname.value = profileInfo['properties']['nickname'];
      profileImageUrl.value = profileInfo['properties']['profile_image'];

       _authService.checkAccount('kakao', userId.value);

      
    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');
    }
  }

//   Future<void> loginWithKakao() async {
//     // 카카오 로그인 구현 예제

// // 카카오톡 실행 가능 여부 확인
// // 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
//     if (await isKakaoTalkInstalled()) {
//       try {
//         await UserApi.instance.loginWithKakaoTalk();
//         // _authService.checkAccount('kakao', user.id.toString());
//       } catch (error) {
//         print('카카오톡으로 로그인 실패 $error');
//       }
//     }
        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
    //     if (error is PlatformException && error.code == 'CANCELED') {
    //       return;
    //     }
    //     // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
    //     try {
    //       await UserApi.instance.loginWithKakaoAccount();
    //       print('카카오계정으로 로그인 성공');
    //     } catch (error) {
    //       print('카카오계정으로 로그인 실패 $error');
    //     }
    //   }
    // } else {
    //   try {
    //     await UserApi.instance.loginWithKakaoAccount();
    //     print('카카오계정으로 로그인 성공');
    //   } catch (error) {
    //     print('카카오계정으로 로그인 실패 $error');
    //   }
    // }
    // try {

    //   // OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
    //   // print('카카오계정으로 로그인 성공 ${token.accessToken}');
    //   // isLoggedIn.value = true;
    //   // 사용자 정보 가져오기
    //   User user = await UserApi.instance.me();
    //   print('사용자 정보: ${user.id}, ${user.kakaoAccount?.profile?.nickname}, ${user.kakaoAccount?.profile?.profileImageUrl}');

    //   // AuthService에 토큰과 사용자 정보 전달
    //   _authService.checkAccount('kakao', user.id.toString());

    // } catch (error) {
    //   print('카카오계정으로 로그인 실패 $error');
    //   isLoggedIn.value = false;
    //   accessToken.value = '';
    // }
  }

  // Future<void> logoutFromKakao() async {
  //   try {
  //     await UserApi.instance.unlink();
  //     print('카카오계정으로부터 로그아웃 성공');
  //     isLoggedIn.value = false;
  //     accessToken.value = '';
  //     userId.value = '';
  //     nickname.value = '';
  //     profileImageUrl.value = '';
  //   } catch (error) {
  //     print('카카오계정으로부터 로그아웃 실패 $error');
  //   }
  // }
