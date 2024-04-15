import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:testapp/widgets/BottomNavigationWidget.dart';
import 'package:testapp/screens/DetailScreen.dart'; // DetailScreen.dart를 import합니다.

class ZipFindScreen extends StatefulWidget {
  const ZipFindScreen({super.key});

  @override
  State<ZipFindScreen> createState() => _ZipFindScreenState();
}

class _ZipFindScreenState extends State<ZipFindScreen> {
  String selectedRoomType = '전체';

  String selectedPrice = '전체';

  final List<Map<String, dynamic>> dummyData = [
    {
      'id' : '1',
      'image': 'https://imgdb.in/lOcP.jpg',
      'price': '1000/60',
      'info': '오피스텔, 19.83m², 관리비 30',
      'location': '수색역 숨이 찰때까지 뛰면 10분내 도착가능',
      'description': '옛날엔 고급 건물이였어요',
    },
    {
      'id' : '2',
      'image': 'https://imgdb.in/lOcT.jpg',
      'price': '2000/50',
      'info': '오피스텔, 15m², 관리비 25',
      'location': '첨단산업단지 도보 3분 풀옵션',
      'description': '아담하고 깔끔한 오피스텔입니다',
    },
    {
      'id' : '3',
      'image': 'https://imgdb.in/lOcT.jpg',
      'price': '2000/50',
      'info': '오피스텔, 15m², 관리비 25',
      'location': '첨단산업단지 도보 3분 풀옵션',
      'description': '아담하고 깔끔한 오피스텔입니다',
    },
    {
      'id' : '4',
      'image': 'https://imgdb.in/lOcT.jpg',
      'price': '2000/50',
      'info': '오피스텔, 15m², 관리비 25',
      'location': '첨단산업단지 도보 3분 풀옵션',
      'description': '아담하고 깔끔한 오피스텔입니다',
    },
    {
      'id' : '5',
      'image': 'https://imgdb.in/lOcT.jpg',
      'price': '2000/50',
      'info': '오피스텔, 15m², 관리비 25',
      'location': '첨단산업단지 도보 3분 풀옵션',
      'description': '아담하고 깔끔한 오피스텔입니다',
    },
    {
      'id' : '6',
      'image': 'https://imgdb.in/lOcT.jpg',
      'price': '2000/50',
      'info': '오피스텔, 15m², 관리비 25',
      'location': '첨단산업단지 도보 3분 풀옵션',
      'description': '아담하고 깔끔한 오피스텔입니다',
    },
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
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: dummyData.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          final item = dummyData[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(itemID: item['id']), // DetailScreen으로 이동하면서 itemID를 전달합니다.
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Image.network(item['image']),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['price'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(item['info']),
                          Text(item['location']),
                          if (item['description'].isNotEmpty) Text(item['description']),
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