import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              const SizedBox(height: 30),
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
                  minimumSize: Size(0, 100),
                ),
                child: const Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Image(
                          image: AssetImage('assets/images/icon_house.png'),
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ),
                    SizedBox(width: 8), // 이미지와 텍스트 사이 간격 조정
                    Expanded(
                      
                      flex: 5, // 텍스트 영역이 이미지보다 더 많은 공간을 차지하도록 조정
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '집을 소개할게요 ️',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '예비 임차인들에게 집을 소개해 줄 수 있어요! ️',
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
              const SizedBox(height: 20),
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
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}