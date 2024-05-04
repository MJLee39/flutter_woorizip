import 'package:flutter/material.dart';
import 'package:testapp/widgets/app_bar_widget.dart';

class MyinfoScreen extends StatelessWidget {
  const MyinfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: '내 정보'),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[300],
          ),
          SizedBox(height: 20),
          ListTile(
            title: Text('연결된 소셜 계정'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            title: Text('닉네임'),
            subtitle: Text('매력적인 창문'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            title: Text('휴대폰 번호'),
            subtitle: Text('인증을 진행해주세요.'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          SizedBox(height: 20),
          const Divider(
            color: Colors.grey,
            height: 20,
            thickness: 0.5,
          ),
          ListTile(
            title: Text('회원탈퇴'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
