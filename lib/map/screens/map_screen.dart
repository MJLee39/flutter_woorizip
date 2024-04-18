import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';
import 'package:http/http.dart' as http;
import 'package:testapp/map/dto/custom_location.dart';
import 'package:testapp/map/provider/map_provider.dart';

class MapScreen extends StatelessWidget {

  MapScreen({Key? key, required this.buildingType}) : super(key: key);

  final MapProvider mapProvider = MapProvider();
  final String buildingType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: mapProvider.getCurrentLocation(),
        builder: (context, AsyncSnapshot<CustomLocation> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Stack(
              children: [
                // 첫 번째 페이지: 지도 표시
                NaverMap(
                  initLocationTrackingMode: this.mapProvider.trackingMode,
                  initialCameraPosition: CameraPosition(
                    target: this.mapProvider.initLocation,
                  ),
                  locationButtonEnable: true,
                  onMapCreated: (NaverMapController ct) async {},
                  markers: [
                    Marker(
                      markerId: '내 위치',
                      position: snapshot.data,
                    ),
                  ],
                ),
                // 스와이프로 이동 가능한 BottomSheet
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 1,
                    child: DraggableScrollableSheet(
                      initialChildSize: 0.1,
                      minChildSize: 0.1,
                      builder: (context, scrollController) {
                        return Container(
                          color: Colors.white,
                          child: BottomSheetContent(scrollController: scrollController, customLocation: snapshot.data,),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class BottomSheetContent extends StatelessWidget {
  final ScrollController scrollController;
  final CustomLocation? customLocation;

  BottomSheetContent({required this.scrollController, required this.customLocation});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchBottomSheetData(customLocation!),
      builder: (context, AsyncSnapshot<List<Map<String, String>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DropdownButton<String>(
                      value: 'Filter 1',
                      onChanged: (newValue) {
                        // 필터링 로직 추가
                      },
                      items: <String>['Filter 1', 'Filter 2', 'Filter 3', 'Filter 4']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    DropdownButton<String>(
                      value: 'Filter A',
                      onChanged: (newValue) {
                        // 필터링 로직 추가
                      },
                      items: <String>['Filter A', 'Filter B', 'Filter C', 'Filter D']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    // Add more dropdown buttons here
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data![index];
                    return ListTile(
                      title: Text(item['title']!),
                      subtitle: Text(item['description']!),
                      onTap: () {
                        // 각 항목을 탭했을 때 수행할 작업
                      },
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Future<List<Map<String, String>>> _fetchBottomSheetData(CustomLocation customLocation) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8818/chat/qassadsadsa/room'),);
    if (response.statusCode == 200) {
      List<dynamic> responseData = jsonDecode(utf8.decode(response.bodyBytes));
      return responseData.map<Map<String, String>>((data) {
        return {
          'id': data['id'],
          'title': data['title'],
          'nickname': data['nickname'],
          'description': data['description']
        };
      }).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
