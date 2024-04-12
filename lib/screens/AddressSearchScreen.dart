import 'package:flutter/material.dart';
import 'package:testapp/controllers/ApiController.dart';
import 'package:testapp/screens/ResultSummaryScreen.dart';

class AddressSearchScreen extends StatefulWidget {
  @override
  _AddressSearchScreenState createState() => _AddressSearchScreenState();
}

class _AddressSearchScreenState extends State<AddressSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  ApiController _apiController = ApiController();
  List<dynamic> _addressList = [];
  String _selectedAddress = '';
  String _selectedDong = '';
  String _selectedFloor = '';
  String _selectedHo = '';
  Map<String, dynamic> _selectedAddressData = {};
  List<String> _dongList = [];
  List<String> _floorList = [];
  List<String> _hoList = [];
  bool _isAddressSelected = false;

  void _onSearch() async {
    final addresses = await _apiController.fetchDataFromApi(_searchController.text);
    setState(() {
      _addressList = addresses;
    });
  }

  void _fetchDetailAddress(Map<String, dynamic> addressData) async {
    Map<String, dynamic> detailData = await _apiController.fetchDetailAddress(
      addressData['admCd'],
      addressData['rnMgtSn'],
      addressData['udrtYn'],
      'dong',
      '',
      addressData['buldMnnm'],
      addressData['buldSlno'],
    );
    setState(() {
      _selectedAddressData = addressData;
      _selectedAddress = addressData['roadAddr'];
      _dongList = detailData.keys.toList();
      _selectedDong = _dongList.isNotEmpty ? _dongList.first : '';
      _floorList = [];
      _selectedFloor = '';
      _hoList = [];
      _selectedHo = '';
      _addressList = [];
      _isAddressSelected = true;
    });
  }

  void _fetchFloors(String dong) async {
    Map<String, dynamic> detailData = await _apiController.fetchDetailAddress(
      _selectedAddressData['admCd'],
      _selectedAddressData['rnMgtSn'],
      _selectedAddressData['udrtYn'],
      'floor',
      dong,
      _selectedAddressData['buldMnnm'],
      _selectedAddressData['buldSlno'],
    );
    setState(() {
      _selectedDong = dong;
      _floorList = detailData[dong]?.keys.toList() ?? [];
      _selectedFloor = _floorList.isNotEmpty ? _floorList.first : '';
      _hoList = [];
      _selectedHo = '';
    });
  }

  void _fetchHos(String floor) async {
    Map<String, dynamic> detailData = await _apiController.fetchDetailAddress(
      _selectedAddressData['admCd'],
      _selectedAddressData['rnMgtSn'],
      _selectedAddressData['udrtYn'],
      'ho',
      _selectedDong,
      _selectedAddressData['buldMnnm'],
      _selectedAddressData['buldSlno'],
    );
    setState(() {
      _selectedFloor = floor;
      _hoList = detailData[_selectedDong]?[floor] ?? [];
      _selectedHo = _hoList.isNotEmpty ? _hoList.first : '';
    });
  }

  void _resetAddress() {
    setState(() {
      _selectedAddress = '';
      _selectedDong = '';
      _selectedFloor = '';
      _selectedHo = '';
      _selectedAddressData = {};
      _dongList = [];
      _floorList = [];
      _hoList = [];
      _isAddressSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('집의 위치를 알려주세요'),
      ),
      body: Column(
        children: [
          if (!_isAddressSelected)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: '주소 검색',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: _onSearch,
                  ),
                ],
              ),
            ),
          if (!_isAddressSelected)
            Expanded(
              child: ListView.builder(
                itemCount: _addressList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_addressList[index]['roadAddr']),
                    onTap: () => _fetchDetailAddress(_addressList[index]),
                  );
                },
              ),
            ),
          if (_isAddressSelected)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('선택한 주소: $_selectedAddress'),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _resetAddress,
                    child: Text('주소 다시 검색'),
                  ),
                ],
              ),
            ),
          if (_isAddressSelected)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<String>(
                      value: _selectedDong,
                      items: _dongList.map((dong) {
                        return DropdownMenuItem(
                          value: dong,
                          child: Text(dong),
                        );
                      }).toList(),
                      onChanged: (value) => _fetchFloors(value!),
                      decoration: InputDecoration(
                        labelText: '동 선택',
                      ),
                    ),
                    SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _selectedFloor,
                      items: _floorList.map((floor) {
                        return DropdownMenuItem(
                          value: floor,
                          child: Text(floor),
                        );
                      }).toList(),
                      onChanged: (value) => _fetchHos(value!),
                      decoration: InputDecoration(
                        labelText: '층 선택',
                      ),
                    ),
                    SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _selectedHo,
                      items: _hoList.map((ho) {
                        return DropdownMenuItem(
                          value: ho,
                          child: Text(ho),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedHo = value!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: '호 선택',
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _selectedDong.isNotEmpty &&
                              _selectedFloor.isNotEmpty &&
                              _selectedHo.isNotEmpty
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResultSummaryScreen(
                                    selectedAddress: _selectedAddress,
                                    selectedDong: _selectedDong,
                                    selectedFloor: _selectedFloor,
                                    selectedHo: _selectedHo,
                                  ),
                                ),
                              );
                            }
                          : null,
                      child: Text('결과 페이지로 이동'),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}