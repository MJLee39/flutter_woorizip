import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ConditionController extends GetxController {
  late String id = '';
  late String accountId = 'accountId01';
  late String si = '';
  late String gu = '';
  late String dong = '';
  late String location = '';
  late String buildingType = '';
  late int fee = 0;
  late DateTime moveInDate = DateTime.now();
  late String hashtag = '';
  late RxList<Map<String, dynamic>> jsonData = <Map<String, dynamic>>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final String additionalArgument = 'accountId01';

  // String url =
  //     'http://10.0.2.16:8093/condition/readAll/$additionalArgument';

  /*
  save
   */
  Future<void> saveCondition() async {
    isLoading.value = true;

    try {
      print('** in Save --------------');

      String url = 'http://localhost:8093/condition/save';

      String input = jsonEncode({
        'location': location,
        'accountId': "accountId01",
        'buildingType': buildingType,
        'fee': fee,
        'moveInDate': moveInDate.toIso8601String(),
        'hashtag': hashtag,
      });

      print('** input: $input');

      final response = await http.post(Uri.parse(url),
          headers: {'content-type': 'application/json'}, body: input);
      if (response.statusCode == 200) {
        List<dynamic> responseData =
            jsonDecode(utf8.decode(response.bodyBytes));
        jsonData.assignAll(responseData.cast<Map<String, dynamic>>());
      } else if (response.statusCode == 204) {
        Get.snackbar(
          '알림',
          '이미 등록된 조건이 있어요!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.indigo,
          colorText: Colors.white,
        );
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }

    } catch (e) {
      error.value = 'Error fetching data: $e';
    } finally {
      isLoading.value = false;
    }
  }


  /*
  readAll
   */
  @override
  void onInit() {
    super.onInit();
    readAllCondition();
  }

  Future<void> readAllCondition() async {
    isLoading.value = true;

    try {
      print('** in readAll --------------');
      print('** accountId: $accountId');

      String url =
          'http://localhost:8093/condition/readAll/$accountId';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> responseData =
        jsonDecode(utf8.decode(response.bodyBytes));
        jsonData.assignAll(responseData.cast<Map<String, dynamic>>());
        print('** in controller try, respose: OK');
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      error.value = 'Error fetching data: $e';
    } finally {
      isLoading.value = false;
    }
  }

  /*
  update
   */
  Future<void> updateCondition() async {
    isLoading.value = true;

    try {
      String url =
          'http://localhost:8093/condition/update';

      print('** in Update --------------');

      String input = jsonEncode({
        'id': id,
        'location': location,
        'accountId': accountId,
        'buildingType': buildingType,
        'fee': fee,
        'moveInDate': moveInDate.toIso8601String(),
        'hashtag': hashtag,
      });

      print("** parsing check -> input: $input");

      final response = await http.post(
          Uri.parse(url),
          headers: {'content-type': 'application/json'},
          body: input
      );

      if (response.statusCode == 200) {
        List<dynamic> responseData =
        jsonDecode(utf8.decode(response.bodyBytes));
        jsonData.assignAll(responseData.cast<Map<String, dynamic>>());
        print('** in update controller try, respose: OK');
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      error.value = 'Error fetching data: $e';
    } finally {
      isLoading.value = false;
    }
  }

  /*
  delete
   */
  Future<void> deleteCondition() async {
    isLoading.value = true;

    try {
      print('** in Delete --------------');

      String url =
          'http://localhost:8093/condition/delete/$id';
      // String url =
      //     'http://10.0.2.16:8093/condition/readAll/$additionalArgument';

      print("** url check -> uri: $url");

      final response = await http.delete(
        Uri.parse(url),
        headers: {'content-type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> responseData =
        jsonDecode(utf8.decode(response.bodyBytes));
        jsonData.assignAll(responseData.cast<Map<String, dynamic>>());
        print('** in delete controller try, respose: OK');
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
