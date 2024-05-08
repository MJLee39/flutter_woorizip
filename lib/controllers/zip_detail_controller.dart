import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:testapp/utils/api_config.dart';

class ZipDataController {
  Future<Map<String, dynamic>> fetchZipData(String itemID) async {
    final response = await http.get(
        Uri.parse('${ApiConfig.apiGetByIdZipUrl}/$itemID'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData =
      json.decode(utf8.decode(response.bodyBytes));
      return responseData;
    } else {
      throw Exception('Failed to load zip data');
    }
  }
}
