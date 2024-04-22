import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NumberInputWidget extends StatelessWidget {
  final ValueChanged<int>? onChanged;

  const NumberInputWidget({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        labelText: '최대값',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      onChanged: (String newValue) {
        int? intValue = int.tryParse(newValue);
        if (intValue != null && onChanged != null) {
          onChanged!(intValue);
        }
      },
    );
  }
}
