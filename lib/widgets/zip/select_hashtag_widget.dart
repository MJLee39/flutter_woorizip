import 'package:flutter/material.dart';
import 'package:testapp/controllers/zip_registration_controller.dart';
import 'package:get/get.dart';

class SelectHashtagWidget extends StatefulWidget {

  const SelectHashtagWidget({Key? key});

  @override
  State<SelectHashtagWidget> createState() => SelectHashtagWidgetState();
}

final buttonLabels = [
  '풀옵션',
  '주차가능',
  '엘리베이터',
  '베란다',
  '보안/안전시설',
  '단기임대',
  '역세권',
  '붙박이 옷장',
  '1종 근린',
  '2종 근린',
  '반려동물 가능',
  '신축',
  '에어컨',
  '냉장고',
  '세탁기',
  '신발장',
  '인덕션',
  'CCTV',
];

class SelectHashtagWidgetState extends State<SelectHashtagWidget> {
  late List<bool> _selections;

  final ZipRegistration controller = Get.find<ZipRegistration>();

  @override
  void initState() {
    super.initState();
    _selections = List.filled(buttonLabels.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GridView.builder(
        shrinkWrap: true, // GridView가 SingleChildScrollView와 함께 사용될 때 필요합니다.
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 3,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
        itemCount: buttonLabels.length,
        itemBuilder: (context, index) {
          return ElevatedButton(
            onPressed: () {
              setState(() {
                _selections[index] = !_selections[index];
                updateHashtag();
              });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                _selections[index] ? Colors.blue : Colors.white,
              ),
              foregroundColor: MaterialStateProperty.all(
                _selections[index] ? Colors.white : Colors.black,
              ),
            ),
            child: Text(buttonLabels[index]),
          );
        },
      ),
    );
  }

  void updateHashtag() {
    List<String> selectedHashtags = [];
    for (int i = 0; i < _selections.length; i++) {
      if (_selections[i]) {
        selectedHashtags.add(buttonLabels[i]);
        print('selectedHashtags: ' + selectedHashtags.toString());
      }
    }

    controller.hashtag = selectedHashtags.join(' ');
    print('!!!!!!!!!!!!!!!!!controller.hashtag.value: ' + controller.hashtag);
  }
}
