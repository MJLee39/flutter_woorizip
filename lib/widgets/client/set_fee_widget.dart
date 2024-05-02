import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/condition_controller.dart';
import 'package:testapp/widgets/client/number_input_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';

class SetFeeWidget extends StatefulWidget {

  final Function(int)? onChanged;

  const SetFeeWidget({super.key, this.onChanged});

  @override
  State<SetFeeWidget> createState() => _SetFeeWidgetState();
}

class _SetFeeWidgetState extends State<SetFeeWidget> {
  final ConditionController controller = Get.find<ConditionController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Row(
            children: [
              SizedBox(
                width: 300, // Slider의 폭을 300으로 고정
                child: Slider(
                  value: controller.fee.toDouble(),
                  min: 0,
                  max: 500,
                  divisions: 100,
                  onChanged: (double newValue) {
                    setState(() {
                      controller.fee = newValue.toInt();
                    });
                    if (widget.onChanged != null) {
                      widget.onChanged!(newValue.toInt());
                    }
                  },
                  activeColor: Colors.blue,
                  inactiveColor: Colors.grey,
                ),
              ),
              SizedBox(
                width: 100, // Text의 폭을 100으로 고정
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    '${controller.fee} 만원',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
