import 'dart:convert';
import 'package:http/http.dart' as http;

class ZipDataController {
  Future<Map<String, dynamic>> fetchZipData(String itemID) async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2/zipOne?zip_id=$itemID'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData =
      json.decode(utf8.decode(response.bodyBytes));
      return responseData;
    } else {
      throw Exception('Failed to load zip data');
    }
  }
}