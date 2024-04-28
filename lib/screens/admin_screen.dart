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
            Padding(
              padding: const EdgeInsets.all(20.0),
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
            GetBuilder<AdminController>(
              builder: (controller) {
                var filteredList = controller.accountList.where((account) =>
                account.accountId.toLowerCase().contains(
                    controller.searchKeyword.value.toLowerCase()) ||
                    account.nickname.toLowerCase().contains(
                        controller.searchKeyword.value.toLowerCase()) ||
                    account.provider.toLowerCase().contains(
                        controller.searchKeyword.value.toLowerCase()) ||
                    account.providerId.toLowerCase().contains(
                        controller.searchKeyword.value.toLowerCase()));

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    var account = filteredList.elementAt(index);
                    return Card(
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                        title: Text('Account ID: ${account.accountId}'),
                        subtitle: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Nickname',
                                  ),
                                  Text(
                                    '${account.nickname}',
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Provider',
                                  ),
                                  Text(
                                    '${account.provider}',
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'ProviderId',
                                  ),
                                  Text(
                                    '${account.providerId}',
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Role',
                                  ),
                                  Text(
                                    '${account.role}',
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Report',
                                  ),
                                  Text(
                                    '${account.report}',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                // Add your report-related logic here
                                controller.blockAccount(account.accountId);
                              },
                              icon: Icon(Icons.block),
                            ),
                            IconButton(
                              onPressed: () {
                                // Add your photo-related logic here
                                print('Photo button pressed');
                              },
                              icon: Icon(Icons.photo),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
