import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/ApiController.dart';
import 'package:testapp/screens/ResultSummaryScreen.dart';

class AddressSearchScreen extends StatefulWidget {
  const AddressSearchScreen({super.key});

  @override
  State<AddressSearchScreen> createState() => _AddressSearchScreenState();
}

class _AddressSearchScreenState extends State<AddressSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ApiController _apiController = ApiController();

  List<dynamic> _addressList = [];
  String _selectedAddress = '';
  String _selectedDong = '';
  String _selectedFloor = '';
  String _selectedHo = '';
  Map<String, dynamic> _selectedAddressData = {};
  Map<String, dynamic> _detailData = {};

  List<String> _dongList = [];
  List<String> _floorList = [];
  List<String> _hoList = [];
  bool _isAddressSelected = false;

  void _onSearch() async {
    final addresses =
        await _apiController.fetchDataFromApi(_searchController.text);
    setState(() {
      _addressList = addresses;
    });
  }

  void _fetchDetailAddress(Map<String, dynamic> addressData) async {
    _detailData = await _apiController.fetchDetailAddress(
      addressData['admCd'],
      addressData['rnMgtSn'],
      addressData['udrtYn'],
      addressData['searchType'],
      addressData['dongNm'],
      addressData['buldMnnm'],
      addressData['buldSlno'],
    );
    setState(() {
      _selectedAddressData = addressData;
      _selectedAddress = addressData['roadAddr'];
      _dongList = _detailData.keys.toList();
      _selectedDong = _dongList.isNotEmpty ? _dongList.first : '';
      _floorList = [];
      _selectedFloor = '';
      _hoList = [];
      _selectedHo = '';
      _addressList = [];
      _isAddressSelected = true;
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
        title: const Text('집의 위치를 알려주세요'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (!_isAddressSelected)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          labelText: '주소 검색',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.search),
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
                    Text(
                      _selectedAddress,
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: _resetAddress,
                      icon: const Icon(Icons.edit),
                    )
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
                        onChanged: (value) {
                          setState(() {
                            _selectedDong = value!;
                            _floorList = _detailData[value]?.keys.toList() ?? [];
                            _selectedFloor =
                                _floorList.isNotEmpty ? _floorList.first : '';
                            _hoList = [];
                            _selectedHo = '';
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: '동',
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: _selectedFloor,
                        items: _floorList.map((floor) {
                          return DropdownMenuItem(
                            value: floor,
                            child: Text(floor),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedFloor = value!;
                            _hoList = _detailData[_selectedDong]?[value] ?? [];
                            _selectedHo = _hoList.isNotEmpty ? _hoList.first : '';
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: '층',
                        ),
                      ),
                      const SizedBox(height: 8),
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
                        decoration: const InputDecoration(
                          labelText: '호',
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _selectedAddress.isNotEmpty &&
                                _selectedFloor.isNotEmpty &&
                                _selectedHo.isNotEmpty
                            ? () {
                                Get.to(
                                  () => ResultSummaryScreen(
                                    selectedAddress: _selectedAddress,
                                    selectedDong: _selectedDong,
                                    selectedFloor: _selectedFloor,
                                    selectedHo: _selectedHo,
                                  ),
                                  transition: Transition.noTransition,
                                );
                              }
                            : null,
                        child: const Text('결과 페이지로 이동'),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}