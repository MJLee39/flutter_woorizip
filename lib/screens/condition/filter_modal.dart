import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/condition_controller.dart';
import 'package:testapp/widgets/client/calendar_widget.dart';
import 'package:testapp/widgets/client/juso_dong_dropdown_widget.dart';
import 'package:testapp/widgets/client/juso_gu_dropdown_widget.dart';
import 'package:testapp/widgets/client/juso_si_dropdown_widget.dart';
import 'package:testapp/widgets/client/select_hashtag_widget.dart';
import 'package:testapp/widgets/client/set_buildingtype_buttons_widget.dart';
import 'package:testapp/widgets/client/set_fee_widget.dart';
import 'package:intl/intl.dart';

class FilterModal extends StatefulWidget {
  const FilterModal({Key? key});

  @override
  State<FilterModal> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterModal> {
  final ConditionController controller = Get.find<ConditionController>();
  String _selectedSi = '';
  String _selectedGu = '';
  String _selectedDong = '';
  String _selectedBuildingType = '';
  String _selectedFee = '';
  String _selectedMoveInDate = '';
  String _selectedHashtag = '';

  bool _showAddress = false;
  bool _showBuildingType = false;
  bool _showFee = false;
  bool _showMoveInDate = false;
  bool _showOptions = false;

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
                return StatefulBuilder(
                  builder: (BuildContext context, StateSetter modalSetState) {
                    return SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      print("_showAddress: "+_showAddress.toString());
                                      modalSetState(() {
                                        print("selected location");
                                        _showAddress = true;
                                        _showBuildingType = false;
                                        _showFee = false;
                                        _showMoveInDate = false;
                                        _showOptions = false;
                                      });
                                    },
                                    child: const Text('주소'),
                                  ),
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      modalSetState(() {
                                        print("selected building type");
                                        _showAddress = false;
                                        _showBuildingType = true;
                                        _showFee = false;
                                        _showMoveInDate = false;
                                        _showOptions = false;
                                      });
                                    },
                                    child: const Text('건물 유형'),
                                  ),
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      modalSetState(() {
                                        print("selected fee");
                                        _showAddress = false;
                                        _showBuildingType = false;
                                        _showFee = true;
                                        _showMoveInDate = false;
                                        _showOptions = false;
                                      });
                                    },
                                    child: const Text('금액'),
                                  ),
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      modalSetState(() {
                                        print("selected moveInDate");
                                        _showAddress = false;
                                        _showBuildingType = false;
                                        _showFee = false;
                                        _showMoveInDate = true;
                                        _showOptions = false;
                                      });
                                    },
                                    child: const Text('입주가능일'),
                                  ),
                                ),
                                // Expanded(
                                //   child: ElevatedButton(
                                //     onPressed: () {
                                //       modalSetState(() {
                                //         print("selected hashtag");
                                //         _showAddress = false;
                                //         _showBuildingType = false;
                                //         _showFee = false;
                                //         _showMoveInDate = false;
                                //         _showOptions = true;
                                //       });
                                //     },
                                //     child: const Text('옵션'),
                                //   ),
                                // ),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            Visibility(
                              visible: _showAddress,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: JusoSiDropdownWidget(
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedSi = value;
                                          controller.si = value;
                                        });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: JusoGuDropdownWidget(
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedGu = value;
                                          controller.gu = value;
                                        });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: JusoDongDropdownWidget(
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedDong = value;
                                          controller.dong = value;
                                          controller.location = controller.si + " " + controller.gu + " " + controller.dong;
                                          print(controller.location);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: _showFee,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: SetFeeWidget(
                                      onChanged: (value) {
                                        setState(() {
                                          print(value.runtimeType);
                                          _selectedFee = value.toString();
                                          print(_selectedFee);
                                          controller.fee = value;
                                          print(controller.fee);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: _showMoveInDate,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CalendarWidget(
                                      onChanged: (value) {
                                        setState(() {
                                          DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
                                          String formattedDate = dateFormatter.format(value as DateTime);

                                          _selectedMoveInDate = formattedDate;
                                          print('** ');
                                          print(_selectedMoveInDate);

                                          controller.moveInDate = value;
                                          print(controller.moveInDate);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: _showBuildingType,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: SetBuildingtypeButtonsWidget(
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedBuildingType = value;
                                          controller.buildingType = value;
                                          print(controller.buildingType);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Visibility(
                            //   visible: _showOptions,
                            //   child: Row(
                            //     children: [
                            //       Expanded(
                            //         child: SelectHashtagWidget(
                            //           onChanged: (value) {
                            //             setState(() {
                            //               _selectedHashtag += value;
                            //               controller.hashtag += value;
                            //               print(controller.hashtag);
                            //             });
                            //           },
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),

                            const SizedBox(height: 30),
                            Text('주소: ' + _selectedSi + " " + _selectedGu + " " + _selectedDong),
                            const SizedBox(height: 10),
                            Text('건물 유형: ' + _selectedBuildingType),
                            const SizedBox(height: 10),
                            Text('금액: ${_selectedFee as String}'),
                            const SizedBox(height: 10),
                            Text('입주 가능일: ' + _selectedMoveInDate),
                            const SizedBox(height: 10),
                            // Text('옵션: ' + _selectedHashtag),
                            // const SizedBox(height: 10),
                            // 검색 버튼 추가
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    print(controller.location);
                                    print(controller.buildingType);
                                    print(controller.fee);
                                    print(controller.moveInDate);

                                    controller.readByWhereCondition();
                                    Navigator.pop(context);
                                    Get.toNamed('/conditionreadbywhere');
                                  },
                                  child: const Text('검색하기'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
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
