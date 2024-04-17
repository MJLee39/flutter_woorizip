import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/screens/zip_detail_screen.dart'; // DetailScreen.dart를 import합니다.
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ZipListAgentScreen extends StatefulWidget {
  const ZipListAgentScreen({Key? key}) : super(key: key);

  @override
  State<ZipListAgentScreen> createState() => _ZipListAgentScreenState();
}

class _ZipListAgentScreenState extends State<ZipListAgentScreen> {
  //late List<Map<String, dynamic>> jsonData = [];
  //late String additionalArgument; // 여기에 agent id

  // @override
  // void initState() {
  //   super.initState();
  //   additionalArgument = Get.arguments;
  //   fetchData();
  // }

  // Future<void> fetchData() async {
  //   try {
  //     final response = await http.post(Uri.parse('http://localhost/zipListByAgent'));
  //     //final response = await http.post(Uri.parse('http://localhost/zipShowYes'));
  //     if (response.statusCode == 200) {
  //       List<dynamic> responseData = jsonDecode(utf8.decode(response.bodyBytes));
  //       print(responseData);
  //       setState(() {
  //         jsonData = responseData.cast<Map<String, dynamic>>();
  //       });
  //     } else {
  //       throw Exception('Failed to load data: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error fetching data: $e');
  //   }
  // }

  final List<Map<String, dynamic>> jsonData = [
    {
      'id' : '067cae69-ad7a-4a46-aa2f-685c4cc83c08',
      'attachments': 'af0a4ad6-c546-45c5-b527-32ac565b7f2d',
      'm2': 33,
      'buildingType': '오피스텔',
      'location': '서울시 마포구 상암동',
      'buildingFloor': 15,
      'totalFloor': 30,
      'direction': '남동향',
      'deposit': 2000,
      'fee': 200
    },
    {
      "id": "1bd238b4-5498-41c9-b010-a8e37b2ea899",
      "attachments": "c780fa1d-bbf9-4027-9856-470340d442fe",
      "direction": "남서향",
      "totalFloor": 8,
      "buildingFloor": 2,
      "buildingType": "오피스텔",
      "deposit": 5000,
      "fee": 20,
      "m2": 30.0,
      "location": "서울시 마포구 상암동"
    }
    // 더미 데이터 추가...
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextField(

          decoration: InputDecoration(
            // enabledBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(4.0)),
            //   borderSide: BorderSide(color: Colors.black, width: 1.0),
            // ),
            hintText: '상암동',
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
          ),
        ),
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
                  },
                  child: const Icon(
                    Icons.filter_alt,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 16.0),
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
                  },
                  child: const Text(
                    '오피스텔',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),

          ),
        ),
      ),
      body: ListView.builder(
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
                    child: Image.network('https://test.teamwaf.app/attachment/'+item['attachments'],
                      fit: BoxFit.cover,),
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
      ),
      bottomNavigationBar: BottomNavigationWidget(),
    );
  }
}