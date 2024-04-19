import 'package:flutter/material.dart';

class SplitTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // /my_listings 페이지로 이동하는 코드
            Navigator.pushNamed(context, '/my_listings').then((selectedItem) {
              // 선택한 정보를 처리하는 코드
              if (selectedItem != null) {
                // 선택한 정보가 null이 아닌 경우에만 처리
                // 여기서 필요한 처리를 수행하세요
                print('Selected Item: $selectedItem');
              }
            });
          },
          child: Text('Go to My Listings'),
        ),
      ),
    );
  }
}
