import 'package:flutter/material.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/widgets/half_button_widget.dart';
import 'package:testapp/widgets/home/get_button_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/widgets/text_header_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(),
      body: PageNormalPaddingWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextHeaderWidget(text: "어떤 집을 찾고 계신가요?"),
            SizedBox(height: 30),
            GetButtonWidget(),
            Row(
              children: [
                HalfButtonWidget(
                  text: "원룸",
                  imagePath: "assets/images/icon_oneroom.png",
                  urlPath: "/zipFind",
                  additionalArgument: "원룸",
                ),
                SizedBox(width: 10),
                HalfButtonWidget(
                  text: "투룸+",
                  imagePath: "assets/images/icon_twomore.png",
                  urlPath: "/zipFind",
                  additionalArgument: "투룸",
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                HalfButtonWidget(
                  text: "오피스텔",
                  imagePath: "assets/images/icon_officetel.png",
                  urlPath: "/zipFind",
                  additionalArgument: "오피스텔",
                ),
                SizedBox(width: 10),
                HalfButtonWidget(
                  text: "아파트",
                  imagePath: "assets/images/icon_apart.png",
                  urlPath: "/zipFind",
                  additionalArgument: "아파트",
                ),
              ],
            ),
          
            // SizedBox(
            //   height: 90,
            // ),
            // Image.asset(
            //   'assets/images/advert.png',
            //   fit: BoxFit.cover,
            //
            // ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(),
    );
  }
  
}

