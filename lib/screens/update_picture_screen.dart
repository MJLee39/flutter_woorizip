import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testapp/screens/rental_info_screen.dart';

class UpdatePictureScreen extends StatefulWidget {
  @override
  _UpdatePictureScreenState createState() => _UpdatePictureScreenState();
}

class _UpdatePictureScreenState extends State<UpdatePictureScreen> {
  List<Uint8List> _imagesData = [];

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

  void _registerImages() {
    // 이미지 등록 로직 구현
    print('이미지가 등록되었습니다.');
    // Navigator를 사용하여 새로운 페이지로 이동
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RentalInfoScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("사진 등록"),
      ),
      body: Column(
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
                onPressed: _registerImages,
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  ),
                ),
                child: const Text("등록")
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImages,
        child: const Icon(Icons.add),
      ),
    );
  }
}
