import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  static StorageService get to => Get.find();
  final String keyAccessToken = 'access_token';
  final String keyRefreshToken = 'refresh_token';

  final _box = GetStorage();

  Future<void> initStorage() async {
    await GetStorage.init();
  }

  T read<T>(String key) {
    return _box.read(key);
  }

  Future<void> write(String key, dynamic value) async {
    await _box.write(key, value);
  }

  Future<void> remove(String key) async {
    await _box.remove(key);
  }

  Future<void> clearAll() async {
    await _box.erase();
  }
  
  Future<void> setAccessToken(dynamic value) async {
    await _box.write(keyAccessToken, value);
  }

  String getAccessToken() {
    return _box.read(keyAccessToken);
  }

  Future<void> removeAccessToken() async {
    await _box.remove(keyAccessToken);
  }

  Future<void> setRefreshToken(dynamic value) async {
    await _box.write(keyAccessToken, value);
  }

  String getRefreshToken() {
    return _box.read(keyRefreshToken);
  }

  Future<void> removeRefreshToken() async {
    await _box.remove(keyRefreshToken);
  }

  bool hasToken() {
    return _box.hasData(keyAccessToken);
  }
  
}