import 'package:flutter/material.dart';
import 'package:testapp/account/account_controller.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/widgets/half_button_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/widgets/text_header_widget.dart';
import 'package:testapp/widgets/home/zip_registration_button_widget.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _accountController = Get.put(AccountController());
    return Scaffold(
      appBar: const AppBarWidget(),
      body: PageNormalPaddingWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const TextHeaderWidget(text: "어떤 집을 찾고 계신가요?"),
            const SizedBox(height: 30),
            if (_accountController.role == "Agent")
            const ZipRegistratitionButtonWidget(),

           
            const Row(
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
            const SizedBox(height: 10),
            const Row(
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
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}