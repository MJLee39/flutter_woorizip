import 'package:naver_map_plugin/naver_map_plugin.dart' show LatLng;

class CustomLocation extends LatLng {

  final double latitude;
  final double longitude;

  const CustomLocation({required this.latitude, required this.longitude}) : super(latitude, longitude);

}