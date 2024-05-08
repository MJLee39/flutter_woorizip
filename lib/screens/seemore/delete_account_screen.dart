import 'package:flutter/material.dart';
import 'package:testapp/account/account_controller.dart';
import 'package:testapp/utils/app_colors.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:get/get.dart';

class DeleteAccountScreen extends StatefulWidget {
 const DeleteAccountScreen({super.key});

 @override
 _DeleteAccountScreenState createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
 bool _isChecked = false;

 @override
 Widget build(BuildContext context) {
  AccountController _accountController = Get.find<AccountController>();
   return Scaffold(
     appBar: const AppBarWidget(
       title: '회원 탈퇴',
     ),
     body: Column(
       children: [
         PageNormalPaddingWidget(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               const SizedBox(height: 10),
               const Text(
                 '아래 사항을 꼭 확인해 주세요!',
                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
               ),
               const SizedBox(height: 20),
               const Text(
                 '탈퇴 시 우리집 서비스 이용에 제한이 생깁니다.',
                 style: TextStyle(fontSize: 18),
               ),
               const SizedBox(height: 10),
               const Text(
                 '아이디, 회원 정보 등 모든 데이터는 삭제되며, 복구할 수 없습니다.',
                 style: TextStyle(fontSize: 18, color: Colors.red),
               ),
               const SizedBox(height: 10),
               const Text(
                 '탈퇴 후 30일 이내 재가입이 불가능합니다.',
                 style: TextStyle(fontSize: 18),
               ),
               const SizedBox(height: 10),
               const Divider(
                 color: Colors.grey,
                 height: 20,
                 thickness: 0.5,
               ),
             ],
           ),
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Checkbox(
               value: _isChecked,
               checkColor: Colors.white,
                activeColor: AppColors.mainColorTest,
               onChanged: (value) {
                 setState(() {
                   _isChecked = value!;
                 });
               },
             ),
             const Text(
               '위 내용을 모두 확인했으며, 회원 탈퇴에 동의합니다.',
               style: TextStyle(fontSize: 16),
             ),
           ],
         ),
       ],
     ),
     bottomSheet: Container(
       width: double.infinity,
       height: 60,
       color: AppColors.mainColorTest,
       child: TextButton(
         onPressed: () async {
          if (_isChecked) {
            // 탈퇴 처리
            bool deleted = await _accountController.deleteAccount();
            if (deleted) {
              Get.snackbar('알림', '회원 탈퇴가 완료되었습니다.');
              Get.offAllNamed('/login');
            } else {
              Get.snackbar('알림', '회원 탈퇴에 실패했습니다.');
            }

          } else {
            Get.snackbar('알림', '동의 후 탈퇴가 가능합니다.');
          }
           // 탈퇴 처리
         },
         child: const Text(
           '회원 탈퇴',
           style: TextStyle(color: Colors.white, fontSize: 20),
         ),
       ),
     ),
   );
 }
}