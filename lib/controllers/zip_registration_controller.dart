import 'package:get/get.dart';

class ZipRegistration extends GetxController {
  late RxString location = ''.obs;
  late RxString estate = ''.obs;
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

  // Method to set arguments
  void setArguments(Map<String, dynamic> args) {
    location.value = args['selectedAddress'];
    estate.value = args['selectedAddress']+args['selectedDong']+args['selectedFloor']+args['selectedHo'];
    total_floor = args['totalFloor'];
    // Set other arguments similarly
  }

}