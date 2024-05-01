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
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;
  final String additionalArgument = 'accountId01';

  // String url =
  //     'http://10.0.2.16:8093/condition/readAll/$additionalArgument';

  /*
  is registered
   */
  Future<bool> isRegistered() async {
    isLoading.value = true;

    try {
      print('** in registered --------------');
      print('** accountId: $accountId');

      String url = 'http://localhost:8093/condition/isregistered/$accountId';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> responseData =
            jsonDecode(utf8.decode(response.bodyBytes));
        jsonData.assignAll(responseData.cast<Map<String, dynamic>>());

        bool isRegistered = jsonData.isNotEmpty;

        print('** response: OK. isRegistered: {$isRegistered}');
        return isRegistered;
      } else {
        print('Failed to load data: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      error.value = 'Error fetching data: $e';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

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
        print('** in save controller try, respose: OK');
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
  readOne
  */
  Future<void> readOneCondition() async {
    isLoading.value = true;

    try {
      print('** in ReadOne --------------');
      print("내 조건 있음 - 조회하자!!!!!!!!!");

      String accountId = jsonEncode({
        'accountId': "accountId01",
      });

      String url = 'http://localhost:8093/condition/read$accountId';

      print('** input: $accountId');

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> responseData =
            jsonDecode(utf8.decode(response.bodyBytes));
        jsonData.assignAll(responseData.cast<Map<String, dynamic>>());
        print('** in ReadOne controller try, respose: OK');
      } else if (response.statusCode == 204) {
        // no contnent: 요청 성공. 현재 페이지에서 벗어나지 않아도 됨
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
  Future<void> readAllCondition() async {
    isLoading.value = true;

    try {
      print('** in readAll --------------');

      String url = 'http://localhost:8093/condition/readAll';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> responseData =
            jsonDecode(utf8.decode(response.bodyBytes));
        jsonData.assignAll(responseData.cast<Map<String, dynamic>>());
        print('** in readAll controller try, respose: OK');
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
  readByWhere
  */
  Future<void> readByWhereCondition() async {
    isLoading.value = true;

    try {
      String url = 'http://localhost:8093//condition/readByWhere';

      print('** in readByWhere --------------');

      String input = jsonEncode({
        'id': id,
        'accountId': accountId,
        'location': location,
        'buildingType': buildingType,
        'fee': fee,
        'moveInDate': moveInDate.toIso8601String(),
        'hashtag': hashtag,
      });

      final response = await http.post(Uri.parse(url),
          headers: {'content-type': 'application/json'}, body: input);

      if (response.statusCode == 200) {
        List<dynamic> responseData =
            jsonDecode(utf8.decode(response.bodyBytes));
        jsonData.assignAll(responseData.cast<Map<String, dynamic>>());
        print('** in readByWhere controller try, respose: OK');
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
      String url = 'http://localhost:8093/condition/update';

      print('** in Update --------------');

      String input = jsonEncode({
        'id': id,
        'accountId': accountId,
        'location': location,
        'buildingType': buildingType,
        'fee': fee,
        'moveInDate': moveInDate.toIso8601String(),
        'hashtag': hashtag,
      });

      print("** parsing check -> input: $input");

      final response = await http.post(Uri.parse(url),
          headers: {'content-type': 'application/json'}, body: input);

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

      String url = 'http://localhost:8093/condition/delete/$id';

      print("** url check -> uri: $url");

      final response = await http.delete(
        Uri.parse(url),
        headers: {'content-type': 'application/json'},
      );

      if (response.statusCode == 200) {
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
