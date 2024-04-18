import 'package:flutter/material.dart';
import 'package:testapp/widgets/client/card_container_widget.dart';
import 'package:testapp/widgets/client/search_button_widget.dart';

class ReadAllConditionScreen extends StatefulWidget {
  const ReadAllConditionScreen({Key? key}) : super(key: key);

  @override
  _ReadAllConditionScreenState createState() => _ReadAllConditionScreenState();
}

class _ReadAllConditionScreenState extends State<ReadAllConditionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('등록하신 조건들이에요'),
      ),
      body: Center(
        child: Text('All conditions will be displayed here.'),
      ),
    );
  }
}
