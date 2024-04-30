import 'package:flutter/material.dart';
import 'package:testapp/utils/app_colors.dart';

class UpdateButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const UpdateButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 0,
      right: 0,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: AppColors.mainColorTest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: const Size(double.infinity, 60),
        ),
        onPressed: onPressed,
        child: Text(text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}