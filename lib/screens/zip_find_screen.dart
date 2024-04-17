import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/screens/zip_detail_screen.dart'; // DetailScreen.dart를 import합니다.
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ZipFindScreen extends StatefulWidget {
  const ZipFindScreen({Key? key}) : super(key: key);

  @override
  State<ZipFindScreen> createState() => _ZipFindScreenState();
}

class _ZipFindScreenState extends State<ZipFindScreen> {
  late List<Map<String, dynamic>> jsonData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.post(Uri.parse('http://10.0.2.2/zipShowYes'));
      //final response = await http.post(Uri.parse('http://localhost/zipShowYes'));
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
                    child: Image.network('https://test.teamwaf.app/attachment/'+item['attachments']),
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