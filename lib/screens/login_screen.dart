import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/google_login_button_widget.dart';
import 'package:testapp/widgets/kakao_login_button_widget.dart';
import 'package:testapp/widgets/naver_login_button_widget.dart';
import 'package:testapp/widgets/other_login_small_button_widget%20copy.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '3초만에 로그인 하고',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '멋진 우리집을 찾아보세요!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 20),
                  KakaoLoginButtonWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('다른 방법으로 시작하기', style: TextStyle(color: Colors.grey, fontSize: 14)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OtherLoginSmallButtonWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
