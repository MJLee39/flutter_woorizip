import 'package:flutter/material.dart';


class PageNormalPaddingWidget extends StatelessWidget {
  final Widget child;


  const PageNormalPaddingWidget({super.key, required this.child});


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
        child: child,
    );
  }
}
