import 'package:flutter/material.dart';
import 'package:testapp/utils/app_colors.dart';

class BottomNavbarButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const BottomNavbarButton({super.key, 
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: const BoxDecoration(
            color: AppColors.mainColorTest,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}