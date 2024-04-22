import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/condition_read_all_controller.dart';

class ReadAllWidget extends StatefulWidget {
  const ReadAllWidget({super.key});

  @override
  State<ReadAllWidget> createState() => _ReadAllWidgetState();
}

class _ReadAllWidgetState extends State<ReadAllWidget> {
  final ConditionReadAllController controller =
      Get.find<ConditionReadAllController>();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
