import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/account/account_controller.dart';
import 'package:testapp/controllers/profile/profile_controller.dart';
import 'package:testapp/services/auth_service.dart';
import 'package:testapp/utils/api_config.dart';
import 'package:testapp/widgets/app_bar_widget.dart';

class MyinfoScreen extends StatefulWidget {
  const MyinfoScreen({super.key});

  @override
  _MyinfoScreenState createState() => _MyinfoScreenState();
}

class _MyinfoScreenState extends State<MyinfoScreen> {
  final ProfileController profileController = Get.put(ProfileController());
  final accountController = Get.find<AccountController>();
  final authService = Get.find<AuthService>();

  @override
  void initState() {
    super.initState();
    accountController.addListener(update);
  }

  @override
  void dispose() {
    accountController.removeListener(update);
    super.dispose();
  }

  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: '내 정보'),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () => profileController.pickImage(),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: profileController.image != null
                      ? FileImage(profileController.image!)
                      : accountController.profileImageId.isNotEmpty
                          ? NetworkImage('${ApiConfig.attachmentApiEndpointUri}/${accountController.profileImageId}') as ImageProvider
                          : const AssetImage('assets/images/default_profile.png'),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: 36,
                  height: 36,
                  child: Align(
                    alignment: Alignment.center,
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt),
                      color: Colors.white,
                      onPressed: () => profileController.pickImage(),
                      iconSize: 20,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const ListTile(
            title: Text('연결된 소셜 계정'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            title: const Text('이름'),
            subtitle: Text(accountController.nickname),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => Get.toNamed('/modify_nickname'),
          ),
          ListTile(
            title: const Text('휴대폰 번호'),
            subtitle: Text(accountController.phone),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            title: const Text('로그아웃'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => authService.logout(),
          ),
          const Divider(
            color: Colors.grey,
            height: 20,
            thickness: 0.5,
          ),
          ListTile(
            title: Text('우리집 그만 이용하기', style: TextStyle(color: Colors.black38, fontSize: 16)),
            onTap: () => Get.toNamed('/delete_account'),
          ),
        ],
      ),
    );
  }
}