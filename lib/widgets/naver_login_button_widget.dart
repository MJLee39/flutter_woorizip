import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:testapp/utils/app_colors.dart';

class NaverLoginButtonWidget extends StatelessWidget {
  const NaverLoginButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Get.toNamed('/');
      },
      style: TextButton.styleFrom(
        backgroundColor: AppColors.naverColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          // side: BorderSide(
          //   color: Colors.grey[300]!,
          //   width: 1.0, 
          // ),
        ),
        minimumSize: const Size(double.infinity, 60),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: SvgPicture.asset(
                'images/icon_naver_white.svg',
                width: 30,
                height: 30,
              )
            ),
          ),
          const Text(
            '네이버 로그인',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}