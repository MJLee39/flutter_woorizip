import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/screens/AddressSearchScreen.dart';
import 'package:testapp/screens/HomeScreen.dart';
import 'package:testapp/screens/ZipFindScreen.dart';

void main() {
  runApp(GetMaterialApp(
    theme: ThemeData(
        // 글꼴 설정
    fontFamily: 'Pretendard',
    brightness: Brightness.light,
        // scaffoldBackgroundColor를 흰색으로 설정하여 기본 배경을 흰색으로 만듭니다.
    scaffoldBackgroundColor: Colors.white,
  
    ),
    initialRoute: '/',
    getPages: [
      GetPage(name: '/', page: () => const HomeScreen(), transition: Transition.noTransition),
      GetPage(name: '/addressSearch', page: () => AddressSearchScreen(), transition: Transition.noTransition),
      GetPage(name: '/zipFind', page: () => const ZipFindScreen(), transition: Transition.noTransition),
    ],
  ));
}