import 'package:testapp/screens/test/room_detail_screen.dart';
import 'package:testapp/screens/zip_detail_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';
import 'package:testapp/map/dto/custom_location.dart';
import 'package:testapp/map/provider/map_provider.dart';
import 'package:testapp/controllers/map_controller.dart';
import 'package:testapp/widgets/app_bar_widget.dart';

import '../../utils/api_config.dart';

class MapScreen extends StatelessWidget {

  MapScreen({Key? key, required this.buildingType}) : super(key: key);

  final MapProvider mapProvider = MapProvider();
  final String buildingType;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: '지도로 찾기'),
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

class BottomSheetContent extends StatefulWidget {
  final ScrollController scrollController;
  final CustomLocation? customLocation;

  BottomSheetContent({required this.scrollController, required this.customLocation});

  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  DataController _dataController = DataController();

  List<Map<String, String>> data = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      List<Map<String, String>> result = await _dataController.fetchData(widget.customLocation!);
        setState(() {
          data = result;
        });
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, String>>>(
      future: _dataController.fetchData(widget.customLocation!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('에러: ${snapshot.error}'));
        } else {
          List<Map<String, String>> data = snapshot.data!;
          return ListView.builder(
            controller: widget.scrollController,
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              return GestureDetector(
                onTap: () {
                  Get.to(RoomDetailScreen(itemID: '${item["id"]}'), transition: Transition.noTransition);
                },
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 이미지 표시
                        Container(
                          width: 100, // 이미지의 폭 설정
                          height: 80, // 이미지의 높이 설정
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10), // 이미지 모서리 둥글게 설정
                            image: DecorationImage(
                              image: NetworkImage(
                                  '${ApiConfig.attachmentApiEndpointUri}/'+(item['attachments']?.split(',')[0] ?? ''),
                              ),
                              fit: BoxFit.cover, // 이미지가 올바르게 표시되도록 설정
                            ),
                          ),
                        ),
                        SizedBox(width: 10), // 이미지와 텍스트 사이에 간격 추가
                        // 텍스트 정보 표시
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('보증금/월세 : ${item['money']}'),
                              Text('건물 유형: ${item['buildingType']}'),
                              Text('위치 : ${item['location']}'),
                            ],
                          ),
                        ),
                        SizedBox(width: 10), // 텍스트와 리스트 아이템 사이에 간격 추가
                      ],
                    ),
                    SizedBox(height: 10), // 아이템 사이의 간격
                    Divider(height: 1, color: Colors.grey), // 구분선 추가
                  ]
                )
              );
            },
          );
        }
      },
    );
  }
}
