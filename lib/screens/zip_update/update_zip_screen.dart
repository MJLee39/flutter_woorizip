import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/controllers/zip_detail_controller.dart'; // ZipDataController를 가져옵니다.
import 'package:testapp/widgets/text_header_widget.dart';
import 'package:testapp/widgets/zip/rigister_buttons_widget.dart';
import 'package:testapp/controllers/zip_registration_controller.dart';
import 'package:get/get.dart';

import '../../widgets/zip/update_button_widget.dart';

class UpdateAddressScreen extends StatefulWidget {
  final String itemId;

  const UpdateAddressScreen({Key? key, required this.itemId}) : super(key: key);

  @override
  _UpdateAddressScreenState createState() => _UpdateAddressScreenState();
}

class _UpdateAddressScreenState extends State<UpdateAddressScreen> {
  final ZipDataController _zipDataController = ZipDataController();
  late Future<Map<String, dynamic>> _futureZipData;

  final TextEditingController _maintenanceFeeController = TextEditingController();
  final TextEditingController _directionController = TextEditingController();
  final TextEditingController _buildingFloorController = TextEditingController();
  final TextEditingController _totalFloorController = TextEditingController();
  final TextEditingController _buildingTypeController = TextEditingController();
  final TextEditingController _depositController = TextEditingController();
  final TextEditingController _feeController = TextEditingController();
  final TextEditingController _hashtagController = TextEditingController();
  final TextEditingController _m2Controller = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _roomController = TextEditingController();
  final TextEditingController _toiletController = TextEditingController();

  final TextEditingController _checkedAtController = TextEditingController();
  final TextEditingController _availableController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _futureZipData = _zipDataController.fetchZipData(widget.itemId);
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments ?? {};

