import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:testapp/map/dto/custom_location.dart';
import 'package:http/http.dart' as http;

class LocationService {
  static const CustomLocation initLocation = CustomLocation(latitude: 37.580842, longitude: 126.895611, address: "서울시 마포구 상암동"); // 기본 위치는 수색역

  Future<LocationPermission> hasLocationPermission() async => await Geolocator.checkPermission();

  Future<bool> isLocationEnabled() async => await Geolocator.isLocationServiceEnabled();

  Future<LocationPermission> requestLocation() async => await Geolocator.requestPermission();

  Future<CustomLocation> currentLocation() async {
    final Position _position = await Geolocator.getCurrentPosition();
    final String address = await _convertToAddress(_position.longitude, _position.latitude);

    return CustomLocation(latitude: _position.latitude, longitude: _position.longitude, address: address);
  }

  Future<bool> canGetCurrentLocation() async {
    final LocationPermission _permission = await hasLocationPermission();
    if (_permission == LocationPermission.always || _permission == LocationPermission.whileInUse) {
      final bool _enabled = await isLocationEnabled();
      if (_enabled) return true;
    }
    return false;
  }

  Future<String> _convertToAddress(double longitude, double latitude) async {
    final response = await http.get(
        Uri.parse("https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&coords=$longitude,$latitude&sourcecrs=epsg:4326&output=json&orders=legalcode"),
        headers: {
          'X-NCP-APIGW-API-KEY-ID': '0akipmvx1h',
          'X-NCP-APIGW-API-KEY': 'BOBIX0nbXfN4oaTTIJZJeL84cofPI4klhq1FJr7j'
        }
    );

    final si = jsonDecode(utf8.decode(response.bodyBytes))["results"][0]["region"]["area1"]["name"];
    final gu = jsonDecode(utf8.decode(response.bodyBytes))["results"][0]["region"]["area2"]["name"];
    final dong = jsonDecode(utf8.decode(response.bodyBytes))["results"][0]["region"]["area3"]["name"];

    final address = '$si $gu $dong';
    return address;
  }
}