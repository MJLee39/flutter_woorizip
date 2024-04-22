import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ConditionReadAllController extends GetxController {
  final RxString accountId = ''.obs;
  final RxList<Map<String, dynamic>> jsonData = <Map<String, dynamic>>[].obs;
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;
  late String additionalArgument;

  @override
  void onInit() {
    super.onInit();
    additionalArgument = Get.arguments;
    fetchData();
  }

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      // grpc에서 accountId 꺼내기
      String accountId = 'accountId01';
      String url = 'http://10.0.2.2/condition/readAll/$accountId';

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> responseData =
            jsonDecode(utf8.decode(response.bodyBytes));
        jsonData.assignAll(responseData.cast<Map<String, dynamic>>());
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      error.value = 'Error fetching data: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
