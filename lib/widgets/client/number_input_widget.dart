import 'package:flutter/material.dart';

class NumberInputWidget extends StatelessWidget {
  const NumberInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        labelText: 'Enter a number',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
    );
  }
}