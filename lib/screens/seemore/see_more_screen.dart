import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/account/account_controller.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';

class SeeMoreScreen extends StatelessWidget {
  final _accountController = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: '더보기'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 10.0),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey[300]!,
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey[300],
                    backgroundImage:
                        _accountController.profileImageId.isNotEmpty
                            ? NetworkImage(_accountController.profileImageId)
                                as ImageProvider
                            : const AssetImage('assets/images/default_profile.png')
                                as ImageProvider,
                  ),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    Get.toNamed('/myinfo');
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: Text(
                    _accountController.nickname,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
            height: 20,
            thickness: 0.5,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 2.0),
            child: Row(
              children: [
                Icon(Icons.favorite_border_sharp, color: Colors.grey[400]),
                SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    Get.toNamed('/event');
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: const Text(
                    '이벤트',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 2.0),
            child: Row(
              children: [
                Icon(Icons.report_gmailerrorred, color: Colors.grey[400]),
                SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    Get.toNamed('/report_history');
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: const Text(
                    '신고내역',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 2.0),
            child: Row(
              children: [
                Icon(Icons.home_work_outlined, color: Colors.grey[400]),
                SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    Get.toNamed('/conditionreadone');
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: const Text(
                    '내 조건',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
