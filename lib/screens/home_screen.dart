import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/screens/address_search_screen.dart';
import 'package:testapp/utils/app_colors.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/widgets/half_button_widget.dart';
import 'package:testapp/widgets/text_header_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const TextHeaderWidget(text: "어떤 집을 찾고 계신가요?"),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Get.toNamed('/addressSearch');
                },
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.mainColorTest,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                    side: BorderSide(
                      color: Colors.grey[300]!,
                      width: 1.0,
                    ),
                  ),
                  minimumSize: const Size(double.infinity, 80),
                ),
                child: const Row(
                  children: [
                    SizedBox(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Image(
                          image: AssetImage('images/icon_house.png'),
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '집을 소개해 주고 싶어요 ️',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '공인중개사라면 예비 임차인들에게 집을 소개 해줄 수 있어요! ️',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  HalfButtonWidget(
                      text: "원룸",
                      imagePath: "images/icon_oneroom.png",
                      urlPath: "/map/oneroom"
                  ),
                  SizedBox(width: 10),
                  HalfButtonWidget(
                      text: "투룸+",
                      imagePath: "images/icon_twomore.png",
                      urlPath: "/login"
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  HalfButtonWidget(
                      text: "오피스텔",
                      imagePath: "images/icon_officetel.png",
                      urlPath: "/zipFind"
                  ),
                  SizedBox(width: 10),
                  HalfButtonWidget(
                      text: "아파트",
                      imagePath: "images/icon_apart.png",
                      urlPath: "urlPath"
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
