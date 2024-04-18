import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/client/number_input_widget.dart';
import 'package:testapp/widgets/client/calendar_widget.dart';
import 'package:testapp/screens/read_all_condition_screen.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/widgets/text_header_widget.dart';

class AddConditionScreen extends StatefulWidget {
  const AddConditionScreen({super.key});

  @override
  _AddConditionScreenState createState() => _AddConditionScreenState();

}

class _AddConditionScreenState extends State<AddConditionScreen> {
  late List<bool> isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = List<bool>.filled(20, false);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> buttonRows = [];

    final buttonLabels = [
      '풀옵션', '주차가능', '엘리베이터', '베란다', '보안/안전시설',
      '단기임대', '역세권', '붙박이 옷장', '1종 근린', '2종 근린',
      '반려동물 가능', '신축', '에어컨', '냉장고', '세탁기',
      '신발장', '싱크대', '인덕션', 'CCTV', '사용자 등록'
    ];

    const buttonWidth = 120.0; // 버튼의 너비

    for (int i = 0; i < buttonLabels.length; i += 2) {
      buttonRows.add(
        SizedBox(
          width: buttonWidth * 2 + 10, // 버튼 너비 * 2 + 간격
          child: ToggleButtons(
            isSelected: isSelected.sublist(i, i + 2),
            onPressed: (int index) {
              setState(() {
                isSelected[i + index] = !isSelected[i + index];
              });
              // TODO: 선택된 버튼에 대한 작업 수행
            },
            fillColor: Colors.indigo[200],
            selectedColor: Colors.white,
            splashColor: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            children: [
              SizedBox(width: buttonWidth, child: Center(child: Text(buttonLabels[i]))),
              SizedBox(width: buttonWidth, child: Center(child: Text(buttonLabels[i + 1]))),
            ],
          ),
        ),
      );

      // 각 행과 행 사이에 간격을 두기 위한 SizedBox 추가
      buttonRows.add(const SizedBox(height: 10));
    }

    return Scaffold(
      appBar: const AppBarWidget(),
      body: PageNormalPaddingWidget(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            
        
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextHeaderWidget(text: '원하시는 조건을 설정해보세욘'),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "가격대: ~",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(child: NumberInputWidget()),
        
                  Expanded(
                    child: Text(
                      "만원까지",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
        
              const SizedBox(width: 10),
              TextButton(
                  onPressed: () {
                    Get.toNamed('/setmoveindate');
                  },
                  child: Text('확인'),
              ),


              const SizedBox(height: 40),
              const Text(
                '원하는 옵션을 선택해주세요',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              Column(children: buttonRows),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => ReadAllConditionScreen(),
                  transition: Transition.cupertino);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo, // 버튼의 배경색을 인디고 색상으로 설정
                ),
                child: const Text(
                  '확인',
                  style: TextStyle(
                    color: Colors.white, // 버튼의 텍스트 색상을 흰색으로 설정
                  ),
                ),
              ),
        
            ],
          ),
        ),
      ),
    );
  }
}
