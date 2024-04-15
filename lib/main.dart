import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/NavigationController.dart';
import 'package:testapp/screens/AddressSearchScreen.dart';
import 'package:testapp/screens/HomeScreen.dart';
import 'package:testapp/screens/ZipFindScreen.dart';


void main() {
  runApp(GetMaterialApp(
    
    initialBinding: BindingsBuilder(() {
      Get.put(NavigationController());
    }),
    
    theme: ThemeData(
      fontFamily: 'Pretendard',
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      canvasColor: Colors.white, // 캔버스 색상 설정
      primaryColorLight: Colors.white, // 라이트 모드 기본 색상 설정
    ),
    darkTheme: ThemeData(
      fontFamily: 'Pretendard',
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white, // 다크 모드에서 배경색 강제 설정
      canvasColor: Colors.white, // 캔버스 색상 설정
      primaryColorLight: Colors.white, // 라이트 모드 기본 색상 설정
    ),
  
    initialRoute: '/',
    getPages: [
      GetPage(name: '/', page: () => const HomeScreen(), transition: Transition.noTransition),
      GetPage(name: '/addressSearch', page: () => AddressSearchScreen(), transition: Transition.noTransition),
      GetPage(name: '/zipFind', page: () => const ZipFindScreen(), transition: Transition.noTransition),
    ],
  ));
  FlutterNativeSplash.remove(); // 스플래시 화면 제거
}