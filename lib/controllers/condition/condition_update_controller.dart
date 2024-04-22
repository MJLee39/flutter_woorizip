import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ConditionUpdateController extends GetxController {
  late RxString id = ''.obs;
  late RxString accountId = ''.obs;
  late RxString location = ''.obs;
  late RxString buildingType = ''.obs;
  late RxInt fee = 0.obs;
  late DateTime moveInDate = DateTime.now();
  late RxString hashtag = ''.obs;
}
