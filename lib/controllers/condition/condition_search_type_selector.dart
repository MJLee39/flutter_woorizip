// import 'package:flutter/material.dart';
// import 'package:testapp/controllers/condition/condition_building_type_controller.dart';
// import 'package:testapp/controllers/condition/condition_controller.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:testapp/controllers/condition/condition_fee_controller.dart';
// import 'package:testapp/controllers/condition/condition_hashtag_controller.dart';
// import 'package:testapp/controllers/condition/condition_location_controller.dart';
// import 'package:testapp/controllers/condition/condition_move_in_date_controller.dart';
// import 'package:testapp/utils/app_colors.dart';

// class ConditionSearchTypeSelector extends StatefulWidget {
//   final ConditionController conditionController;
//   final ConditionLocationController locationController;
//   final ConditionBuildingTypeController buildingTypeController;
//   final ConditionFeeController feeController;
//   final ConditionMoveInDateController moveInDateController;
//   final ConditionHashtagController hashtagController;

//   ConditionSearchTypeSelector(
//       {required this.conditionController,
//       required this.locationController,
//       required this.buildingTypeController,
//       required this.feeController,
//       required this.moveInDateController,
//       required this.hashtagController});

//   @override
//   _SearchTypeSelectorState createState() => _SearchTypeSelectorState();
// }

// class _SearchTypeSelectorState extends State<ConditionSearchTypeSelector> {
//   final ConditionController controller = Get.put(ConditionController());

//   late ConditionLocationController locationController;
//   late ConditionBuildingTypeController buildingTypeController;
//   late ConditionFeeController feeController;
//   late ConditionMoveInDateController moveInDateController;
//   late ConditionHashtagController hashtagController;

//   @override
//   void initState() {
//     super.initState();
//     // 컨트롤러 초기화
//     locationController = locationController;
//     buildingTypeController = buildingTypeController;
//     feeController = feeController;
//     moveInDateController = moveInDateController;
//     hashtagController = hashtagController;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(20.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             children: [
//               Text('주소: '),
//               Expanded(
//                 child: buildBuildingTypeButton('강남구', context),
//               ),
//               Expanded(
//                 child: buildBuildingTypeButton('강동구', context),
//               ),
//               Expanded(
//                 child: buildBuildingTypeButton('강북구', context),
//               ),
//               Expanded(
//                 child: buildBuildingTypeButton('강서구', context),
//               ),
//               Expanded(
//                 child: buildBuildingTypeButton('관악구', context),
//               ),
//               Expanded(
//                 child: buildBuildingTypeButton('광진구', context),
//               ),
//               Expanded(
//                 child: buildBuildingTypeButton('구로구', context),
//               ),
//               Expanded(
//                 child: buildBuildingTypeButton('광진구', context),
//               ),
//               Expanded(
//                 child: buildBuildingTypeButton('금천구', context),
//               ),
//               Expanded(
//                 child: buildBuildingTypeButton('노원구', context),
//               ),
//               Expanded(
//                 child: buildBuildingTypeButton('도봉구', context),
//               ),
//               Expanded(
//                 child: buildBuildingTypeButton('동대문구', context),
//               ),
//               Expanded(
//                 child: buildBuildingTypeButton('동작구', context),
//               ),
//               Expanded(
//                 child: buildBuildingTypeButton('마포구', context),
//               ),
//               Expanded(
//                 child: buildBuildingTypeButton('서대문구', context),
//               ),
//               Expanded(
//                 child: buildBuildingTypeButton('서초구', context),
//               ),
//               Expanded(
//                 child: buildBuildingTypeButton('성동구', context),
//               ),
//               Expanded(
//                 child: buildBuildingTypeButton('성북구', context),
//               ),
//               Expanded(
//                 child: buildBuildingTypeButton('송파구', context),
//               ),
//               Expanded(
//                 child: buildBuildingTypeButton('양천구', context),
//               ),
//               Expanded(
//                 child: buildBuildingTypeButton('영등포구', context),
//               ),
//               Expanded(
//                 child: buildBuildingTypeButton('용산구', context),
//               ),
//               Expanded(
//                 child: buildBuildingTypeButton('은평구', context),
//               ),
//               Expanded(
//                 child: buildBuildingTypeButton('종로구', context),
//               ),
//               Expanded(
//                 child: buildBuildingTypeButton('중구', context),
//               ),
//               Expanded(
//                 child: buildBuildingTypeButton('중랑구', context),
//               ),
//             ],
//           ),
//           //
//           SizedBox(height: 20),
//           //
//           Row(
//             children: [
//               Text('유형: '),
//               Expanded(
//                 child: buildBuildingTypeButton('아파트', context),
//               ),
//               Expanded(
//                 child: buildBuildingTypeButton('오피스텔', context),
//               ),
//               Expanded(
//                 child: buildBuildingTypeButton('원룸', context),
//               ),
//               Expanded(
//                 child: buildBuildingTypeButton('투룸+', context),
//               ),
//             ],
//           ),
//           //
//           SizedBox(height: 20),
//           //
//           Row(
//             children: [
//               Text('월세: '),
//               Expanded(
//                 child: depositTypeButton('~50', context),
//               ),
//               Expanded(
//                 child: depositTypeButton('~75', context),
//               ),
//               Expanded(
//                 child: depositTypeButton('~100', context),
//               ),
//               Expanded(
//                 child: depositTypeButton('100~', context),
//               ),
//             ],
//           ),
//           SizedBox(height: 20),
//           Row(
//             children: [
//               Text('월세: '),
//               Expanded(
//                 child: feeTypeButton('~50', context),
//               ),
//               Expanded(
//                 child: feeTypeButton('~75', context),
//               ),
//               Expanded(
//                 child: feeTypeButton('~100', context),
//               ),
//               Expanded(
//                 child: feeTypeButton('100~', context),
//               ),
//             ],
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: sendRequest,
//             child: Text(
//               '검색',
//               style: TextStyle(color: Colors.white),
//             ),
//             style: ButtonStyle(
//               backgroundColor:
//                   MaterialStateProperty.all(AppColors.mainColorTest),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void sendRequest() async {
//     final selectedLocation = widget.locationController;
//     final selectedBuildingTypes =
//         widget.buildingTypeController.selectedBuildingTypes.join(',');
//     final selectedFee = widget.feeController.selectedFee;
//     final selectedMoveIdDate = widget.moveInDateController;
//     final selectedHashtag = widget.hashtagController;

