import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testapp/account/account_controller.dart';
import 'package:testapp/controllers/file/upload_file_controller.dart';

class ProfileController extends GetxController {
  final Rxn<File> _image = Rxn<File>();
  File? get image => _image.value;
  final ImagePicker _picker = ImagePicker();
  final AccountController _accountController = Get.find<AccountController>();

  // UploadFileController 인스턴스 생성
  final UploadFileController _uploadFileController = Get.put(UploadFileController());

  Future<void> pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _image.value = File(pickedFile.path);
        await uploadImage(); // 사진 선택 후 자동 업로드
      } else {
        debugPrint('No image selected.');
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  Future<void> uploadImage() async {
    if (_image.value != null) {
      final uploadedFileId = await _uploadFileController.uploadFile(_image.value!);
      if (uploadedFileId != null) {
        _accountController.profileImageId = uploadedFileId;
      }
    }
  }
}