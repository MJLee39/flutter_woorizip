import 'package:flutter/material.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/widgets/text_header_widget.dart';

class SetBtypeAndFeeScreen extends StatelessWidget {
  const SetBtypeAndFeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(),
      body: PageNormalPaddingWidget(
          child: Column(
          children: [
            TextHeaderWidget(text: '건물 유형을 알려주세요'),
            SizedBox(height: 10,),
            
          ],
        )
      ),
    );
  }
}
