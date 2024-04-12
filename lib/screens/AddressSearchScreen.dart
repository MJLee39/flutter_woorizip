// AddressSearchScreen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/ApiController.dart';
import 'package:testapp/screens/ResultSummaryScreen.dart';

class AddressSearchScreen extends StatelessWidget {
  final ApiController _apiController = Get.put(ApiController());
  final TextEditingController _searchController = TextEditingController();

  AddressSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('집의 위치를 알려주세요'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
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
            Obx(
              () {
                final addressList = _apiController.addressList;
                final isAddressSelected = _apiController.isAddressSelected;
                return Expanded(
                  child: !isAddressSelected
                      ? ListView.builder(
                          itemCount: addressList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(addressList[index]['roadAddr']),
                              onTap: () => _fetchDetailAddress(addressList[index]),
                            );
                          },
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Obx(
                                    () => Text(
                                      _apiController.selectedAddress,
                                      style: const TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  IconButton(
                                    onPressed: _resetAddress,
                                    icon: const Icon(Icons.edit),
                                  )
                                ],
                              ),
                              const SizedBox(height: 8),
                              Obx(
                                () => DropdownButtonFormField<String>(
                                  value: _apiController.selectedDong,
                                  items: _apiController.dongList.map((dong) {
                                    return DropdownMenuItem(
                                      value: dong,
                                      child: Text(dong),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    _apiController.selectDong(value!);
                                  },
                                  decoration: const InputDecoration(
                                    labelText: '동',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Obx(
                                () => DropdownButtonFormField<String>(
                                  value: _apiController.selectedFloor,
                                  items: _apiController.floorList.map((floor) {
                                    return DropdownMenuItem(
                                      value: floor,
                                      child: Text(floor),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    _apiController.selectFloor(value!);
                                  },
                                  decoration: const InputDecoration(
                                    labelText: '층',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Obx(
                                () => DropdownButtonFormField<String>(
                                  value: _apiController.selectedHo,
                                  items: _apiController.hoList.map((ho) {
                                    return DropdownMenuItem(
                                      value: ho,
                                      child: Text(ho),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    _apiController.selectHo(value!);
                                  },
                                  decoration: const InputDecoration(
                                    labelText: '호',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: _apiController.canNavigateToResultScreen
                                    ? () {
                                        Get.to(
                                          () => ResultSummaryScreen(
                                            selectedAddress: _apiController.selectedAddress,
                                            selectedDong: _apiController.selectedDong,
                                            selectedFloor: _apiController.selectedFloor,
                                            selectedHo: _apiController.selectedHo,
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onSearch() async {
    final addresses = await _apiController.fetchDataFromApi(_searchController.text);
    _apiController.updateAddressList(addresses);
  }

  void _fetchDetailAddress(Map<String, dynamic> addressData) async {
    final detailData = await _apiController.fetchDetailAddress(
      addressData['admCd'],
      addressData['rnMgtSn'],
      addressData['udrtYn'],
      addressData['searchType'],
      addressData['dongNm'],
      addressData['buldMnnm'],
      addressData['buldSlno'],
    );
    _apiController.updateSelectedAddress(addressData);
    _apiController.updateDetailData(detailData);
    _apiController.selectDong(_apiController.dongList.first);
  }

  void _resetAddress() {
    _apiController.resetAddress();
  }
}