//     final url = Uri.parse('http://localhost/condition/readByWhere');

//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       // 성공적인 응답 처리
//       Iterable<Map<String, dynamic>> responseData =
//           (jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>)
//               .map((dynamic item) => item as Map<String, dynamic>);
//       controller.readByWhereCondition(responseData.toList()); // 조회 기준
//     } else {
//       // 요청 실패 처리
//       print('Failed to load data: ${response.statusCode}');
//     }
//   }

//   Widget buildBuildingTypeButton(String buttonText, BuildContext context) {
//     final isSelected = widget.buildingTypeController.selectedBuildingTypes
//         .contains(buttonText);
//     final buttonColor = isSelected ? AppColors.mainColor : Colors.grey;

//     return ElevatedButton(
//       onPressed: () {
//         widget.buildingTypeController.toggleSelection(buttonText);
//         setState(() {
//           // setState를 호출하여 UI를 다시 빌드
//         });
//       },
//       child: Text(
//         buttonText,
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 10,
//           fontWeight: FontWeight.bold, // Adjusted font size
//         ),
//       ),
//       style: ButtonStyle(
//         backgroundColor: MaterialStateProperty.all(buttonColor),
//         // ... 기존 스타일 속성 유지
//       ),
//     );
//   }

//   Widget feeButton(String buttonText, BuildContext context) {
//     final isSelected =
//         widget.feeController.selectedFee == buttonText; // 해당 버튼이 선택된 상태인지 확인
//     final buttonColor =
//         isSelected ? AppColors.mainColor : Colors.grey; // 선택된 상태에 따라 버튼 색상

//     return ElevatedButton(
//       onPressed: () {
//         setState(() {
//           if (isSelected) {
//             widget.feeController.clearSelection(); // 이미 선택된 버튼이면 선택 해제
//           } else {
//             widget.feeController.clearSelection();
//             widget.feeController.toggleSelection(buttonText);
//           }
//         });
//       },
//       child: Text(buttonText,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 14,
//           )),
//       style: ButtonStyle(
//         backgroundColor: MaterialStateProperty.all(buttonColor),
//         // ... 기존 스타일 속성 유지
//       ),
//     );
//   }

//   Widget moveInDateButton(String buttonText, BuildContext context) {
//     final isSelected =
//         widget.moveInDateController == buttonText; // 해당 버튼이 선택된 상태인지 확인
//     final buttonColor =
//         isSelected ? AppColors.mainColor : Colors.grey; // 선택된 상태에 따라 버튼 색상

//     return ElevatedButton(
//       onPressed: () {
//         setState(() {
//           if (isSelected) {
//             widget.moveInDateController; // 이미 선택된 버튼이면 선택 해제
//           } else {
//             widget.feeController.clearSelection();
//             widget.feeController.toggleSelection(buttonText);
//           }
//         });
//       },
//       child: Text(buttonText,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 14,
//           )),
//       style: ButtonStyle(
//         backgroundColor: MaterialStateProperty.all(buttonColor),
//         // ... 기존 스타일 속성 유지
//       ),
//     );
//   }
// }
