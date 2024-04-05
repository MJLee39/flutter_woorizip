import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiController {
  Future<List<dynamic>> fetchDataFromApi(String keyword) async {
    String apiUrl =
        'https://www.juso.go.kr/addrlink/addrLinkApi.do?confmKey=devU01TX0FVVEgyMDI0MDQwNTE1MzkxMDExNDY2Njg=&keyword=$keyword&resultType=json';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      final jsonData = json.decode(response.body);
      List<dynamic> addressList = jsonData['results']['juso'];
      return _processAddressList(addressList);
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
      String detBdNmListString = address['detBdNmList'].toString().trim().replaceAll('[', '').replaceAll(']', '');
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

Future<Map<String, dynamic>> fetchDetailAddress(String admCd, String rnMgtSn, String udrtYn, String searchType, String dongNm, String buldMnnm, String buldSlno) async {
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
        print("  $floor: ${hos.join(', ')}");
      });
    });

    return groupedData;
  } catch (error) {
    print('Error while fetching detail data: $error');
    return {};
  }
}



}