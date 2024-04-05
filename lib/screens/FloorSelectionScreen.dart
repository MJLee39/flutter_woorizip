import 'package:flutter/material.dart';
import 'package:testapp/controllers/ApiController.dart';
import 'package:testapp/screens/HoSelectionScreen.dart';

class FloorSelectionScreen extends StatefulWidget {
  final ApiController apiController;
  final Map<String, dynamic> addressData;
  final String selectedDong;
  

  FloorSelectionScreen({Key? key, required this.apiController, required this.addressData, required this.selectedDong}) : super(key: key);

  @override
  _FloorSelectionScreenState createState() => _FloorSelectionScreenState();
}

class _FloorSelectionScreenState extends State<FloorSelectionScreen> {
  late List<String> floorList;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFloors();
  }

  fetchFloors() async {
    Map<String, dynamic> detailData = await widget.apiController.fetchDetailAddress(
      widget.addressData['admCd'],
      widget.addressData['rnMgtSn'],
      widget.addressData['udrtYn'],
      'floor',
      widget.selectedDong, 
      widget.addressData['buldMnnm'],
      widget.addressData['buldSlno'],
    );

    if (detailData.isNotEmpty && detailData.containsKey(widget.selectedDong)) {
      setState(() {
        floorList = detailData[widget.selectedDong]!.keys.toList();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("층 선택"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: floorList.length,
              itemBuilder: (context, index) {
                String floor = floorList[index];
                return ListTile(
                  title: Text("$floor"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HoSelectionScreen(
                          apiController: widget.apiController,
                          addressData: widget.addressData,
                          selectedDong: widget.selectedDong,
                          selectedFloor: floor,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
