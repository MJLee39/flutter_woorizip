import 'package:flutter/foundation.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart' show LocationTrackingMode;
import 'package:testapp/map/dto/custom_location.dart';
import 'package:testapp/map/service/location_service.dart';

class MapProvider with ChangeNotifier {
  final LocationService _locationService = LocationService();
  final CustomLocation initLocation = LocationService.initLocation;

  MapProvider(){
    Future(this.setCurrentLocation);
  }

  LocationTrackingMode _trackingMode = LocationTrackingMode.None;
  LocationTrackingMode get trackingMode => _trackingMode;
  set trackingMode(LocationTrackingMode m) => throw "error";

  Future<void> setCurrentLocation() async {
    if (await _locationService.canGetCurrentLocation()){
      _trackingMode = LocationTrackingMode.Follow;
      notifyListeners();
    }
  }

  Future<CustomLocation> getCurrentLocation() async {
    if (await _locationService.canGetCurrentLocation()){
      return await _locationService.currentLocation();
    }
    return initLocation;
  }

}