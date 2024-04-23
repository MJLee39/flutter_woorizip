import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OtherLoginSmallButtonWidget extends StatefulWidget {
  const OtherLoginSmallButtonWidget({super.key});

  @override
  _OtherLoginSmallButtonWidgetState createState() =>
      _OtherLoginSmallButtonWidgetState();
}

class _OtherLoginSmallButtonWidgetState
    extends State<OtherLoginSmallButtonWidget> {
  bool _isHoveringNaver = false;
  bool _isHoveringGoogle = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ButtonBar(
          children: [
            InkWell(
              onTap: () {
                // 네이버 로그인 버튼 클릭 시 실행할 코드
                print('네이버 로그인 버튼 클릭');
              },
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              hoverColor: Colors.grey[200],
              child: MouseRegion(
                onEnter: (_) {
                  setState(() {
                    _isHoveringNaver = true;
                  });
                },
                onExit: (_) {
                  setState(() {
                    _isHoveringNaver = false;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[100]!),
                    borderRadius: BorderRadius.circular(6),
                    color: _isHoveringNaver ? Colors.grey[200] : Colors.grey[100],
                  ),
                  child: SvgPicture.asset(
                    'assets/images/icon_naver.svg',
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: () {
                // 구글 로그인 버튼 클릭 시 실행할 코드
                print('구글 로그인 버튼 클릭');
              },
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              hoverColor: Colors.grey[200],
              child: MouseRegion(
                onEnter: (_) {
                  setState(() {
                    _isHoveringGoogle = true;
                  });
                },
                onExit: (_) {
                  setState(() {
                    _isHoveringGoogle = false;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[100]!),
                    borderRadius: BorderRadius.circular(6),
                    color:
                        _isHoveringGoogle ? Colors.grey[200] : Colors.grey[100],
                  ),
                  child: SvgPicture.asset(
                    'assets/images/icon_google.svg',
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}