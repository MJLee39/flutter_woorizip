import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/report_controller.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';

class ReportListScreen extends StatelessWidget {

  const ReportListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ReportController());
    return Scaffold(
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GetBuilder<ReportController>(
              builder: (controller) {
                return SingleChildScrollView(
                  child: Column(
                    children: [

                    ],
                  )
                );
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(),
    );
  }

}
