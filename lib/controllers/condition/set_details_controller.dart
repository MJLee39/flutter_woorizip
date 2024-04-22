import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class SetDetailsController extends GetxController {
  late RxString location = ''.obs;
  late RxString buildingType = ''.obs;
  late int fee = 0;
  late DateTime moveInDate = DateTime.now();
  late RxString hashtag = ''.obs;
}
