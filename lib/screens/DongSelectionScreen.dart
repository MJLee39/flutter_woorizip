import 'package:flutter/material.dart';
import 'package:testapp/controllers/ApiController.dart';
import 'package:testapp/screens/FloorSelectionScreen.dart';

class DongSelectionScreen extends StatefulWidget {
  final Map<String, dynamic> addressData;
  final ApiController apiController;

  DongSelectionScreen({Key? key, required this.addressData, required this.apiController}) : super(key: key);

  @override
  _DongSelectionScreenState createState() => _DongSelectionScreenState();
}

class _DongSelectionScreenState extends State<DongSelectionScreen> {
  late List<String> dongList;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDongs();
  }

fetchDongs() async {
  Map<String, dynamic> detailData = await widget.apiController.fetchDetailAddress(
    widget.addressData['admCd'],
    widget.addressData['rnMgtSn'],
    widget.addressData['udrtYn'],
    'dong',
    '',
    widget.addressData['buldMnnm'],
    widget.addressData['buldSlno'],
  );

  if (detailData.isNotEmpty) {
    setState(() {
      dongList = detailData.keys.toList();
      isLoading = false;
    });
  } 
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("동 선택"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: dongList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(dongList[index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FloorSelectionScreen(
                          apiController: widget.apiController,
                          addressData: widget.addressData,
                          selectedDong: dongList[index],
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
