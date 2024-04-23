import 'package:flutter/material.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/screens/zip_detail_screen.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/zip_find_controller.dart';
import 'package:testapp/controllers/search_condition/building_type_controller.dart';
import 'package:testapp/screens/search_type_selector.dart';
import 'package:testapp/controllers/search_condition/deposit_type_controller.dart';
import 'package:testapp/controllers/search_condition/fee_type_controller.dart';

class ZipFindScreen extends StatelessWidget {
  final ZipFindController _controller = Get.put(ZipFindController());
  final BuildingTypeController buildingTypeController = Get.put(BuildingTypeController());

  // 필터 설정에 사용될 TextEditingController 선언
  final TextEditingController locationController = TextEditingController();
  final DepositController depositController = Get.put(DepositController());
  final FeeTypeController feeController = Get.put(FeeTypeController());

  @override
  Widget build(BuildContext context) {
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
                          feeController: feeController
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
                        child: Image.network('https://test.teamwaf.app/attachment/'+item['attachments'],
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
            },
          );
        }
      }),
      bottomNavigationBar: BottomNavigationWidget(),
    );
  }

  Widget buildBuildingTypeButton(String buttonText, bool isSelected) {
    return GetBuilder<BuildingTypeController>(
      builder: (controller) {
        final buttonColor = controller.buttonColors[buttonText] ?? Colors.grey;
        return ElevatedButton(
          onPressed: () {
            controller.toggleSelection(buttonText);
          },
          child: Text(buttonText),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(buttonColor),
            // ... 기존 스타일 속성 유지
          ),
        );
      },
    );
  }
}
