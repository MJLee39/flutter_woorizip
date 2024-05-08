import 'package:flutter/material.dart';
import 'package:testapp/utils/api_config.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/screens/zip_detail_screen.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/zip_find_controller.dart';
import 'package:testapp/controllers/search_condition/building_type_controller.dart';
import 'package:testapp/screens/search_type_selector.dart';
import 'package:testapp/controllers/search_condition/deposit_type_controller.dart';
import 'package:testapp/controllers/search_condition/fee_type_controller.dart';
import 'dart:async';

import '../middleware/condition_guard.dart'; // 타이머를 사용하기 위한 import 추가

class ZipFindScreen extends StatelessWidget {

  final ZipFindController _controller = Get.put(ZipFindController());
  final BuildingTypeController buildingTypeController = Get.put(BuildingTypeController());

  // 필터 설정에 사용될 TextEditingController 선언
  final TextEditingController locationController = TextEditingController();
  final DepositController depositController = Get.put(DepositController());
  final FeeTypeController feeController = Get.put(FeeTypeController());

  @override
  Widget build(BuildContext context) {


    Get.put(ConditionGuard());

    // 타이머 설정: 5초 후에 ConditionGuard 호출
    Timer(Duration(seconds: 5), () {
      Get.find<ConditionGuard>().onPageCalled(null);
    });


    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(42.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
            child: Row(
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
                    // Handle filter
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SearchTypeSelector(
                            buildingTypeController: buildingTypeController,
                            locationController: locationController,
                            depositController: depositController,
                            feeController: feeController,
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
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          // 로딩 중일 때
          return Center(
            child: CircularProgressIndicator(), // 로딩 표시
          );
        } else if (_controller.error.value.isNotEmpty) {
          // 에러가 발생했을 때
          return Center(
            child: Text(_controller.error.value), // 에러 메시지 표시
          );
        } else {
          // 데이터 로딩 완료 후 화면 표시
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: _controller.jsonData.length,
            itemBuilder: (BuildContext context, int index) {
              final item = _controller.jsonData[index];
              // jsonData의 0번째 값이 {'placeholder': 'premiumZip이 비어있습니다.'}이 아니면서 index가 0인 경우에 네모 박스를 그립니다.
              if (index == 0 && item['placeholder'] == null) {
                return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent), // 네모 박스 스타일 설정
                      borderRadius: BorderRadius.circular(10), // 네모 박스의 모서리를 둥글게 설정
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(DetailScreen(itemID: item['id']), transition: Transition.noTransition);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0), // 여기에서 패딩 조정
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Image.network('${ApiConfig.attachmentApiEndpointUri}/'+item['attachments'],
                                  fit: BoxFit.cover),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("월세 "+item['deposit'].toString()+"/"+item['fee'].toString(),
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
                                    const SizedBox(height: 8.0),
                                    Text((item['m2']*0.3025).toStringAsFixed(2).toString()+"평 | "+item['buildingFloor'].toString()+"층/"+item['totalFloor'].toString()+"층 | "+ item['direction']),
                                    Text(item['location']+" | "+item['buildingType']),
                                    const SizedBox(height: 8.0),
                                  ],
                                ),
                              ),
                            ),
                            // 광고 추가
                            Text(
                              '광고',
                              style: TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                );
              }else{
                //premium 없음
                if(index > 0){
                  return GestureDetector(
                    onTap: () {
                      Get.to(DetailScreen(itemID: item['id']), transition: Transition.noTransition);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Image.network('${ApiConfig.attachmentApiEndpointUri}/'+item['attachments'],
                                fit: BoxFit.cover),
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("월세 "+item['deposit'].toString()+"/"+item['fee'].toString(),
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
                                  const SizedBox(height: 8.0),
                                  Text((item['m2']*0.3025).toStringAsFixed(2).toString()+"평 | "+item['buildingFloor'].toString()+"층/"+item['totalFloor'].toString()+"층 | "+ item['direction']),
                                  Text(item['location']+" | "+item['buildingType']),
                                  const SizedBox(height: 8.0),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }else {
                  // 첫 번째 아이템이 premiumZip이 비어있는 경우, 아무것도 표시하지 않습니다.
                  return SizedBox.shrink();
                }
              }
            },
          );
        }
      }),
      bottomNavigationBar: BottomNavigationWidget(),
    );
  }
}
