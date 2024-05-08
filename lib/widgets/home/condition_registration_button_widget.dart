import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/utils/app_colors.dart';

class ConditionRegistrationButtonWidget extends StatelessWidget {
  const ConditionRegistrationButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextButton(
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
                minimumSize: const Size(0, 100),
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.find_in_page_outlined, size: 40, color: Colors.white,)
                    ),
                  ),
                  SizedBox(width: 8), // 이미지와 텍스트 사이 간격 조정
                  Expanded(
                    
                    flex: 5, // 텍스트 영역이 이미지보다 더 많은 공간을 차지하도록 조정
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '내 집을 찾고 싶어요 ️',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '수백명의 중개사에게\n내가 원하는 조건을 알려 줄 수 있어요 ️',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}