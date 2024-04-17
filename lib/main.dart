import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:testapp/controllers/navigation_controller.dart';
import 'package:testapp/routes/app_pages.dart';
import 'package:testapp/services/auth_service.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // 로그인 상태 저장을 위해 GetStorage 초기화
  KakaoSdk.init(
    nativeAppKey: '13cde3afb1eff0fa97b72538ffc9cdf8',
    javaScriptAppKey: 'ece3176690e15f855c51937d1d07f3c7',
  );
  runApp(GetMaterialApp(
    initialBinding: BindingsBuilder(
      () {
        Get.put(NavigationController());
        Get.put(AuthService());
      },
    ),
    theme: ThemeData(
      fontFamily: 'Pretendard',
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      canvasColor: Colors.white,
      primaryColorLight: Colors.white,
    ),
    darkTheme: ThemeData(
      fontFamily: 'Pretendard',
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      canvasColor: Colors.white,
      primaryColorLight: Colors.white,
    ),
    initialRoute: AppPages.initial,
    getPages: AppPages.routes,
  ));

  FlutterNativeSplash.remove();
}
