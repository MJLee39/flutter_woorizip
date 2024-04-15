import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/screens/AddressSearchScreen.dart';
import 'package:testapp/screens/ZipFindScreen.dart'; // ZipFindScreen import 추가
import 'package:testapp/utils/AppColors.dart';
import 'package:testapp/widgets/AppBarWidget.dart';
import 'package:testapp/widgets/BottomNavigationWidget.dart';
import 'package:testapp/widgets/TextHeaderWidget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

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
                  Get.to(() => AddressSearchScreen(),
                      transition: Transition.cupertino);
                },
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.mainColorTest,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
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
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size(0, 80),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                          side: BorderSide(
                            color: Colors.grey[300]!,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'images/icon_oneroom.png',
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            '원룸',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size(0, 80),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                          side: BorderSide(
                            color: Colors.grey[300]!,
                            width: 1.0,
                          ),
                        ),
                      ),
                     child: Column(
                        children: [
                          Image.asset(
                            'images/icon_twomore.png',
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            '투룸+',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Get.to(() => const ZipFindScreen());
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size(0, 80),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                          side: BorderSide(
                            color: Colors.grey[300]!,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'images/icon_op.png',
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            '오피스텔',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size(0, 80),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                          side: BorderSide(
                            color: Colors.grey[300]!,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'images/icon_apt.png',
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            '아파트',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
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
