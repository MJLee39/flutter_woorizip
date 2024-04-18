import 'package:geolocator/geolocator.dart';
import 'package:testapp/map/dto/custom_location.dart';

class LocationService {
  static const CustomLocation initLocation = CustomLocation(latitude: 37.580842, longitude: 126.895611); // 기본 위치는 수색역

  Future<LocationPermission> hasLocationPermission() async => await Geolocator.checkPermission();

  Future<bool> isLocationEnabled() async => await Geolocator.isLocationServiceEnabled();

  Future<LocationPermission> requestLocation() async => await Geolocator.requestPermission();

  Future<CustomLocation> currentLocation() async {
    final Position _position = await Geolocator.getCurrentPosition();
    return CustomLocation(latitude: _position.latitude, longitude: _position.longitude);
  }

  Future<bool> canGetCurrentLocation() async {
    final LocationPermission _permission = await hasLocationPermission();
    if (_permission == LocationPermission.always || _permission == LocationPermission.whileInUse) {
      final bool _enabled = await isLocationEnabled();
      if (_enabled) return true;
    }
    return false;
  }
}