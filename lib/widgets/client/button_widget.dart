import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final int buttonNumber;

  const ButtonWidget({super.key, required this.buttonNumber});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text('Button $buttonNumber'),
    );
  }
}
