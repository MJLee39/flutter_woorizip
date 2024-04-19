import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ZipListLocationController extends GetxController {
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
    isLoading.value = true; // 로딩 상태 시작

    try {
      final response = await http.get(Uri.parse('http://192.168.117.31/search?location='+additionalArgument));
      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(utf8.decode(response.bodyBytes));
        jsonData.assignAll(responseData.cast<Map<String, dynamic>>());
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      error.value = 'Error fetching data: $e'; // 에러 메시지 설정
    } finally {
      isLoading.value = false; // 로딩 상태 종료
    }
  }
}