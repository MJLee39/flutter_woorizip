import 'package:flutter/material.dart';

class FindRoomFilterScreen extends StatefulWidget {
  @override
  _FindRoomFilterScreenState createState() => _FindRoomFilterScreenState();
}

class _FindRoomFilterScreenState extends State<FindRoomFilterScreen> {
  double _minBudget = 5000.0;
  double _maxBudget = 25000.0;
  double _minArea = 35.0;
  double _maxArea = 150.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('지역 목록 596개'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // 검색 기능 구현
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // 전월세 · 금액 기능 구현
                },
                child: Text('전월세 · 금액'),
              ),
              ElevatedButton(
                onPressed: () {
                  // 구조 · 면적 기능 구현
                },
                child: Text('구조 · 면적'),
              ),
              ElevatedButton(
                onPressed: () {
                  // 옵션 기능 구현
                },
                child: Text('옵션'),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Text('거래유형'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // 전세 버튼 기능 구현
                },
                child: Text('전세'),
              ),
              Text('전세'),
              Text('월세'),
            ],
          ),
          SizedBox(height: 16.0),
          Text('보증금'),
          Slider(
            value: _minBudget,
            min: 5000.0,
            max: 25000.0,
            divisions: 20,
            label: _minBudget.round().toString(),
            onChanged: (double value) {
              setState(() {
                _minBudget = value;
              });
            },
          ),
          Text('최대 ${_minBudget.round()}'),
          SizedBox(height: 16.0),
          Text('월세'),
          Slider(
            value: _maxArea,
            min: 35.0,
            max: 150.0,
            divisions: 115,
            label: _maxArea.round().toString(),
            onChanged: (double value) {
              setState(() {
                _maxArea = value;
              });
            },
          ),
          Text('최대 ${_maxArea.round()}만원'),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // 초기화 버튼 기능 구현
                },
                child: Text('초기화'),
              ),
              ElevatedButton(
                onPressed: () {
                  // 적용하기 버튼 기능 구현
                },
                child: Text('적용하기'),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Text('모게 다 9,000'),
          Text('23.82m² · 12층/13층 · 오픈형 원룸 · 강서구 등촌동'),
        ],
      ),
    );
  }
}