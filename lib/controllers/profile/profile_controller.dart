import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:testapp/account/account_controller.dart';
import 'package:testapp/utils/api_config.dart';

class ProfileController extends GetxController {
  final Rxn<File> _image = Rxn<File>();
  File? get image => _image.value;
  final ImagePicker _picker = ImagePicker();
  final AccountController _accountController = Get.find<AccountController>();

  Future<void> pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _image.value = File(pickedFile.path);
        await updateImageOnServer(_image.value!);
        _accountController.profileImageId = _image.value!.path; // 프로필 이미지 ID 업데이트
      } else {
        debugPrint('No image selected.');
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  Future<void> updateImageOnServer(File image) async {
    var uri = Uri.parse('${ApiConfig.apiAttachmentUrl}/upload');
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