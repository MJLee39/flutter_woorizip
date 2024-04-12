import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:testapp/screens/AddressSearchScreen.dart';
import 'package:testapp/screens/HomeScreen.dart';
import 'package:testapp/screens/ZipFindScreen.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: '/',
    getPages: [
      GetPage(name: '/', page: () => const HomeScreen(), transition: Transition.noTransition),
      GetPage(name: '/addressSearch', page: () => AddressSearchScreen(), transition: Transition.noTransition),
      GetPage(name: '/zipFind', page: () => const ZipFindScreen(), transition: Transition.noTransition),
    ],
  ));
}