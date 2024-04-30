import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/condition_controller.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({super.key});

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  final ConditionController controller = Get.find<ConditionController>();

  String _selectedLocation = '';
  String _prevLocation = '';
  String _selectedBuildingType = '';
  String _prevBuildingType = '';
  int _selectedFee = 0;
  int _prevFee = 0;
  DateTime _selectedMoveInDate = DateTime.now();
  DateTime _prevMoveInDate = DateTime.now();
  String _selectedHashtag = '';
  String _prevHashtag = '';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
              side: BorderSide(
                color: Colors.grey[300]!,
                width: 1.0,
              ),
            ),
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(9, 15, 9, 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // 텍스트 요소를 왼쪽 정렬
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[200],
                                foregroundColor: Colors.black,
                                minimumSize: const Size(100, 40),
                              ),
                              onPressed: () {
                                // 버튼 1 클릭 시 동작할 코드
                                showModalBottomSheet(
                                  context:
                                      context, // showModalBottomSheet의 context를 사용
                                  isScrollControlled: true, // 모달이 스크롤 가능하게 함
                                  builder: (BuildContext context) {
                                    return Container(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('새로운 모달 내용'), // 새 모달의 내용 추가
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.indigo,
                                              foregroundColor: Colors.white,
                                            ),
                                            onPressed: () {
                                              // 이 버튼을 눌렀을 때 동작할 코드
                                            },
                                            child: const Text('추가 버튼'),
                                          ),
                                          // 모달 안에 다른 위젯 추가 가능
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Text('주소'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[200],
                                foregroundColor: Colors.black,
                                minimumSize: const Size(100, 40),
                              ),
                              onPressed: () {
                                // 버튼 2 클릭 시 동작할 코드
                              },
                              child: const Text('건물유형'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[200],
                                foregroundColor: Colors.black,
                                minimumSize: const Size(100, 40),
                              ),
                              onPressed: () {
                                // 버튼 3 클릭 시 동작할 코드
                              },
                              child: const Text('금액'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[200],
                                foregroundColor: Colors.black,
                                minimumSize: const Size(100, 40),
                              ),
                              onPressed: () {
                                // 버튼 4 클릭 시 동작할 코드
                              },
                              child: const Text('입주가능일'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[200],
                                foregroundColor: Colors.black,
                                minimumSize: const Size(100, 40),
                              ),
                              onPressed: () {
                                // 버튼 5 클릭 시 동작할 코드
                              },
                              child: const Text('옵션'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      if (_selectedLocation != _prevLocation) ...[
                        Text('주소: ' + _selectedLocation),
                        const SizedBox(height: 10),
                      ] else ...[
                        Text('주소: '),
                        const SizedBox(height: 10),
                      ],
                      if (_selectedBuildingType != _prevBuildingType) ...[
                        Text('건물 유형: ' + _selectedBuildingType),
                        const SizedBox(height: 10),
                      ] else ...[
                        Text('건물 유형: '),
                        const SizedBox(height: 10),
                      ],
                      if (_selectedFee != _prevFee) ...[
                        Text('금액: ' + _selectedFee.toString()),
                        const SizedBox(height: 10),
                      ] else ...[
                        Text('금액: '),
                        const SizedBox(height: 10),
                      ],
                      if (_selectedMoveInDate != _prevMoveInDate) ...[
                        Text('입주가능일: ' + _selectedMoveInDate.toString()),
                        const SizedBox(height: 10),
                      ] else ...[
                        Text('입주가능일: '),
                        const SizedBox(height: 10),
                      ],
                      if (_selectedHashtag != _prevHashtag) ...[
                        Text('옵션: ' + _selectedHashtag),
                        const SizedBox(height: 10),
                      ] else ...[
                        Text('옵션: '),
                        const SizedBox(height: 10),
                      ],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(150, 50),
                            ),
                            onPressed: () {
                              // 버튼 클릭 시 동작할 코드
                            },
                            child: const Text('검색하기'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: const Icon(
            Icons.tune,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
