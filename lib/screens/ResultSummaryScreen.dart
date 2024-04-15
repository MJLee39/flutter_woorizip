import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:testapp/screens/UpdatePictureScreen.dart';
import 'package:testapp/widgets/AppBarWidget.dart';
import 'package:testapp/widgets/TextHeaderWidget.dart';

class ResultSummaryScreen extends StatelessWidget {
  final String selectedAddress;
  final String selectedDong;
  final String selectedFloor;
  final String selectedHo;

  const ResultSummaryScreen({
    super.key,
    required this.selectedAddress,
    required this.selectedDong,
    required this.selectedFloor,
    required this.selectedHo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextHeaderWidget(text: "선택한 정보를 확인해 주세요"),
            const SizedBox(height: 10),
            Text(selectedAddress, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            if (selectedDong != "")
              Text("$selectedDong $selectedFloor $selectedHo", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            if (selectedDong == "")
              Text("$selectedFloor $selectedHo", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        
            ElevatedButton(
              onPressed: () {
                // Navigate to UpdatePictureScreen when the button is pressed
                Get.to(() => UpdatePictureScreen());
              },
              child: const Text("확인"),
            ),
          ],
        ),
      ),
    );
  }
}
