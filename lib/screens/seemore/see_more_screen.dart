import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/account/account_controller.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/widgets/seemore/loggedin_top_widget.dart';
import 'package:testapp/widgets/seemore/not_login_top_widget.dart';

class SeeMoreScreen extends StatefulWidget {
  const SeeMoreScreen({super.key});

  @override
  _SeeMoreScreenState createState() => _SeeMoreScreenState();
}

class _SeeMoreScreenState extends State<SeeMoreScreen> {
  final _accountController = Get.find<AccountController>();

  @override
  void initState() {
    super.initState();
    _accountController.addListener(update);
  }

  @override
  void dispose() {
    _accountController.removeListener(update);
    super.dispose();
  }

  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: '더보기'),
      body: Column(
        children: [
          _accountController.account != null
              ? const LoggedinTopWidget()
              : const NotLoginTopWidget(),
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
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    Get.toNamed('/test');
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
            padding: const EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 2.0),
            child: Row(
              children: [
                Icon(Icons.report_gmailerrorred, color: Colors.grey[400]),
                const SizedBox(width: 10),
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
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    if (_accountController.role == 'User') {
                      Get.toNamed('/conditionreadone');
                    } else if (_accountController.role == 'Agent') {
                      Get.toNamed('/my_listings');
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: Text(
                    _accountController.role == 'User' ? '내 조건' : '내 매물보기',
                    style: const TextStyle(
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
