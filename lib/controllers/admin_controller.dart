import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AdminController extends GetxController {
  final RxString error = ''.obs;
  final RxList<AccountInfo> accountList = <AccountInfo>[].obs;
  final RxList<AccountAndReport> accountAndReportList = <AccountAndReport>[].obs;
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
    accountList.assignAll({
      AccountInfo('1', 'User1', 'Google', 'google123', "AGENT"),
      AccountInfo('2', 'User2', 'Facebook', 'facebook456', "USER"),
      AccountInfo('3', 'User3', 'Twitter', 'twitter789', "AGENT"),
      AccountInfo('4', 'User4', 'GitHub', 'github101112', "USER"),
    });
    // const url = "http://localhost:8080";
    //
    // try {
    //   final response = await http.get(Uri.parse(url));
    //
    //   if (response.statusCode == 200) {
    //     List<dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));
    //     accountList.assignAll(jsonData.map((data) => AccountInfo.fromJson(data)).toList());
    //     fetchAllReportCount();
    //   } else {
    //     throw Exception('Failed to load data: ${response.statusCode}');
    //   }
    // } catch (e) {
    //   error.value = 'Error fetching data: $e';
    // }
  }

  Future<void> fetchAllReportCount() async {
    const url = "http://localhost:8080/report";

    try {
      final response = await http.get(Uri.parse(url));

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
      if (accountInfo != null) {
        accountInfo.updateReport(accountAndReport.report);
      }
    }
    update();
  }

  Future<void> blockAccount(String accountId) async {
    const url = "http://localhost:8080/block";

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
    const url = "http://localhost:8080/block";

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

  Future<void> fetchCertification(String accountId) async {
    const url = "http://localhost:8080/block";

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

class AccountInfo {
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
}

class AccountAndReport {
  final String accountId;
  final int report;

  AccountAndReport(this.accountId, this.report);

  factory AccountAndReport.fromJson(Map<String, dynamic> json) {
    return AccountAndReport(
      json['accountId'],
      json['report'],
    );
  }
}
