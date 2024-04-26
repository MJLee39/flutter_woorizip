// import 'dart:convert';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;
// import 'package:get/get.dart';
//
// class ConditionUpdateController extends GetxController {
//   late String id = '';
//   late String accountId = '';
//   late String location = '';
//   late String buildingType = '';
//   late int fee = 0;
//   late DateTime moveInDate = DateTime.now();
//   late String hashtag = '';
//   late RxList<Map<String, dynamic>> jsonData = <Map<String, dynamic>>[].obs;
//   late RxBool isLoading = true.obs;
//   late RxString error = ''.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchData();
//   }
//
//   Future<void> fetchData() async {
//     isLoading.value = true;
//
//     try {
//       String url =
//           'http://localhost:8093/condition/update';
//       // String url =
//       //     'http://10.0.2.16:8093/condition/readAll/$additionalArgument';
//       print('** in ConditionUpdateController, before parsing--------------');
//
//       String input = jsonEncode({
//         'id': id,
//         'location': location,
//         'accountId': accountId,
//         'buildingType': buildingType,
//         'fee': fee,
//         'moveInDate': moveInDate.toIso8601String(),
//         'hashtag': hashtag,
//       });
//
//       print("** parsing check -> input: $input");
//
//       final response = await http.post(
//         Uri.parse(url),
//           headers: {'content-type': 'application/json'},
//           body: input
//       );
//
//       if (response.statusCode == 200) {
//         List<dynamic> responseData =
//         jsonDecode(utf8.decode(response.bodyBytes));
//         jsonData.assignAll(responseData.cast<Map<String, dynamic>>());
//         print('** in update controller try, respose: OK');
//       } else {
//         throw Exception('Failed to load data: ${response.statusCode}');
//       }
//     } catch (e) {
//       error.value = 'Error fetching data: $e';
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }