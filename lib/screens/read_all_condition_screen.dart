import 'package:flutter/material.dart';
import 'package:testapp/widgets/client/dropdown_fields_widget.dart';
import 'package:testapp/widgets/client/search_button_widget.dart';
import 'package:testapp/widgets/client/card_list_view_widget.dart';
import 'package:get/get.dart';

class ReadAllConditionScreen extends StatefulWidget {
  const ReadAllConditionScreen({super.key});

  @override
  _ReadAllConditionScreenState createState() => _ReadAllConditionScreenState();
}

class _ReadAllConditionScreenState extends State<ReadAllConditionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('등록하신 조건들이에요'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // 첫 번째 드롭다운 3개를 포함한 행
             Row(
              children: [
                Expanded(
                  child: DropdownFieldsWidget(
                    options: const ['위치0', '위치1', '위치2'],
                    initialValue: '위치0',
                    onChanged: (String newValue) {
                      print('첫 번째 드롭다운 선택된 값: $newValue');
                      // 필요한 경우 추가 로직 작성
                    },
                  ),
                ),
                Expanded(
                  child: DropdownFieldsWidget(
                    options: const ['옵션1', '옵션2', '옵션3'],
                    initialValue: '옵션1',
                    onChanged: (String newValue) {
                      print('두 번째 드롭다운 선택된 값: $newValue');
                      // 필요한 경우 추가 로직 작성
                    },
                  ),
                ),
                Expanded(
                  child: DropdownFieldsWidget(
                    options: const ['선택지1', '선택지2', '선택지3'],
                    initialValue: '선택지1',
                    onChanged: (String newValue) {
                      print('세 번째 드롭다운 선택된 값: $newValue');
                      // 필요한 경우 추가 로직 작성
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 두 번째 드롭다운 3개를 포함한 행
            Row(
              children: [
                Expanded(
                  child: DropdownFieldsWidget(
                    options: const ['항목1', '항목2', '항목3'],
                    initialValue: '항목1',
                    onChanged: (String newValue) {
                      print('네 번째 드롭다운 선택된 값: $newValue');
                      // 필요한 경우 추가 로직 작성
                    },
                  ),
                ),
                Expanded(
                  child: DropdownFieldsWidget(
                    options: const ['항목A', '항목B', '항목C'],
                    initialValue: '항목A',
                    onChanged: (String newValue) {
                      print('다섯 번째 드롭다운 선택된 값: $newValue');
                      // 필요한 경우 추가 로직 작성
                    },
                  ),
                ),
                Expanded(
                  child: DropdownFieldsWidget(
                    options: const ['카테고리1', '카테고리2', '카테고리3'],
                    initialValue: '카테고리1',
                    onChanged: (String newValue) {
                      print('여섯 번째 드롭다운 선택된 값: $newValue');
                      // 필요한 경우 추가 로직 작성
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 조회하기 버튼
            SearchButton(
              onPressed: () {
                // 버튼을 누르면 동작할 코드 (예: 조건 검색)
                print('조회하기 버튼을 눌렀습니다.');
              },
            ),
            const SizedBox(height: 40),
            // ** 카드 리스트 뷰
            const CardListViewWidget()
          ],
        ),
      ),
    );
  }
}
