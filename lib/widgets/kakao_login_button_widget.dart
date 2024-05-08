import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/kakao_login_controller.dart';
import 'package:testapp/utils/app_colors.dart';

class KakaoLoginButtonWidget extends StatelessWidget {
  const KakaoLoginButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(KakaoLoginController());
    return TextButton(
      onPressed: () {
        Get.find<KakaoLoginController>().loginWithKakao();
      },
      style: TextButton.styleFrom(
        backgroundColor: AppColors.kakaoColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
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
                'assets/images/icon_kakao.svg',
                width: 30,
                height: 30,
              )
            ),
          ),
          const Text(
            '카카오 로그인',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}