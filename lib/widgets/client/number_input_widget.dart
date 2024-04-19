import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NumberInputWidget extends StatelessWidget {
  const NumberInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        labelText: '최대값',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
    );
  }
}