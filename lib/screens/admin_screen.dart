import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/admin_controller.dart';

class AdminScreen extends StatelessWidget {
  AdminScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("관리자 페이지", textAlign: TextAlign.center),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GetBuilder<AdminController>(
              builder: (controller) {
                var filteredList = controller.accountList.where((account) =>
                account.accountId.toLowerCase().contains(
                    controller.searchKeyword.value.toLowerCase()) ||
                    account.nickname.toLowerCase().contains(
                        controller.searchKeyword.value.toLowerCase()) ||
                    account.provider.toLowerCase().contains(
                        controller.searchKeyword.value.toLowerCase()) ||
                    account.role.toLowerCase().contains(
                        controller.searchKeyword.value.toLowerCase()) ||
                    account.providerId.toLowerCase().contains(
                        controller.searchKeyword.value.toLowerCase()));

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: '검색',
                                  prefixIcon: Icon(Icons.search),
                                ),
                                onChanged: (value) {
                                  Get.find<AdminController>().search(value);
                                },
                              ),
                            ),
                            SizedBox(width: 20), // Add spacing between the text field and the button
                            ElevatedButton(
                              onPressed: () {
                                Get.find<AdminController>().sortAccountListByReport();
                              },
                              child: Text('신고 순으로 정렬'),
                            ),
                          ],
                        ),
                      ),
                      GetBuilder<AdminController>(
                        builder: (controller) {
                          var filteredList = controller.accountList.where((account) =>
                          account.accountId.toLowerCase().contains(
                              controller.searchKeyword.value.toLowerCase()) ||
                              account.nickname.toLowerCase().contains(
                                  controller.searchKeyword.value.toLowerCase()) ||
                              account.provider.toLowerCase().contains(
                                  controller.searchKeyword.value.toLowerCase()) ||
                              account.role.toLowerCase().contains(
                                  controller.searchKeyword.value.toLowerCase()) ||
                              account.providerId.toLowerCase().contains(
                                  controller.searchKeyword.value.toLowerCase()));

                          return DataTable(
                            columns: [
                              DataColumn(label: Text('Account ID')),
                              DataColumn(label: Text('Nickname')),
                              DataColumn(label: Text('Provider')),
                              DataColumn(label: Text('Provider ID')),
                              DataColumn(label: Text('Role')),
                              DataColumn(label: Text('Report')),
                              DataColumn(label: Text('Actions')),
                            ],
                            rows: filteredList.map((account) {
                              return DataRow(cells: [
                                DataCell(Text(account.accountId)),
                                DataCell(Text(account.nickname)),
                                DataCell(Text(account.provider)),
                                DataCell(Text(account.providerId)),
                                DataCell(Text(account.role)),
                                DataCell(Text(account.report.toString())), // Convert int to String
                                DataCell(Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        // Add your report-related logic here
                                        controller.blockAccount(account.accountId);
                                      },
                                      icon: Icon(Icons.block, color: Color(0xFF224488)),
                                    ),
                                    if (account.role == "AGENT" || account.role == "NOVICE")
                                    IconButton(
                                      onPressed: () {
                                        // Add your photo-related logic here
                                        controller.fetchCertification(account.accountId);
                                      },
                                      icon: Icon(Icons.photo, color: Color(0xFF224488)),
                                    ),
                                  ],
                                )),
                              ]);
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataItem(String label, dynamic value) {
    return Row(
      children: [
        Icon(Icons.label, color: Color(0xFF224488), size: 16), // Add icon to label
        SizedBox(width: 8), // Add spacing between icon and text
        Text(
          '$label:',
          style: TextStyle(color: Color(0xFF224488)),
        ),
        SizedBox(width: 8), // Add spacing between label and value
        Text(
          value.toString(), // Convert int to String
          style: TextStyle(color: Color(0xFF224488)),
        ),
      ],
    );
  }
}
