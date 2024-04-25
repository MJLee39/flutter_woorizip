import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ZipRegistration extends GetxController {
  late RxString location = ''.obs;
  late RxString estate = ''.obs;
  late RxString attachments = ''.obs;
  late int total_floor = 0;
  late int building_floor = 0;
  late RxString image = ''.obs;
  late int deposit = 0;
  late int fee = 0;
  late DateTime checked_at = DateTime.now();
  late RxString direction = ''.obs;
  late RxString buildingType = ''.obs;
  late int m2 = 0;
  late int room = 0;
  late int toilet = 0;
  late DateTime moveInDate = DateTime.now();
  late RxString hashtag = ''.obs;
  late RxString showYes = 'public'.obs;
  late RxString note = ''.obs;
  final RxBool isLoading = true.obs;
  final RxList<Map<String, dynamic>> jsonData = <Map<String, dynamic>>[].obs;
  final RxString error = ''.obs;
  // Method to set arguments
  void setArguments(Map<String, dynamic> args) {
    location.value = args['selectedAddress'] ?? '';
    estate.value = (args['selectedAddress'] ?? '') + (args['selectedDong'] ?? '') + (args['selectedFloor'] ?? '') + (args['selectedHo'] ?? '');
    total_floor = args['totalFloor'] ?? 0;
    attachments.value = args['attachments'] ?? '';
    // Set other arguments similarly
    // Print the values
    print('Location: $location');
    print('Estate: $estate');
    print('Total Floor: $total_floor');
    print('attachments: $attachments');
    // Set other arguments similarly
  }

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      String url = 'http://10.0.2.2/insert';

      String input = jsonEncode({
        "attachments": attachments,
        "agentId": "명진 부동산1",
        "checkedAt": "2024-04-09T15:00:00",
        "estateId": "39",
        "direction": "동향",
        "totalFloor": 8,
        "buildingFloor": 2,
        "buildingType": "아파트",
        "deposit": 500,
        "fee": 45,
        "available": "2024-04-09T15:00:00",
        "hashtag": "#역세권",
        "m2": 84.0,
        "location": "서울시 마포구 상암동",
        "showYes": "public",
        "note": "상세주소 11동",
        "room": 1,
        "toilet": 1,
        "maintenanceFee": 1.0,
        "premium": "2024-06-15T15:00:00"
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