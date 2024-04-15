import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/ApiController.dart';
import 'package:testapp/screens/ResultSummaryScreen.dart';

class AddressSearchScreen extends GetView<ApiController> {
  AddressSearchScreen({super.key});

  final TextEditingController _searchController = TextEditingController();
  final RxString _selectedAddress = ''.obs;
  final RxString _selectedDong = ''.obs;
  final RxString _selectedFloor = ''.obs;
  final RxString _selectedHo = ''.obs;
  final Rx<Map<String, dynamic>> _selectedAddressData =
      Rx<Map<String, dynamic>>({});
  final RxBool _isAddressSelected = false.obs;

  @override
  Widget build(BuildContext context) {
    Get.put(ApiController()); // ApiController 등록

    return Scaffold(
      appBar: AppBar(
        title: const Text('집의 위치를 알려주세요'),
        backgroundColor: Colors.white,
      ),
      body: Obx(
        () => AbsorbPointer(
          absorbing: controller.isLoading.value,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (!_isAddressSelected.value)
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
                          onPressed: () {
                            controller.fetchDataFromApi(_searchController.text);
                          },
                        ),
                      ],
                    ),
                  ),
                if (!_isAddressSelected.value)
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.addressList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title:
                              Text(controller.addressList[index]['roadAddr']),
                          onTap: () {
                            _selectedAddressData.value =
                                controller.addressList[index];
                            _selectedAddress.value =
                                controller.addressList[index]['roadAddr'];
                            _isAddressSelected.value = true;
                            controller.fetchDetailAddress(
                              controller.addressList[index]['admCd'],
                              controller.addressList[index]['rnMgtSn'],
                              controller.addressList[index]['udrtYn'],
                              controller.addressList[index]['searchType'],
                              controller.addressList[index]['dongNm'],
                              controller.addressList[index]['buldMnnm'],
                              controller.addressList[index]['buldSlno'],
                            );
                          },
                        );
                      },
                    ),
                  ),
                if (_isAddressSelected.value)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          _selectedAddress.value,
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () {
                            _isAddressSelected.value = false;
                            _selectedAddress.value = '';
                            _selectedDong.value = '';
                            _selectedFloor.value = '';
                            _selectedHo.value = '';
                            _selectedAddressData.value = {};
                            controller.dongList.clear(); // 동 리스트 초기화

                          },
                          icon: const Icon(Icons.edit),
                        )
                      ],
                    ),
                  ),
                if (_isAddressSelected.value)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if(controller.dongList.length > 1)
                          DropdownButtonFormField<String>(
                            value: _selectedDong.value.isNotEmpty
                                ? _selectedDong.value
                                : null,
                            items: controller.dongList.map((dong) {
                              return DropdownMenuItem(
                                value: dong,
                                child: Text(dong),
                              );
                            }).toList(),
                            onChanged: (value) {
                              _selectedDong.value = value!;
                              _selectedFloor.value = '';
                              _selectedHo.value = '';
                              controller.fetchDetailAddress(
                                _selectedAddressData.value['admCd'],
                                _selectedAddressData.value['rnMgtSn'],
                                _selectedAddressData.value['udrtYn'],
                                'floorho',
                                value,
                                _selectedAddressData.value['buldMnnm'],
                                _selectedAddressData.value['buldSlno'],
                              );
                            },
                            decoration: const InputDecoration(
                              labelText: '동',
                            ),
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            value: _selectedFloor.value.isNotEmpty
                                ? _selectedFloor.value
                                : null,
                            items: controller
                                .detailData.value[_selectedDong.value]?.keys
                                .map((floor) {
                              return DropdownMenuItem(
                                value: floor,
                                child: Text(floor),
                              );
                            }).toList(),
                            onChanged: (value) {
                              _selectedFloor.value = value!;
                              _selectedHo.value = controller.detailData
                                  .value[_selectedDong.value]![value]!.first;
                            },
                            decoration: const InputDecoration(
                              labelText: '층',
                            ),
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            value: _selectedHo.value.isNotEmpty
                                ? _selectedHo.value
                                : null,
                            items: controller
                                .detailData
                                .value[_selectedDong.value]
                                    ?[_selectedFloor.value]
                                ?.map((ho) {
                              return DropdownMenuItem(
                                value: ho,
                                child: Text(ho),
                              );
                            }).toList(),
                            onChanged: (value) {
                              _selectedHo.value = value!;
                            },
                            decoration: const InputDecoration(
                              labelText: '호',
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _selectedAddress.value.isNotEmpty &&
                                    _selectedFloor.value.isNotEmpty &&
                                    _selectedHo.value.isNotEmpty
                                ? () {
                                    Get.to(
                                      () => ResultSummaryScreen(
                                        selectedAddress: _selectedAddress.value,
                                        selectedDong: _selectedDong.value,
                                        selectedFloor: _selectedFloor.value,
                                        selectedHo: _selectedHo.value,
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
        ),
      ),
    );
  }
}
