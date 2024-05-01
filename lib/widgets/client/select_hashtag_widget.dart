import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/condition_controller.dart';
import 'package:testapp/controllers/condition/condition_controller.dart';

class SelectHashtagWidget extends StatefulWidget {

  final Function(String)? onChanged;
  const SelectHashtagWidget({super.key, this.onChanged});

  @override
  State<SelectHashtagWidget> createState() => SelectHashtagWidgetState();
}

final buttonLabels = [
  '풀옵션',
  '주차가능',
  '엘리베이터',
  '보안/안전시설',
  '단기임대',
  '베란다',
  '1종 근린',
  '2종 근린',
  '360° VR',
];

class SelectHashtagWidgetState extends State<SelectHashtagWidget> {
  final ConditionController controller = Get.find<ConditionController>();

  final List<bool> _selections = List.filled(buttonLabels.length, false);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 4,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 16.0,
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
        debugPrint('selectedHashtags: $selectedHashtags');
      }
    }

    controller.hashtag = selectedHashtags.join(' ');
    debugPrint('controller.hashtag.value: ${controller.hashtag}');

    if (widget.onChanged != null) {
      widget.onChanged!(controller.hashtag);
    }
  }
}
