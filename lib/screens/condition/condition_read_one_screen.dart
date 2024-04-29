import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/condition_controller.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/widgets/text_header_widget.dart';
import 'package:testapp/widgets/client/read_one_widget.dart';

class ConditionReadOneScreen extends StatefulWidget {
  const ConditionReadOneScreen({super.key});

  @override
  _ConditionReadOneScreenState createState() => _ConditionReadOneScreenState();
}

class _ConditionReadOneScreenState extends State<ConditionReadOneScreen> {
  late ConditionController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(ConditionController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: PageNormalPaddingWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const TextHeaderWidget(text: '등록된 조건이에요'),
            const SizedBox(height: 20),
            FutureBuilder<bool>(
              future: _controller.isRegistered(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // 로딩 중일 때 중앙에 로딩 인디케이터 표시
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // 오류 발생 시 유용한 오류 메시지 표시
                  return Center(
                    child: Text('Error fetching data: ${snapshot.error}'),
                  );
                } else {
                  // 성공적으로 불리언 값을 가져왔을 때
                  bool isRegistered = snapshot.data ?? false;

                  if (isRegistered) {
                    // 조건 수정
                    return ReadOneWidget();
                  } else {
                    // 조건 등록
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(height: 200),
                        const Text(
                          '등록된 조건이 없어요',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Get.toNamed('/setdetails');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            textStyle: const TextStyle(fontSize: 16),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                          ),
                          child: const Text(
                            '조건 등록하러 갈래요',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    );
                  } // if
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
