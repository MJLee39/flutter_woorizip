import 'package:flutter/material.dart';
import 'package:testapp/account/account_controller.dart';
import 'package:testapp/widgets/home/zip_registration_button_widget.dart';
import 'package:get/get.dart';
import 'package:testapp/widgets/home/condition_registration_button_widget.dart';



class GetButtonWidget extends StatelessWidget {
  const GetButtonWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final accountController = Get.find<AccountController>();
    if (accountController.role == "Agent") {
      return const ZipRegistratitionButtonWidget();
    } else if (accountController.role == "User") {
      return const ConditionRegistrationButtonWidget();
    } else {
     return const ConditionRegistrationButtonWidget();
    }
  }
}
