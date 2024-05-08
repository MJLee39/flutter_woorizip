import 'dart:convert';

import 'package:get/get.dart';
import 'package:testapp/utils/api_config.dart';
import 'package:http/http.dart' as http;

class ReportController extends GetxController {

  final RxString error = ''.obs;
  final RxSet<String> nicknameSet = <String>{}.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchMyReportList(String accountId) async {
    var url = '${ApiConfig.reportApiEndpointUrl}/$accountId/list';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Set<dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        nicknameSet.assignAll(jsonData.map((data) => data.toString()).toSet());
      }
    } catch(e) {
      error.value = 'Error fetching data: $e';
    }
  }

}