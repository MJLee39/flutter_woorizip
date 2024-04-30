import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testapp/screens/zip_registration/rental_info_4_screen.dart';
import 'package:testapp/controllers/zip_registration_controller.dart';
import 'package:get/get.dart';
import 'package:testapp/widgets/bottom_expend_button_widget.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/screens/zip_update/update_zip_screen.dart';

class UpdateZipPictureScreen extends StatefulWidget {
  @override
  _UpdateZipPictureScreenState createState() => _UpdateZipPictureScreenState();
}

class _UpdateZipPictureScreenState extends State<UpdateZipPictureScreen> {
  List<Uint8List> _imagesData = [];

  final ZipRegistration controller = Get.find<ZipRegistration>();

  Future<void> _pickImages() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? images = await _picker.pickMultiImage();

    if (images != null) {
      for (XFile image in images) {
        final Uint8List imageData = await image.readAsBytes();
        setState(() {
          _imagesData.add(imageData);
        });
      }
    }
  }

  void _deleteImage(int index) {
    setState(() {
      _imagesData.removeAt(index);
    });
  }

  String  _registerImages() {

    // 이미지 등록 로직 구현
    String attachments = '';

    // 새로운 이미지를 기존 첨부 파일에 추가 -> 이후에 S3로 바꾸기
    for (Uint8List imageData in _imagesData) {
      attachments += imageData.toString(); // 이미지 id를 구분자로 사용하여 추가
    }

    controller.attachments = 'IMAGE URL'; // 업데이트된 값을 저장

    return attachments;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments ?? {};

    // Extract data from arguments
    final String id = args['id'];

    debugPrint('3-location: ${controller.location}');
    debugPrint('3-estate: ${controller.estate}');
    debugPrint('3-total floor: ${controller.total_floor}');
    debugPrint('3-building floor: ${controller.building_floor}');

    return Scaffold(
      appBar: const AppBarWidget(),
      body:  PageNormalPaddingWidget(
        child:
        Column(
          children: [
            Expanded(
              child: _imagesData.isEmpty
                  ? Center(child: Text("사진이 선택되지 않았습니다.\n최소 두장의 사진을 선택해주세요."))
                  : ListView.builder(
                itemCount: _imagesData.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: Image.memory(_imagesData[index], fit: BoxFit.cover),
                      ),
                      Positioned(
                        right: 4,
                        top: 4,
                        child: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteImage(index),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            if (_imagesData.length > 1)
              Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to UpdatePictureScreen when the button is pressed
                    Get.to(() => UpdateAddressScreen(itemId: id), arguments: {
                      'attachments': _registerImages(),
                    });
                  },
                  child: const Text("수정"),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImages,
        child: const Icon(Icons.add),
      ),
    );
  }
}
