import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
                          Container(
                            height: 300,
                            width: double.infinity,
                            child: Image.memory(_imagesData[index], fit: BoxFit.cover),
                          ),
                          Positioned(
                            right: 4,
                            top: 4,
                            child: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
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
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: _registerImages,
                child: Text("등록"),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  ),
                )
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImages,
        child: Icon(Icons.add),
      ),
    );
  }
}
