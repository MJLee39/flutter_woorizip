// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:get/get.dart';
//
// class ConditionDeleteController extends GetxController {
//   late String id = '';
//   late RxBool isLoading = true.obs;
//   late RxString error = ''.obs;
//   final RxList<Map<String, dynamic>> jsonData = <Map<String, dynamic>>[].obs;
//
//   Future<void> fetchData() async {
//     isLoading.value = true;
//
//     try {
//       print('** in Delete --------------');
//
//       String input = jsonEncode({
//         'id': id,
//       });
//
//       String url =
//           'http://localhost:8093/condition/delete/$input';
//       // String url =
//       //     'http://10.0.2.16:8093/condition/readAll/$additionalArgument';
//
//       print("** url check -> uri: $url");
//
//       final response = await http.delete(
//           Uri.parse(url),
//           headers: {'content-type': 'application/json'},
//       );
//
//       if (response.statusCode == 200) {
//         List<dynamic> responseData =
//         jsonDecode(utf8.decode(response.bodyBytes));
//         jsonData.assignAll(responseData.cast<Map<String, dynamic>>());
//         print('** in delete controller try, respose: OK');
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