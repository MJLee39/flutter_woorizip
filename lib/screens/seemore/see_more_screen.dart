import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:testapp/services/auth_service.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/utils/app_colors.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';

class SeeMoreScreen extends StatelessWidget {
  final _authService = Get.find<AuthService>();
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
                  padding: EdgeInsets.all(
                      2), // Adjust the padding to set the thickness of the border
                  decoration: BoxDecoration(
                    color: Colors
                        .transparent, // Ensure the container itself has no color
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors
                          .grey[300]!, // Set the border color to a light grey
                      width: 2, // Set the border width
                    ),
                  ),
                  child: CircleAvatar(  
                    radius:
                        30, // Adjust the radius appropriately for the border
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person_outline,
                        size: 40, color: Colors.black12),
                  ),
                ),
                SizedBox(width: 10),
                TextButton(
              onPressed: () {
                // _authService.logout();
                Get.toNamed('/myinfo');
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                  
            
              ),
              child: const Text(
                '매력적인 창문',
                style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
              ],
            ),
          ),
          // 구분선 추가
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
                      style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.normal),
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
                      style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.normal),
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
