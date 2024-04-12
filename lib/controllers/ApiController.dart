// ApiController.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiController extends GetxController {
  final RxList<dynamic> _addressList = <dynamic>[].obs;
  final RxString _selectedAddress = ''.obs;
  final RxString _selectedDong = ''.obs;
  final RxString _selectedFloor = ''.obs;
  final RxString _selectedHo = ''.obs;
  final RxMap<String, dynamic> _selectedAddressData = <String, dynamic>{}.obs;
  final RxMap<String, dynamic> _detailData = <String, dynamic>{}.obs;
  final RxList<String> _dongList = <String>[].obs;
  final RxList<String> _floorList = <String>[].obs;
  final RxList<String> _hoList = <String>[].obs;
  final RxBool _isAddressSelected = false.obs;

  List<dynamic> get addressList => _addressList.value;
  String get selectedAddress => _selectedAddress.value;
  String get selectedDong => _selectedDong.value;
  String get selectedFloor => _selectedFloor.value;
  String get selectedHo => _selectedHo.value;
  Map<String, dynamic> get selectedAddressData => _selectedAddressData.value;
  Map<String, dynamic> get detailData => _detailData.value;
  List<String> get dongList => _dongList.value;
  List<String> get floorList => _floorList.value;
  List<String> get hoList => _hoList.value;
  bool get isAddressSelected => _isAddressSelected.value;
  bool get canNavigateToResultScreen =>
      selectedAddress.isNotEmpty &&
      selectedFloor.isNotEmpty &&
      selectedHo.isNotEmpty;

  void updateAddressList(List<dynamic> addresses) {
    _addressList.value = _processAddressList(addresses);
  }

  void updateSelectedAddress(Map<String, dynamic> addressData) {
    _selectedAddressData.value = addressData;
    _selectedAddress.value = addressData['roadAddr'];
  }

  void updateDetailData(Map<String, dynamic> detailData) {
    _detailData.value = detailData;
    _dongList.value = detailData.keys.toList();
    _isAddressSelected.value = true;
  }

  void selectDong(String dong) {
    _selectedDong.value = dong;
    _floorList.value = _detailData.value[dong]?.keys.toList() ?? [];
    _selectedFloor.value = _floorList.isNotEmpty ? _floorList.first : '';
    _hoList.value = [];
    _selectedHo.value = '';
  }

  void selectFloor(String floor) {
    _selectedFloor.value = floor;
    _hoList.value = _detailData.value[_selectedDong.value]?[floor] ?? [];
    _selectedHo.value = _hoList.isNotEmpty ? _hoList.first : '';
  }

  void selectHo(String ho) {
    _selectedHo.value = ho;
  }

  void resetAddress() {
    _selectedAddress.value = '';
    _selectedDong.value = '';
    _selectedFloor.value = '';
    _selectedHo.value = '';
    _selectedAddressData.value = {};
    _dongList.value = [];
    _floorList.value = [];
    _hoList.value = [];
    _isAddressSelected.value = false;
  }

  Future<List<dynamic>> fetchDataFromApi(String keyword) async {
    String apiUrl =
        'https://www.juso.go.kr/addrlink/addrLinkApi.do?confmKey=devU01TX0FVVEgyMDI0MDQwNTE1MzkxMDExNDY2Njg=&keyword=$keyword&resultType=json';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      final jsonData = json.decode(response.body);
      List<dynamic> addressList = jsonData['results']['juso'];
      return addressList;
    } catch (error) {
      print('Error while fetching data: $error');
      return [];
    }
  }

  List<dynamic> _processAddressList(List<dynamic> addressList) {
    List<dynamic> processedList = [];
    for (var address in addressList) {
      Map<String, dynamic> processedAddress = {};
      processedAddress['roadAddr'] = address['roadAddr'];
      processedAddress['admCd'] = address['admCd'];
      processedAddress['rnMgtSn'] = address['rnMgtSn'];
      processedAddress['udrtYn'] = address['udrtYn'];
      processedAddress['buldMnnm'] = address['buldMnnm'];
      processedAddress['buldSlno'] = address['buldSlno'];
      // detBdNmList가 있는지 확인
      String detBdNmListString = address['detBdNmList']
          .toString()
          .trim()
          .replaceAll('[', '')
          .replaceAll(']', '');
      if (detBdNmListString.isNotEmpty) {
        List<String> detBdNmList = detBdNmListString.split(',');
        // detBdNmList가 있으면 dong으로 설정하고, dongNm은 detBdNmList의 첫 번째 요소로 설정
        processedAddress['searchType'] = 'dong';
        processedAddress['dongNm'] = detBdNmList[0];
      } else {
        // detBdNmList가 없으면 floorho로 설정하고, dongNm은 빈 문자열로 설정
        processedAddress['searchType'] = 'floorho';
        processedAddress['dongNm'] = '';
      }
      processedList.add(processedAddress);
    }
    return processedList;
  }

  Future<Map<String, dynamic>> fetchDetailAddress(
    String admCd,
    String rnMgtSn,
    String udrtYn,
    String searchType,
    String dongNm,
    String buldMnnm,
    String buldSlno,
  ) async {
    String detailApiUrl =
        'https://business.juso.go.kr/addrlink/addrDetailApi.do?confmKey=devU01TX0FVVEgyMDI0MDQwNTE0NDMxNzExNDY2NjQ=&admCd=$admCd&rnMgtSn=$rnMgtSn&udrtYn=$udrtYn&searchType=$searchType&dongNm=$dongNm&buldMnnm=$buldMnnm&buldSlno=$buldSlno&resultType=json';
    print('detailApiUrl: $detailApiUrl');
    try {
      final response = await http.get(Uri.parse(detailApiUrl));
      final jsonData = json.decode(response.body);
      List<dynamic> jusoList = jsonData['results']['juso'];
      Map<String, Map<String, List<String>>> groupedData = {};
      for (var detail in jusoList) {
        String dong = detail['dongNm'] ?? '';
        String floor = detail['floorNm'] ?? '';
        String ho = detail['hoNm'] ?? '';
        groupedData.putIfAbsent(dong, () => {});
        groupedData[dong]?.putIfAbsent(floor, () => []);
        groupedData[dong]?[floor]!.add(ho);
      }
      // 결과 확인을 위한 출력
      groupedData.forEach((dong, floors) {
        print("$dong: ");
        floors.forEach((floor, hos) {
          print(" $floor: ${hos.join(', ')}");
        });
      });
      return groupedData;
    } catch (error) {
      print('Error while fetching detail data: $error');
      return {};
    }
  }
}