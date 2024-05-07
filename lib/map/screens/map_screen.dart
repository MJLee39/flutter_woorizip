import 'package:testapp/screens/zip_detail_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';
import 'package:testapp/map/dto/custom_location.dart';
import 'package:testapp/map/provider/map_provider.dart';
import 'package:testapp/controllers/map_controller.dart';
import 'package:testapp/widgets/app_bar_widget.dart';

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
              return ListTile(
                title: Text('보증금/월세 : ${item['money']}'),
                subtitle: Text('건물 유형: ${item['buildingType']}'),
                onTap: () {
                  Get.toNamed('page/zipDetail', arguments: item['id']);
                },
              );
            },
          );
        }
      },
    );
  }
}
