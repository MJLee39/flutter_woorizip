import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:testapp/utils/api_config.dart';

class AdminController extends GetxController {
  final RxString error = ''.obs;
  final RxList<AccountInfo> accountList = <AccountInfo>[].obs;
  final RxList<AccountAndReport> accountAndReportList = <AccountAndReport>[].obs;
  final RxList<String> accountIdList = <String>[].obs;
  RxString searchKeyword = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAccountData();
  }

  void search(String keyword) {
    searchKeyword.value = keyword;
    update();
  }

  Future<void> fetchAccountData() async {
    const url = "${ApiConfig.apiAccountReadAllUrl}";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));

        accountList.assignAll(jsonData.map((data) {
          accountIdList.add(data['accountId']);
          return AccountInfo.fromJson(data);
        }).toList());

        fetchAllReportCount();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      error.value = 'Error fetching data: $e';
    }
  }

  Future<void> fetchAllReportCount() async {
    const url = "${ApiConfig.chatApiEndpointUrl}/report/all/size";

    try {
      final response = await http.post(Uri.parse(url),
        headers: {
          'content-type': 'application/json'
        },
        body: jsonEncode({
          'allAccountId': accountIdList.toList()
        })
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        accountAndReportList.assignAll(jsonData.map((data) => AccountAndReport.fromJson(data)).toList());
        updateAccountReports();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      error.value = 'Error fetching data: $e';
    }
  }

  void updateAccountReports() {
    for (var accountAndReport in accountAndReportList) {
      var accountInfo = accountList.firstWhere((account) => account.accountId == accountAndReport.accountId);
      accountInfo.updateReport(accountAndReport.reportSize);
    }
    update();
  }

  Future<void> blockAccount(String accountId) async {
    var url = "${ApiConfig.apiAccountLockUrl}/$accountId/lock";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json'
        },
        body: {
          'accountId': accountId
        }
      );

      if (response.statusCode == 200) {
        Get.dialog(
          AlertDialog(
            title: Text('Success'),
            content: Text('Account blocked successfully'),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      error.value = 'Error fetching data: $e';
    }
  }

  Future<void> unblockAccount(String accountId) async {
    var url = "${ApiConfig.apiAccountLockUrl}/$accountId/unlock";

    try {
      final response = await http.post(
          Uri.parse(url),
          headers: {
            'content-type': 'application/json'
          },
          body: {
            'accountId': accountId
          }
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        accountAndReportList.assignAll(jsonData.map((data) => AccountAndReport.fromJson(data)).toList());
        updateAccountReports();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      error.value = 'Error fetching data: $e';
    }
  }

  void sortAccountListByReport() {
    accountList.sort();
    update();
  }

  Future<void> fetchCertification(String accountId) async {
    const url = "http://localhost:8080/certification";

    try {
      final response = await http.post(
          Uri.parse(url),
          headers: {
            'content-type': 'application/json'
          },
          body: {
            'accountId': accountId
          }
      );

      if (response.statusCode == 200) {
        final imageUrl = jsonDecode(response.body)['imageUrl']; // 이미지 URL 가져오기
        Get.dialog(
          AlertDialog(
            title: Text('Success'),
            content: Image.network('https://example.com/image.png'),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: Text('승인'),
              ),
              TextButton(
                onPressed: () => Get.back(),
                child: Text('거절'),
              ),
              TextButton(
                onPressed: () => Get.back(),
                child: Text('확인'),
              ),
            ],
          ),
        );
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      error.value = 'Error fetching data: $e';
    }
  }

}

class AccountInfo implements Comparable<AccountInfo> {
  final String accountId;
  final String nickname;
  final String provider;
  final String providerId;
  final String role;
  int report = 0;

  AccountInfo(this.accountId, this.nickname, this.provider, this.providerId, this.role);

  factory AccountInfo.fromJson(Map<String, dynamic> json) {
    return AccountInfo(
      json['accountId'],
      json['nickname'],
      json['provider'],
      json['providerId'],
      json['role'],
    );
  }

  void updateReport(int report) {
    this.report = report;
  }

  @override
  int compareTo(AccountInfo other) {
    return other.report - this.report;
  }

}

class AccountAndReport {

  final String accountId;
  final int reportSize;

  AccountAndReport(this.accountId, this.reportSize);

  factory AccountAndReport.fromJson(Map<String, dynamic> json) {
    return AccountAndReport(
      json['accountId'],
      json['reportSize'],
    );
  }

}
