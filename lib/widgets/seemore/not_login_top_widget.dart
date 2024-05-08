import 'package:flutter/material.dart';
import 'package:get/get.dart';


class NotLoginTopWidget extends StatelessWidget {
  const NotLoginTopWidget({super.key});

@override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 10.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
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
                    backgroundImage: const AssetImage('assets/images/default_profile.png'),
                  ),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    Get.toNamed('/login');
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: const Text(
                    '로그인',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}