    final controller = Get.put(ZipRegistration());
    return Scaffold(
      appBar: const AppBarWidget(),
      body: PageNormalPaddingWidget(
        child: FutureBuilder<Map<String, dynamic>>(
          future: _futureZipData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final zipData = snapshot.data!;
              final id = zipData['id'];
              final maintenanceFee = zipData['maintenanceFee'];
              final direction = zipData['direction'];
              final buildingFloor = zipData['buildingFloor'];
              final totalFloor = zipData['totalFloor'].toString();
              final buildingType = zipData['buildingType'];
              final deposit = zipData['deposit'];
              final fee = zipData['fee'];
              final hashtag = zipData['hashtag'];
              final m2 = zipData['m2'];
              final note = zipData['note'];
              final room = zipData['room'];
              final toilet = zipData['toilet'];
              final estate = zipData['estateId'];
              final checkedAt = zipData['checkedAt'];
              final available = zipData['available'];

              // FutureBuilder에서 받아온 값을 각각의 TextEditingController에 설정합니다.
              _maintenanceFeeController.text = maintenanceFee.toString();
              _directionController.text = direction.toString();
              _buildingFloorController.text = buildingFloor.toString();
              _buildingTypeController.text = buildingType.toString();
              _depositController.text = deposit.toString();
              _feeController.text = fee.toString();
              _hashtagController.text = hashtag.toString();
              _m2Controller.text = m2.toString();
              _noteController.text = note.toString();
              _roomController.text = room.toString();
              _toiletController.text = toilet.toString();
              _totalFloorController.text = totalFloor.toString();
              _checkedAtController.text = checkedAt.toString();
              _availableController.text = available.toString();


              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                    children: [
                      const SizedBox(height: 20),
                      const TextHeaderWidget(text: '수정할 내용을 알려주세요'),
                      const SizedBox(height: 30),

                      Text(
                        '건물 위치',
                        style: TextStyle(fontSize: 13),
                      ),
                      Row(
                        children: [
                          // 건물 위치를 보여주는 Text 위젯 추가
                          Text(
                            '${zipData['location']}',
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),

                      // 건물 사진 수정 버튼
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed("/update_zip_picture_screen", arguments: {
                            'id': id, // id 값을 arguments로 전달
                          });
                        },
                        child: Text('매물 사진 수정하기'),
                      ),

                      // 텍스트 필드를 스크롤 가능하게 만듭니다.
                      TextField(
                        controller: _maintenanceFeeController,
                        decoration: InputDecoration(
                          labelText: '관리비를 만원 단위로 입력해주세요',
                          hintText: '수정값을 입력해주세요',
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _directionController,
                        decoration: InputDecoration(
                          labelText: '거실 기준 방향을 입력해주세요',
                          hintText: '수정값을 입력해주세요',
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _buildingFloorController,
                        decoration: InputDecoration(
                          labelText: '매물의 층을 입력해주세요',
                          hintText: '수정값을 입력해주세요',
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _buildingTypeController,
                        decoration: InputDecoration(
                          labelText: '건물 유형을 입력해주세요',
                          hintText: '수정값을 입력해주세요',
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _depositController,
                        decoration: InputDecoration(
                          labelText: '보증금을 만원 단위로 입력해주세요',
                          hintText: '수정값을 입력해주세요',
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _feeController,
                        decoration: InputDecoration(
                          labelText: '월세를 만원 단위로 입력해주세요',
                          hintText: '수정값을 입력해주세요',
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _hashtagController,
                        decoration: InputDecoration(
                          labelText: '옵션을 입력해주세요',
                          hintText: '수정값을 입력해주세요',
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _m2Controller,
                        decoration: InputDecoration(
                          labelText: '면적을 입력해주세요',
                          hintText: '수정값을 입력해주세요',
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _noteController,
                        decoration: InputDecoration(
                          labelText: '메모를 입력해주세요',
                          hintText: '수정값을 입력해주세요',
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _roomController,
                        decoration: InputDecoration(
                          labelText: '방 수를 입력해주세요',
                          hintText: '수정값을 입력해주세요',
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _toiletController,
                        decoration: InputDecoration(
                          labelText: '화장실 수를 입력해주세요',
                          hintText: '수정값을 입력해주세요',
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _checkedAtController,
                        decoration: InputDecoration(
                          labelText: '확인일자를 입력해주세요',
                          hintText: '수정값을 입력해주세요',
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _availableController,
                        decoration: InputDecoration(
                          labelText: '입주가능일을 입력해주세요',
                          hintText: '수정값을 입력해주세요',
                        ),
                      ),
                      const SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                        children: [
                          Text("공개 여부를 선택해주세요"),
                          const SizedBox(height: 5),
                          Obx(() => Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: controller.showYes.value == 'public' ? Colors.blue : Colors.grey, // 공개 상태일 때 파란색, 아닐 때 회색
                                    textStyle: TextStyle(color: Colors.black, fontSize: 16), // 폰트 크기 조정
                                    padding: EdgeInsets.symmetric(vertical: 10), // 버튼 내부 패딩 조정
                                  ),
                                  onPressed: () {
                                    // 선택된 값이 공개로 설정됨
                                    controller.showYes.value = 'public';
                                  },
                                  child: Text('공개'),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: controller.showYes.value == 'private' ? Colors.blue : Colors.grey, // 비공개 상태일 때 파란색, 아닐 때 회색
                                    textStyle: TextStyle(color: Colors.black, fontSize: 16), // 폰트 크기 조정
                                    padding: EdgeInsets.symmetric(vertical: 10), // 버튼 내부 패딩 조정
                                  ),
                                  onPressed: () {
                                    // 선택된 값이 비공개로 설정됨
                                    controller.showYes.value = 'private';
                                  },
                                  child: Text('비공개'),
                                ),
                              ),
                            ],
                          )),
                        ],
                      ),
                      const SizedBox(height: 40),
                      // 수정 버튼을 추가합니다.
                      UpdateButtonWidget(
                        text: '수정하기',
                        onPressed: () {
                          // 수정된 값을 가져올 수 있습니다.
                          final updatedMaintenanceFee = _maintenanceFeeController.text;
                          final updatedDirection = _directionController.text;
                          final updatedBuildingFloor = _buildingFloorController.text;
                          final updatedBuildingType = _buildingTypeController.text;
                          final updatedDeposit = _depositController.text;
                          final updatedFee = _feeController.text;
                          final updatedHashtag = _hashtagController.text;
                          final updatedM2 = _m2Controller.text;
                          final updatedNote = _noteController.text;
                          final updatedRoom = _roomController.text;
                          final updatedToilet = _toiletController.text;
                          final updatedCheckedAt = _checkedAtController.text;
                          final updatedAvailable = _availableController.text;

                          // 수정된 값을 사용하여 추가 작업을 수행할 수 있습니다.
                          controller.updateValues(
                            estate: '${estate}',
                            attachments: '${controller.attachments}',
                            building_floor: int.tryParse(updatedBuildingFloor) ?? 0,
                            totalFloor: int.tryParse(totalFloor) ?? 0,
                            deposit: int.tryParse(updatedDeposit) ?? 0,
                            fee: int.tryParse(updatedFee) ?? 0,
                            maintenanceFee: double.tryParse(updatedMaintenanceFee) ?? 0,
                            buildingType: updatedBuildingType,
                            direction: updatedDirection,
                            moveInDate: DateTime.parse(updatedAvailable),
                            room: int.tryParse(updatedRoom) ?? 0,
                            toilet: int.tryParse(updatedToilet) ?? 0,
                            m2: double.tryParse(updatedM2) ?? 0,
                            checkedAt: DateTime.parse(updatedCheckedAt),
                            note: updatedNote,
                            showYes: '${controller.showYes}',
                            hashtag: updatedHashtag
                          );
                          controller.updateZip('${id}');

                          // 화면을 '/my_listings'로 이동합니다.
                          Navigator.pushNamed(context, '/my_listings');
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}