import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/set_details_controller.dart';
import 'package:testapp/widgets/client/number_input_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';

class SetFeeWidget extends StatelessWidget {
  final SetDetailsController controller = Get.find<SetDetailsController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Row(
        children: [
          const Expanded(
            child: Text(
              "가격대: ~",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: NumberInputWidget(
              onChanged: (int? newValue) {
                controller.fee = newValue ?? 0;
              },
            ),
          ),
          const Expanded(
            child: Text(
              "만원까지",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
