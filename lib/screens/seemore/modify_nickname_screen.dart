import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/account/account_controller.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/bottom_navbar_button.dart';
import 'package:testapp/widgets/rounded_input_widget.dart';

class ModifyNickNameScreen extends StatelessWidget {
  const ModifyNickNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AccountController _accountController = Get.find<AccountController>();
    TextEditingController _textController = TextEditingController(text: _accountController.nickname);
    return Scaffold(
      appBar: const AppBarWidget(title: '이름 변경'),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const ListTile(
              title: Text('이름', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.grey)),
              subtitle: Text('나를 잘 표시할 수 있는 이름을 10글자 이내로 입력해주세요.', style: TextStyle(fontSize: 14, color: Colors.grey)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: RoundInputWidget(
                hint: _accountController.nickname, textController: _textController,)
            ),
          
        ],
      ),
      bottomNavigationBar: BottomNavbarButton(label: '변경', onTap: () {
          _accountController.nickname = _textController.text;
          Get.snackbar('변경 완료', '이름이 변경되었습니다.');          
          Navigator.of(context).pop(); // 화면 닫기
      }),

    );
  }
}