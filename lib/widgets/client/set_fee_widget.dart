import 'package:flutter/material.dart';
import 'package:testapp/widgets/client/number_input_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';

class SetFeeWidget extends StatelessWidget {
  const SetFeeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        width: 300,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                "가격대: ~",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(child: NumberInputWidget()),
            Expanded(
              child: Text(
                "만원까지",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ));
  }
}
