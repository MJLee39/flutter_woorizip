import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  final Rxn<File> _image = Rxn<File>();
  File? get image => _image.value;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _image.value = File(pickedFile.path);
      } else {
        // 사용자가 이미지 선택을 취소한 경우
        debugPrint('No image selected.');
      }
    } catch (e) {
      // 에러 처리
      debugPrint('Error picking image: $e');
    }
  }

  Future<void> updateImageOnServer(File image) async {
    var uri = Uri.parse('https://yourserver.com/upload');
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('profile', image.path));
    var response = await request.send();

    if (response.statusCode == 200) {
      debugPrint('Image uploaded!');
    } else {
      debugPrint('Image upload failed!');
    }
  }
}
