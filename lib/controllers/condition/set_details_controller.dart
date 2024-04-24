import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class SetDetailsController extends GetxController {
  late RxString accountId = 'accountId01'.obs;
  late RxString si = ''.obs;
  late RxString gu = ''.obs;
  late RxString dong = ''.obs;
  late RxString location = ''.obs;
  late RxString buildingType = ''.obs;
  late int fee = 0;
  late DateTime moveInDate = DateTime.now();
  late RxString hashtag = ''.obs;
  final RxBool isLoading = true.obs;
  final RxList<Map<String, dynamic>> jsonData = <Map<String, dynamic>>[].obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      String url = 'http://localhost:8093/condition/save';

      String input = jsonEncode({
        'location': location.value,
        'accountId': accountId.value,
        'buildingType': buildingType.value,
        'fee': fee,
        'moveInDate': moveInDate.toIso8601String(),
        'hashtag': hashtag.value,
      });

      print('in set details controller, input: $input');

      final response = await http.post(Uri.parse(url),
          headers: {'content-type': 'application/json'}, body: input);
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
