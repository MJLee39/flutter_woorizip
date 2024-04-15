import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<dynamic> addressList = <dynamic>[].obs;
  Rx<Map<String, Map<String, List<String>>>> detailData =
      Rx<Map<String, Map<String, List<String>>>>({});
    RxList<String> dongList = <String>[].obs;

  Future<void> fetchDataFromApi(String keyword) async {
    isLoading.value = true;
    String apiUrl =
        'https://www.juso.go.kr/addrlink/addrLinkApi.do?confmKey=devU01TX0FVVEgyMDI0MDQwNTE1MzkxMDExNDY2Njg=&keyword=$keyword&resultType=json';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      final jsonData = json.decode(response.body);
      List<dynamic> fetchedAddressList = jsonData['results']['juso'];
      addressList.assignAll(await _processAddressList(fetchedAddressList));
    } catch (error) {
      print('Error while fetching data: $error');
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<dynamic>> _processAddressList(List<dynamic> addressList) async {
    List<dynamic> processedList = [];
    for (var address in addressList) {
      Map<String, dynamic> processedAddress = {};
      processedAddress['roadAddr'] = address['roadAddr'];
      processedAddress['admCd'] = address['admCd'];
      processedAddress['rnMgtSn'] = address['rnMgtSn'];
      processedAddress['udrtYn'] = address['udrtYn'];
      processedAddress['buldMnnm'] = address['buldMnnm'];
      processedAddress['buldSlno'] = address['buldSlno'];
      String detBdNmListString = address['detBdNmList']
          .toString()
          .trim()
          .replaceAll('[', '')
          .replaceAll(']', '');
      if (detBdNmListString.isNotEmpty) {
        List<String> detBdNmList = detBdNmListString.split(',');
        processedAddress['searchType'] = 'dong';
        processedAddress['dongNm'] = detBdNmList[0];
      } else {
        processedAddress['searchType'] = 'floorho';
        processedAddress['dongNm'] = '';
      }
      processedList.add(processedAddress);
    }
    return processedList;
  }

  Future<void> fetchDetailAddress(
      String admCd,
      String rnMgtSn,
      String udrtYn,
      String searchType,
      String dongNm,
      String buldMnnm,
      String buldSlno) async {
    isLoading.value = true;
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
      if (dongList.isEmpty) {
        dongList.assignAll(groupedData.keys.toList());
      }
      detailData.value = groupedData;
      print(detailData);
    } catch (error) {
      print('Error while fetching detail data: $error');
    } finally {
      isLoading.value = false;
    }
  }
}