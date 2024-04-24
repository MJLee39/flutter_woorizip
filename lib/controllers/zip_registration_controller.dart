import 'package:get/get.dart';

class ZipRegistration extends GetxController {
  late RxString location = ''.obs;
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

}