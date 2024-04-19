import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SearchButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text('조회하기'),
    );
  }


}
