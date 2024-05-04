import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/condition_controller.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/widgets/client/read_one_widget.dart';
import 'package:testapp/widgets/bottom_expend_button_widget.dart';

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
    _controller.readOneCondition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: '내 조건',
      ),
      body: Column(
        children: [
          Expanded(
            child: PageNormalPaddingWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Flexible(
                    child: FutureBuilder<bool>(
                      future: _controller.isRegistered(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error fetching data: ${snapshot.error}'),
                          );
                        } else {
                          bool isRegistered = snapshot.data ?? false;
                          if (isRegistered) {
                            return ReadOneWidget();
                          } else {
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
                              ],
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          BottomExpendButtonWidget(
            text: '등록',
            url: 'url',
          ),
        ],
      ),
    );
  }
}

