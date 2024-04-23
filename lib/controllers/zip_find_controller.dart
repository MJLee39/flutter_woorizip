import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ZipFindController extends GetxController {
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



  void updateData(Iterable<Map<String, dynamic>> newData) {
    jsonData.assignAll(newData);
  }

  Future<void> fetchData() async {
    isLoading.value = true; // 로딩 상태 시작

    try {
      final response = await http.get(Uri.parse('http://localhost/search?buildingType='+additionalArgument));
      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(utf8.decode(response.bodyBytes));
        RxList<Map<String, dynamic>> premiumZip = RxList<Map<String, dynamic>>();
        jsonData.assignAll(responseData.cast<Map<String, dynamic>>());
        for (var data in jsonData) {
          if (DateTime.now().isBefore(data['premium'])) {
            premiumZip.add(data);
          }
        }
        premiumZip.shuffle();
        jsonData.insertAll(0, premiumZip);
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