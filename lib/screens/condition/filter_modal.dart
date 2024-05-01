import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/condition_controller.dart';
import 'package:testapp/widgets/client/calendar_widget.dart';
import 'package:testapp/widgets/client/juso_dong_dropdown_widget.dart';
import 'package:testapp/widgets/client/juso_gu_dropdown_widget.dart';
import 'package:testapp/widgets/client/juso_si_dropdown_widget.dart';
import 'package:testapp/widgets/client/select_hashtag_widget.dart';
import 'package:testapp/widgets/client/set_fee_widget.dart';

import '../../widgets/client/set_buildingtype_buttons_widget.dart';

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


  bool _showAddress = false;
  bool _showBuildingType = false;
  bool _showFee = false;
  bool _showMoveInDate = false;
  bool _showOptions = false;

  bool _showAddressWidget = false;
  bool _showBuildingTypeWidget = false;
  bool _showFeeWidget = false;
  bool _showMoveInDateWidget = false;
  bool _showOptionsWidget = false;

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
              isScrollControlled: true, // 모달 높이를 스크롤로 제어
              builder: (BuildContext context) {
                // 모달의 높이를 제한하기 위해 컨테이너를 사용
                return Container(
                  height: MediaQuery.of(context).size.height * 0.8, // 모달 높이 제한 (전체 화면 높이의 80%)
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min, // 자식 위젯에 따라 높이 조정
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Row: 위젯의 가로 배치를 위한 컨테이너
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _showAddress = !_showAddress;
                                      _showAddressWidget = !_showAddressWidget;
                                    });
                                  },
                                  child: const Text('주소'),
                                ),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _showBuildingType = !_showBuildingType;
                                      _showBuildingTypeWidget = !_showBuildingTypeWidget;
                                    });
                                  },
                                  child: const Text('건물 유형'),
                                ),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _showFee = ! _showFee;
                                      _showFeeWidget = !_showFeeWidget;
                                    });
                                  },
                                  child: const Text('금액'),
                                ),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _showMoveInDate = !_showMoveInDate;
                                      _showMoveInDateWidget = !_showMoveInDateWidget;
                                    });
                                  },
                                  child: const Text('입주가능일'),
                                ),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _showOptions = !_showOptions;
                                      _showOptionsWidget = !_showOptionsWidget;
                                    });
                                  },
                                  child: const Text('옵션'),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          if (_showAddressWidget)
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
                          if (_showOptionsWidget)
                            Row(
                              children: [
                                Expanded(
                                  child: SelectHashtagWidget(),
                                ),
                              ],
                            ),
                          const SizedBox(height: 16.0),
                          // 모달 내에 위젯 추가
                          // 각 위젯을 Row와 Column으로 구분
                          Visibility(
                            visible: _showAddress,
                            child: SizedBox(
                              height: 50, // 높이 제한
                              child: Row(
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
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Visibility(
                            visible: _showFee,
                            child: SizedBox(
                            height: 50, // 높이 제한
                              child: Row(
                                children: [
                                  Expanded(
                                    child: SetFeeWidget(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Visibility(
                            visible: _showMoveInDate,
                            child: SizedBox(
                            height: 50, // 높이 제한
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CalendarWidget(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Visibility(
                            visible: _showBuildingType,
                            child: SizedBox(
                            height: 50, // 높이 제한
                              child: Row(
                                children: [
                                  Expanded(
                                    child: SetBuildingtypeButtonsWidget(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Visibility(
                            visible: _showOptions,
                            child: SizedBox(
                            height: 50, // 높이 제한
                              child: Row(
                                children: [
                                  Expanded(
                                    child: SelectHashtagWidget(),
                                  ),
                                ],
                              ),
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
