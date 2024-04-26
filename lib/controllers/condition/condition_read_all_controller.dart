// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:get/get.dart';
//
// class ConditionReadAllController extends GetxController {
//   late RxList<Map<String, dynamic>> jsonData = <Map<String, dynamic>>[].obs;
//   late RxBool isLoading = true.obs;
//   late RxString error = ''.obs;
//   final String additionalArgument = 'accountId01';
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
//       print('** in controller try, additionalArgument: $additionalArgument');
//
//       String url =
//           'http://localhost:8093/condition/readAll/$additionalArgument';
//       // String url =
//       //     'http://10.0.2.16:8093/condition/readAll/$additionalArgument';
//
//       final response = await http.get(Uri.parse(url));
//
//       if (response.statusCode == 200) {
//         List<dynamic> responseData =
//             jsonDecode(utf8.decode(response.bodyBytes));
//         jsonData.assignAll(responseData.cast<Map<String, dynamic>>());
//         print('** in controller try, respose: OK');
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
