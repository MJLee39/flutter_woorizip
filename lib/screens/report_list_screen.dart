import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/account/account_controller.dart';
import 'package:testapp/controllers/report_controller.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';

class ReportListScreen extends StatelessWidget {

  const ReportListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ReportController());
    return Scaffold(
      appBar: AppBarWidget(title: '신고한 사용자',),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GetBuilder<ReportController>(
              builder: (controller) {
                controller.fetchMyReportList(AccountController().id);
                final nicknameSet = controller.nicknameSet.toList();

                final List<DataRow> rows = nicknameSet.map((nickname) {
                  return DataRow(
                    cells: [
                      DataCell(Text(nickname)),
                    ],
                  );
                }).toList();

                return DataTable(
                  columns: [
                    DataColumn(label: Text('신고한 사용자')),
                  ],
                  rows: rows,
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
