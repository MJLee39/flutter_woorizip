
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:testapp/services/storage_service.dart';
import 'package:testapp/utils/api_config.dart';

class AccountController extends GetxController {
  final _storageService = Get.find<StorageService>();


  // get Account
  Future<void> getAccount() async {
    try {
      http.Response response = await http.get(
        Uri.parse(ApiConfig.apiSubfixAccountUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': _storageService.getAccessToken(),
        },
      );

      if (response.statusCode == 200) {
        debugPrint('Account: ${response.body}');
      } else {
        debugPrint('Failed to get account');
      }
    } catch (e) {
      debugPrint('Error getting account: $e');
    }
  }

  // update Account
  Future<void> updateAccount() async {
    try {
      http.Response response = await http.put(
        Uri.parse('https://yourserver.com/account'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': _storageService.getAccessToken(),
          
        },
        body: <String, String>{
          'name': 'new name',
          'email': 'new email',
        },
      );
      if (response.statusCode == 200) {
        debugPrint('Account updated!');
      } else {
        debugPrint('Account update failed!');
      }
    } catch (e) {
      debugPrint('Error updating account: $e');
    }
  }

  // delete Account
  Future<void> deleteAccount() async {
    try {
      http.Response response = await http.delete(
        Uri.parse('https://yourserver.com/account'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': _storageService.getAccessToken(),
        },
      );
      if (response.statusCode == 200) {
        debugPrint('Account deleted!');
      } else {
        debugPrint('Account delete failed!');
      }
    } catch (e) {
      debugPrint('Error deleting account: $e');
    }
  }
}
