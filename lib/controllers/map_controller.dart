import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:testapp/map/dto/custom_location.dart';

class DataController {
  Future<List<Map<String, String>>> fetchData(CustomLocation customLocation) async {
    final response = await http.get(Uri.parse('http://10.0.2.2/search?location=${customLocation.address}'));
    if (response.statusCode == 200) {
      List<dynamic> responseData = jsonDecode(utf8.decode(response.bodyBytes));
      return responseData.map<Map<String, String>>((data) {
        return {
          'id': data['id'],
          'direction': data['direction'],
          'buildingType': data['buildingType'],
          'attachments': data['attachments'],
          'money': '${data['deposit'].toString()}/${data['fee'].toString()}',
        };
      }).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
