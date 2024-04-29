import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/condition_controller.dart';

class UserWriteWidget extends StatefulWidget {
  const UserWriteWidget({super.key});

  @override
  State<UserWriteWidget> createState() => _UserWriteWidgetState();
}

class _UserWriteWidgetState extends State<UserWriteWidget> {
  final ConditionController controller = Get.find<ConditionController>();
  final TextEditingController _textController = TextEditingController(); // 텍스트 컨트롤러

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _textController, // 텍스트 입력 컨트롤러
          decoration: const InputDecoration(
            labelText: '해시태그 입력',
            hintText: '(,)로 구분해주세요',
          ),
          onSubmitted: (String value) {
            setState(() {
              controller.hashtag += value;

              _textController.clear();
            });
          },
        ),
        Obx(() {
          // 컨트롤러의 hashtag 목록을 표시하는 위젯
          return ListView.builder(
            shrinkWrap: true,
            itemCount: controller.hashtag.length,
            itemBuilder: (context, index) {
              final hashtag = controller.hashtag[index];
              return ListTile(
                title: Text('#$hashtag'),
              );
            },
          );
        }),
      ],
    );
  }
}
