import 'dart:convert';

import 'package:get/get.dart';
import 'package:testapp/utils/api_config.dart';
import 'package:http/http.dart' as http;

class ReportController extends GetxController {

  final RxString error = ''.obs;
  final RxList<String> nicknameSet = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchMyReportList(String accountId) async {
    var url = '${ApiConfig.reportApiEndpointUrl}/$accountId/list';

    try {
      final response = await http.get(Uri.parse(url));
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      if (response.statusCode == 200) {
        Set<dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        jsonData.map((data) => data.toString()).toList();
        nicknameSet.assignAll(jsonData.map((data) => data.toString()).toList());
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch(e) {
      error.value = 'Error fetching data: $e';
    }
  }

}