import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:testapp/map/dto/custom_location.dart';

class DataController {
  Future<List<Map<String, String>>> fetchData(CustomLocation customLocation) async {
    final response = await http.get(Uri.parse('https://api.teamwaf.app/v1/zip/search?location=${customLocation.address}'));
    
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));
      
      if (decodedData is Map<String, dynamic> && decodedData['Zips'] is List) {
        final zips = decodedData['Zips'] as List;
        
        if (zips.isEmpty) {
          throw Exception('No data available');
        }
        
        return zips.map<Map<String, String>>((data) {
          return {
            'id': data['id']?.toString() ?? '',
            'direction': data['direction'] ?? '',
            'buildingType': data['buildingType'] ?? '',
            'attachments': data['attachments']?.toString() ?? '',
            'money': '${data['deposit']?.toString() ?? ''}/${data['fee']?.toString() ?? ''}',
          };
        }).toList();
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
}
