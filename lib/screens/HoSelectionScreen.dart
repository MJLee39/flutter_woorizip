import 'package:flutter/material.dart';
import 'package:testapp/controllers/ApiController.dart';
import 'package:testapp/screens/ResultSummaryScreen.dart';

class HoSelectionScreen extends StatefulWidget {
  final ApiController apiController;
  final Map<String, dynamic> addressData;
  final String selectedDong;
  final String selectedFloor;

  HoSelectionScreen({Key? key, required this.apiController, required this.addressData, required this.selectedDong, required this.selectedFloor}) : super(key: key);

  @override
  _HoSelectionScreenState createState() => _HoSelectionScreenState();
}

class _HoSelectionScreenState extends State<HoSelectionScreen> {
  late List<String> hoList;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHos();
  }

  fetchHos() async {
    Map<String, dynamic> detailData = await widget.apiController.fetchDetailAddress(
      widget.addressData['admCd'],
      widget.addressData['rnMgtSn'],
      widget.addressData['udrtYn'],
      'ho',
      widget.selectedDong,
      widget.addressData['buldMnnm'],
      widget.addressData['buldSlno'],
    );

    if (detailData.isNotEmpty && detailData[widget.selectedDong] != null && detailData[widget.selectedDong]!.containsKey(widget.selectedFloor)) {
      setState(() {
        hoList = detailData[widget.selectedDong]![widget.selectedFloor]!;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("호 선택"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: hoList.length,
              itemBuilder: (context, index) {
                String ho = hoList[index];
                return ListTile(
                  title: Text("$ho"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultSummaryScreen(
                          selectedAddress: widget.addressData['roadAddr'],
                          selectedDong: widget.selectedDong,
                          selectedFloor: widget.selectedFloor,
                          selectedHo: ho,
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
