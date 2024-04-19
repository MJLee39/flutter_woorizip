import 'package:flutter/material.dart';

class CardListViewWidget extends StatelessWidget {
  const CardListViewWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Column(
        children: [
          // 카드 1
          Column(
            children: [
              ListTile(
                title: Text('더미 카드 1'),
                subtitle: Text('이것은 더미 카드 1입니다.'),
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text('내용 1'),
                subtitle: Text('카드 1의 첫 번째 내용입니다.'),
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text('내용 2'),
                subtitle: Text('카드 1의 두 번째 내용입니다.'),
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text('내용 3'),
                subtitle: Text('카드 1의 세 번째 내용입니다.'),
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text('내용 4'),
                subtitle: Text('카드 1의 네 번째 내용입니다.'),
              ),
            ],
          ),
          SizedBox(height: 20),
          // 카드 2
          Column(
            children: [
              ListTile(
                title: Text('더미 카드 2'),
                subtitle: Text('이것은 더미 카드 2입니다.'),
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text('내용 1'),
                subtitle: Text('카드 2의 첫 번째 내용입니다.'),
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text('내용 2'),
                subtitle: Text('카드 2의 두 번째 내용입니다.'),
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text('내용 3'),
                subtitle: Text('카드 2의 세 번째 내용입니다.'),
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text('내용 4'),
                subtitle: Text('카드 2의 네 번째 내용입니다.'),
              ),
            ],
          ),
          SizedBox(height: 20),
          // 카드 3
          Column(
            children: [
              ListTile(
                title: Text('더미 카드 3'),
                subtitle: Text('이것은 더미 카드 3입니다.'),
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text('내용 1'),
                subtitle: Text('카드 3의 첫 번째 내용입니다.'),
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text('내용 2'),
                subtitle: Text('카드 3의 두 번째 내용입니다.'),
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text('내용 3'),
                subtitle: Text('카드 3의 세 번째 내용입니다.'),
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text('내용 4'),
                subtitle: Text('카드 3의 네 번째 내용입니다.'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
