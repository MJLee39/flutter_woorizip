import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/screens/zip_detail_screen.dart'; // DetailScreen.dart를 import합니다.
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:flutter/services.dart'; // ClipboardData 가져오기
import 'package:testapp/controllers/search_condition/building_type_controller.dart';
import 'package:testapp/screens/search_type_selector.dart';
import 'package:testapp/controllers/search_condition/deposit_type_controller.dart';
import 'package:testapp/controllers/search_condition/fee_type_controller.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/text_header_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/screens/zip_update/update_zip_screen.dart';

class ZipListAgentScreen extends StatefulWidget {
  const ZipListAgentScreen({Key? key}) : super(key: key);


  @override
  State<ZipListAgentScreen> createState() => _ZipListAgentScreenState();
}

class _ZipListAgentScreenState extends State<ZipListAgentScreen> {
  late List<Map<String, dynamic>> jsonData = [];
  late String additionalArgument; // 여기에 agent id

  final BuildingTypeController buildingTypeController = Get.put(BuildingTypeController());

  // 필터 설정에 사용될 TextEditingController 선언
  final TextEditingController locationController = TextEditingController();
  final DepositController depositController = Get.put(DepositController());
  final FeeTypeController feeController = Get.put(FeeTypeController());


  @override
  void initState() {
    super.initState();
    //additionalArgument = Get.arguments;
    additionalArgument = "명진 부동산88";
    fetchData();
  }


  Future<void> fetchData() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/zipListByAgent'),
        body: jsonEncode({'agentId': additionalArgument}),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(utf8.decode(response.bodyBytes));
        print(responseData);
        setState(() {
          jsonData = responseData.cast<Map<String, dynamic>>();
        });
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void _deleteItem(String itemId) async {
    final url = 'http://10.0.2.2/delete/$itemId';

    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          jsonData.removeWhere((item) => item['id'] == itemId);
        });
        // Item successfully deleted, you might want to update your UI accordingly
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('삭제되었습니다.'),
          ),
          // Refresh the data

        );
      } else {
        throw Exception('Failed to delete item: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting item: $e');
      // Handle error
    }
  }

  void _showDeleteConfirmationDialog(String itemId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('아이템 삭제'),
          content: Text('진짜 삭제하시겠습니까?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그를 닫습니다.
              },
              child: Text('아니요'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그를 닫습니다.
                _deleteItem(itemId); // 아이템을 삭제합니다.
              },
              child: Text('예'),
            ),
          ],
        );
      },
    );
  }

  void _showEdit(String itemId){
    Get.to(UpdateAddressScreen(itemId: itemId), transition: Transition.noTransition);
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: PageNormalPaddingWidget(
      child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          const TextHeaderWidget(text: "내가 올린 매물"),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(16.0),

                itemCount: jsonData.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = jsonData[index];

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
                            child: Image.network(
                              'https://test.teamwaf.app/attachment/' + item['attachments'],
                              fit: BoxFit.cover,
                              width: 100, // 이미지의 가로 길이를 조절합니다.
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "월세 " + item['deposit'].toString() + "/" + item['fee'].toString(),
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text((item['m2'] * 0.3025).toStringAsFixed(2).toString() + "평|" +
                                      item['buildingFloor'].toString() + "층/" + item['totalFloor'].toString() +
                                      "층|" + item['direction']),
                                  Text(item['location'] + "|" + item['buildingType']),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          // Handle edit action
                                          _showEdit(item['id']);
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          // Handle delete action
                                          _showDeleteConfirmationDialog(item['id']);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
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