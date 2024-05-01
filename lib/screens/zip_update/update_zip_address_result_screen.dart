import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/screens/zip_update/update_zip_screen.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/text_header_widget.dart';
import 'package:testapp/controllers/zip_registration_controller.dart';

class UpdateZipAddressResultScreen extends StatelessWidget {
  const UpdateZipAddressResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments ?? {};

    // Extract data from arguments
    final String id = args['id'];
    final String selectedAddress = args['selectedAddress'] ?? '';
    final String selectedDong = args['selectedDong'] ?? '';
    final String selectedFloor = args['selectedFloor'] ?? '';
    final String selectedHo = args['selectedHo'] ?? '';

    final zipRegistration = Get.put(ZipRegistration());
    zipRegistration.setArguments(Get.arguments);

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

            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                // Navigate to UpdatePictureScreen when the button is pressed
                Get.to(() => UpdateAddressScreen(itemId: id), arguments: {
                  'updatedLocation': selectedAddress, // 수정된 주소 전달
                });
              },
              child: const Text("확인"),
            ),
          ],
        ),
      ),
    );
  }
}
