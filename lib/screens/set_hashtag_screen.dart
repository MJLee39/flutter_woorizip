import 'package:flutter/material.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/widgets/client/select_hashtag_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/widgets/text_header_widget.dart';

class SetHashtagScreen extends StatelessWidget {
  const SetHashtagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(),
      body: PageNormalPaddingWidget(
        child: Column(
          children: [
            TextHeaderWidget(text: '원하는 옵션을 알려주세요'),
            SizedBox(height: 10),

            // select hashtag
            SelectHashtagWidget(),

            SizedBox(height: 20),

            // 화면이동 버튼
            Row()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(),
    );
  }
}
