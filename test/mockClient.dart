import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:testapp/controllers/zip_find_controller.dart';

class MockHttpClient extends Mock implements http.Client {
  @override
  Future<http.Response> get(Uri uri, {Map<String, String>? headers}) async {
    final uriString = uri.toString();
    if (uriString == 'http://localhost/search?buildingType=someType') {
      return http.Response(jsonEncode([
        {'id': 1, 'name': 'Building A'},
        {'id': 2, 'name': 'Building B'},
      ]), 200);
    } else if (uriString == 'http://localhost/search?buildingType=errorType') {
      return http.Response('Failed to load data', 404);
    } else {
      return http.Response('Unexpected URI: $uriString', 400);
    }
  }
}

void main() {
  late ZipFindController controller;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    Get.put(mockHttpClient);
    controller = ZipFindController();
  });

  tearDown(() {
    Get.reset();
  });

  test('should handle error when fetching data', () async {
    controller.additionalArgument = 'errorType';
    when(mockHttpClient.get(Uri.parse('http://localhost/search?buildingType=errorType'), headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Failed to load data', 404));

    await controller.fetchData();

    expect(controller.isLoading.value, false);
    expect(controller.error.value, 'Error fetching data: Exception: Failed to load data: 404');
    expect(controller.jsonData.isEmpty, true);
  });

  test('should throw exception for unexpected URI', () async {
    controller.additionalArgument = 'unexpectedType';
    when(mockHttpClient.get(Uri.parse('http://localhost/search?buildingType=unexpectedType'), headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Unexpected URI: http://localhost/search?buildingType=unexpectedType', 400));

    await expectLater(() => controller.fetchData(), throwsA(isA<Exception>()));
  });
}