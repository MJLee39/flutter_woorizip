import 'package:flutter/material.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/widgets/client/juso_dong_dropdown_widget.dart';
import 'package:testapp/widgets/client/juso_gu_dropdown_widget.dart';
import 'package:testapp/widgets/client/juso_si_dropdown_widget.dart';
import 'package:testapp/widgets/client/set_buildingtype_buttons_widget.dart';
import 'package:testapp/widgets/client/set_fee_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/widgets/text_header_widget.dart';

class SetDetailsScreen extends StatefulWidget {
  const SetDetailsScreen({super.key});

  @override
  _SetDetailsScreenState createState() => _SetDetailsScreenState();
}

class _SetDetailsScreenState extends State<SetDetailsScreen> {
  String? local;
  String? buildingType;
  int? fee;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(),
      body: PageNormalPaddingWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          // set location
          children: [
            SizedBox(height: 20),
            TextHeaderWidget(text: '원하는 지역을 알려주세요'),
            SizedBox(height: 20),

            // set location: si /gu /dong
            Row(
              children: [
                Expanded(
                  child: JusoSiDropdownWidget(),
                ),
                Expanded(
                  child: JusoGuDropdownWidget(),
                ),
                Expanded(
                  child: JusoDongDropdownWidget(),
                )
              ],
            ),

            SizedBox(height: 40),

            //set building type
            TextHeaderWidget(text: '건물 유형을 알려주세요'),

            SizedBox(height: 20),

            Row(children: [SetBuildingtypeButtons()]),

            SizedBox(height: 40),

            // set fee
            TextHeaderWidget(text: '희망 가격대를 알려주세요'),

            SizedBox(height: 20),

            Row(children: [SetFeeWidget()]),

            SizedBox(height: 40),

            // 화면이동 버튼
            Row(),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
