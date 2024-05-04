import 'package:flutter/material.dart';
import 'package:testapp/controllers/search_condition/building_type_controller.dart';
import 'package:testapp/controllers/search_condition/deposit_type_controller.dart';
import 'package:testapp/controllers/search_condition/fee_type_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:testapp/controllers/zip_find_controller.dart';

class SearchTypeSelectorController extends GetxController {
  final ZipFindController _zipFindController = Get.put(ZipFindController());
  final BuildingTypeController buildingTypeController = Get.put(BuildingTypeController());
  final DepositController depositController = Get.put(DepositController());
  final FeeTypeController feeController = Get.put(FeeTypeController());

  TextEditingController locationController = TextEditingController();

  void sendRequest() async {
    final selectedLocation = locationController.text;
    final selectedBuildingTypes = buildingTypeController.selectedBuildingTypes.join(',');
    final selectedFeeType = feeController.selectedFeeType;
    final selectedDeposit = depositController.selectedDepositType;

    final url = Uri.parse('http://10.0.2.2/search?location=$selectedLocation&buildingType=$selectedBuildingTypes&fee=$selectedFeeType&deposit=$selectedDeposit');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      Iterable<Map<String, dynamic>> responseData = (jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>)
          .map((dynamic item) => item as Map<String, dynamic>);
      _zipFindController.updateData(responseData.toList());
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  }

  @override
  void onClose() {
    locationController.dispose();
    super.onClose();
  }
}
