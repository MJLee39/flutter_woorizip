import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/widgets/text_header_widget.dart';
import 'package:testapp/utils/app_colors.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';

class SeeMoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: PageNormalPaddingWidget(
        child: Column(
          children: [
            const TextHeaderWidget(text: "내 프로필"),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded( // Expanded로 감싸기 시작
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.mainColorTest, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(
                      'images/profile.jpg',
                      width: 150,
                      height: 150,
                    ),
                  ),
                ), // Expanded로 감싸기 끝
                Expanded( // Expanded로 감싸기 시작
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {
                          // 닉네임 변경 기능 구현
                        },
                        child: Text(
                          '닉네임 변경하기',
                          style: TextStyle(color: AppColors.mainColorTest, fontSize: 20),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // 로그아웃 기능 구현
                        },
                        child: Text(
                          '로그아웃',
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ), // Expanded로 감싸기 끝
              ],
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                // '/my_conditions' 경로로 이동
                Get.toNamed('/my_conditions');
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.mainColorTest),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.home_work_outlined,
                      color: AppColors.mainColorTest,
                      size: 30.0,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      '내가 쓴 조건 관리',
                      style: TextStyle(
                        fontSize: 25,
                        color: AppColors.mainColorTest
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                // '/my_listings' 경로로 이동
                Get.toNamed('/my_listings');
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.mainColorTest),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.holiday_village_rounded,
                      color: AppColors.mainColorTest,
                      size: 30.0,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      '내가 올린 매물 관리',
                      style: TextStyle(
                        fontSize: 25,
                        color: AppColors.mainColorTest
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(),
    );
  }
}