import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/account/account_controller.dart';
import 'package:testapp/controllers/api_controller.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/bottom_expend_button_widget.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/widgets/text_header_widget.dart';

class AddressSearchScreen extends GetView<ApiController> {
  AddressSearchScreen({super.key});

  final Rx<TextEditingController> _searchController =
      TextEditingController().obs;

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
    final accountController = Get.put(AccountController());



    ever(_searchController, (_) {
      String searchText = _searchController.value.text;
      if (_isCompleteKorean(searchText)) {
        controller.fetchDataFromApi(searchText);
      }
    });

    return Scaffold(
      appBar: const AppBarWidget(),
      body: Stack(
        children: [
          Obx(
            () => AbsorbPointer(
              absorbing: controller.isLoading.value,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  children: [
                    const TextHeaderWidget(text: "집의 위치를 알려주세요"),
                    if (!_isAddressSelected.value)
                      if (!_isAddressSelected.value)
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _searchController.value,
                                onChanged: _onSearchTextChanged,
                                onSubmitted: _onSearchTextChanged,
                                decoration: const InputDecoration(
                                  labelText: '주소 검색',
                                ),
                              ),
                            ),
                          ],
                        ),
                    if (!_isAddressSelected.value)
                      Expanded(
                        child: controller.addressList.isEmpty
                            ? _searchController.value.text.length >= 2
                                ? const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(18),
                                        child: Text(
                                          '검색 결과가 없습니다',
                                          style: TextStyle(
                                            fontSize: 17,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : const SizedBox.shrink()
                            : ListView.builder(
                                itemCount: controller.addressList.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(controller.addressList[index]
                                        ['roadAddr']),
                                    onTap: () {
                                      _selectedAddressData.value =
                                          controller.addressList[index];
                                      _selectedAddress.value = controller
                                          .addressList[index]['roadAddr'];
                                      _isAddressSelected.value = true;
                                      controller.fetchDetailAddress(
                                        controller.addressList[index]['admCd'],
                                        controller.addressList[index]
                                            ['rnMgtSn'],
                                        controller.addressList[index]['udrtYn'],
                                        controller.addressList[index]
                                            ['searchType'],
                                        controller.addressList[index]['dongNm'],
                                        controller.addressList[index]
                                            ['buldMnnm'],
                                        controller.addressList[index]
                                            ['buldSlno'],
                                      );
                                    },
                                  );
                                },
                              ),
                      ),
                    if (_isAddressSelected.value)
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              _selectedAddress.value,
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _searchController.value.clear();
                              controller.addressList.clear(); // 주소 목록 초기화
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
                    if (_isAddressSelected.value)
                      Expanded(
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (!controller.isLoading.value)
                                  if (controller.dongList.length > 1)
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
                                          _selectedAddressData
                                              .value['buldMnnm'],
                                          _selectedAddressData
                                              .value['buldSlno'],
                                        );
                                      },
                                      decoration: const InputDecoration(
                                        labelText: '동',
                                      ),
                                    ),
                                if (!controller.isLoading.value)
                                  const SizedBox(height: 8),
                                if (!controller.isLoading.value)
                                  DropdownButtonFormField<String>(
                                    value: _selectedFloor.value.isNotEmpty
                                        ? _selectedFloor.value
                                        : null,
                                    items: controller.detailData
                                        .value[_selectedDong.value]?.keys
                                        .map((floor) {
                                      return DropdownMenuItem(
                                        value: floor,
                                        child: Text(floor),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      _selectedFloor.value = value!;
                                      _selectedHo.value = controller
                                          .detailData
                                          .value[_selectedDong.value]![value]!
                                          .first;
                                    },
                                    decoration: const InputDecoration(
                                      labelText: '층',
                                    ),
                                  ),
                                if (!controller.isLoading.value)
                                  const SizedBox(height: 8),
                                if (!controller.isLoading.value)
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
                                if (!controller.isLoading.value)
                                  const SizedBox(height: 16),
                              ],
                            ),
                            if (_selectedHo.value.isNotEmpty &&
                                _selectedFloor.value.isNotEmpty)
                              BottomExpendButtonWidget(
                                text: '다음',
                                url: '/result',
                                arguments: {
                                  'selectedAddress': _selectedAddress.value,
                                  'selectedDong': _selectedDong.value,
                                  'selectedFloor': _selectedFloor.value,
                                  'selectedHo': _selectedHo.value,
                                  'totalFloor': controller.detailData.value[_selectedDong.value]?.length ?? 0,
                                },
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Obx(
            () => controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),bottomNavigationBar: const BottomNavigationWidget()
    );

  }

  void _onSearchTextChanged(String text) {
    if (text.isEmpty) {
      controller.addressList.clear();
      return;
    }

    if (_isCompleteKorean(text) && text.length > 1) {
      // 한글이 입력되었고 2글자 이상일 때
      controller.fetchDataFromApi(text);
    }
  }

  bool _isCompleteKorean(String text) {
    return RegExp(r'^[\uAC00-\uD7A3\d-]+( [\uAC00-\uD7A3\d-]+)*$')
        .hasMatch(text); // 한글, 숫자, -만 입력 가능 (공백 포함)
  }
}
