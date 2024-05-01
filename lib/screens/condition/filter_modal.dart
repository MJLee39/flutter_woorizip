import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/condition_controller.dart';
import 'package:testapp/widgets/client/calendar_widget.dart';
import 'package:testapp/widgets/client/juso_dong_dropdown_widget.dart';
import 'package:testapp/widgets/client/juso_gu_dropdown_widget.dart';
import 'package:testapp/widgets/client/juso_si_dropdown_widget.dart';
import 'package:testapp/widgets/client/select_hashtag_widget.dart';
import 'package:testapp/widgets/client/set_fee_widget.dart';

class FilterModal extends StatefulWidget {
  const FilterModal({super.key});

  @override
  State<FilterModal> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterModal> {
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

  bool _showLocationWidget = false;
  bool _showBuildingTypeWidget = false;
  bool _showFeeWidget = false;
  bool _showMoveInDateWidget = false;
  bool _showHahstagWidget = false;

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
                return Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            // 모달 상단 버튼
                            // 버튼을 누르면, 위젯 표시용 불리언 값이 변경
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _showLocationWidget = true;
                                      _showBuildingTypeWidget = false;
                                      _showFeeWidget = false;
                                      _showMoveInDateWidget = false;
                                      _showHahstagWidget = false;
                                    });
                                  },
                                  child: const Text('주소'),
                                ),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _showLocationWidget = false;
                                      _showBuildingTypeWidget = true;
                                      _showFeeWidget = false;
                                      _showMoveInDateWidget = false;
                                      _showHahstagWidget = false;
                                    });
                                  },
                                  child: const Text('건물 유형'),
                                ),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _showLocationWidget = false;
                                      _showBuildingTypeWidget = false;
                                      _showFeeWidget = true;
                                      _showMoveInDateWidget = false;
                                      _showHahstagWidget = false;
                                    });
                                  },
                                  child: const Text('금액'),
                                ),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _showLocationWidget = false;
                                      _showBuildingTypeWidget = false;
                                      _showFeeWidget = false;
                                      _showMoveInDateWidget = true;
                                      _showHahstagWidget = false;
                                    });
                                  },
                                  child: const Text('입주가능일'),
                                ),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _showLocationWidget = false;
                                      _showBuildingTypeWidget = false;
                                      _showFeeWidget = false;
                                      _showMoveInDateWidget = false;
                                      _showHahstagWidget = true;
                                    });
                                  },
                                  child: const Text('옵션'),
                                ),
                              ),
                            ],
                          ),

                          // 위에서 변경된 불리언 상태를 판별하여 특정 위젯 표시
                          const SizedBox(height: 16.0),
                          if (_showLocationWidget)
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
                                ),
                              ],
                            ),
                          if (_showFeeWidget)
                            Row(
                              children: [
                                Expanded(
                                  child: SetFeeWidget(),
                                ),
                              ],
                            ),
                          if (_showMoveInDateWidget)
                            Row(
                              children: [
                                Expanded(
                                  child: CalendarWidget(),
                                ),
                              ],
                            ),
                          if (_showHahstagWidget)
                            Row(
                              children: [
                                Expanded(
                                  child: SelectHashtagWidget(),
                                ),
                              ],
                            ),
                          const SizedBox(height: 16.0),

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
                            Text('입주 가능일: ' + _selectedMoveInDate.toString()),
                            const SizedBox(height: 10),
                          ] else ...[
                            Text('입주 가능일: '),
                            const SizedBox(height: 10),
                          ],
                          if (_selectedHashtag != _prevHashtag) ...[
                            Text('옵션: ' + _selectedHashtag),
                            const SizedBox(height: 10),
                          ] else ...[
                            Text('옵션: '),
                            const SizedBox(height: 10),
                          ],
                          // 검색 버튼 추가
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // 검색하기 버튼 클릭 시 동작할 코드
                                },
                                child: const Text('검색하기'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
