import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/profile/profile_controller.dart';
import 'package:testapp/widgets/app_bar_widget.dart';

class MyinfoScreen extends StatelessWidget {
  const MyinfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBarWidget(title: '내 정보'),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () => controller.pickImage(),
                child: Obx(() => CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: controller.image != null
                          ? FileImage(controller.image!) as ImageProvider<Object>
                          : const AssetImage('assets/images/default_profile.png') ,
                    )),
              ),
              Positioned(
                bottom: 0, // 하단 정렬
                right: 0, // 우측 정렬
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black, // 검은색 배경
                    borderRadius: BorderRadius.circular(20), // 모서리 둥글게
                  ),
                  width: 36, // 컨테이너 너비 조절
                  height: 36, // 컨테이너 높이 조절
                  child: Align(
                    alignment: Alignment.center, // 중앙 정렬
                    child: IconButton(
                      icon: Icon(Icons.camera_alt),
                      color: Colors.white,
                      onPressed: () {},
                      iconSize: 20, // 아이콘 크기 조절
                      padding: EdgeInsets.zero, // 내부 패딩 제거
                      constraints: BoxConstraints(), // 최소/최대 크기 제약 제거
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ListTile(
            title: Text('연결된 소셜 계정'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            title: Text('닉네임'),
            subtitle: Text('매력적인 창문'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            title: Text('휴대폰 번호'),
            subtitle: Text('인증을 진행해주세요.'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          SizedBox(height: 20),
          const Divider(
            color: Colors.grey,
            height: 20,
            thickness: 0.5,
          ),
          ListTile(
            title: Text('회원탈퇴'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}

