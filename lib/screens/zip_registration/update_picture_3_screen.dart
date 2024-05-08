import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testapp/screens/zip_registration/rental_info_4_screen.dart';
import 'package:testapp/controllers/zip_registration_controller.dart';
import 'package:get/get.dart';
import 'package:testapp/widgets/bottom_expend_button_widget.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'dart:io';
import '../../controllers/file/upload_file_controller.dart';

class UpdatePictureScreen extends StatefulWidget {
  @override
  _UpdatePictureScreenState createState() => _UpdatePictureScreenState();
}

class _UpdatePictureScreenState extends State<UpdatePictureScreen> {
  List<Uint8List> _imagesData = [];
  List<File> _imagesToUpload = [];

  final ZipRegistration controller = Get.find<ZipRegistration>();
  final uploadController = Get.put(UploadFileController());

  Future<void> _pickImages() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? images = await _picker.pickMultiImage();

    if (images != null) {
      for (XFile image in images) {
        final Uint8List imageData = await image.readAsBytes();
        final File imageFile = File(image.path);
        setState(() {
          _imagesData.add(imageData);
          _imagesToUpload.add(imageFile);
        });
      }
    }
  }

  void _deleteImage(int index) {
    setState(() {
      _imagesData.removeAt(index);
      _imagesToUpload.removeAt(index);
    });
  }

  Future<void>  _registerImages() async  {
    List<String> uploadedFileIds = await uploadController.uploadFiles(_imagesToUpload);
    if (uploadedFileIds.isNotEmpty) {
      String attachments = uploadedFileIds.join(',');
      controller.attachments = attachments;
      print('이미지가 등록되었습니다.');
    } else {
      print('이미지 등록에 실패했습니다.');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                child: BottomExpendButtonWidget(
                  text: '등록',
                  url: '/depositAndFee',
                  arguments: {
                    'attachments': _registerImages(),
                  },
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