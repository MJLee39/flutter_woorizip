import 'package:get/get.dart';
import 'package:testapp/models/account.dart';
import 'package:testapp/services/storage_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:testapp/utils/api_config.dart';

class AccountController extends GetxController {
  static AccountController get to => Get.find<AccountController>();
  final _storageService = Get.find<StorageService>();

  // Account 정보 업데이트를 위한 API 엔드포인트 URL
  final String _apiUrl = '${ApiConfig.apiAccountUpdateUrl}/${Get.find<StorageService>().getAccount()?.id ?? ''}';

  // Getter
  Account? get account => _storageService.getAccount();
  String get id => account?.id ?? '';
  String get provider => account?.provider ?? '';
  String get providerUserId => account?.providerUserId ?? '';
  String get nickname => account?.nickname ?? '';
  String get role => account?.role ?? '';
  String get licenseId => account?.licenseId ?? '';
  String get profileImageId => account?.profileImageId ?? '';
  String get premiumDate => account?.premiumDate ?? '';
  String get phone => account?.phone ?? '';

  // Setter for each column
  set id(String value) {
    _updateAccount(account!.copyWith(id: value));
  }

  set provider(String value) {
    _updateAccount(account!.copyWith(provider: value));
  }

  set providerUserId(String value) {
    _updateAccount(account!.copyWith(providerUserId: value));
  }

  set nickname(String value) {
    _updateAccount(account!.copyWith(nickname: value));
  }

  set role(String value) {
    _updateAccount(account!.copyWith(role: value));
  }

  set licenseId(String value) {
    _updateAccount(account!.copyWith(licenseId: value));
  }

  set profileImageId(String value) {
    _updateAccount(account!.copyWith(profileImageId: value));
  }

  set premiumDate(String value) {
    _updateAccount(account!.copyWith(premiumDate: value));
  }

  set phone(String value) {
    _updateAccount(account!.copyWith(phone: value));
  }

  // Update account on server and local storage
  Future<void> _updateAccount(Account updatedAccount) async {
    try {
      // 서버에 업데이트
      final serverResponse = await http.put(
        Uri.parse(_apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'Account': updatedAccount.toJson(),
        }),
      );

      if (serverResponse.statusCode == 200) {
        // 서버 업데이트 성공 시, 로컬 스토리지도 업데이트
        _storageService.setAccount(updatedAccount);
        update();
      } else {
        // 서버 업데이트 실패 처리
        print('Failed to update account on server: ${serverResponse.statusCode}\n${serverResponse.body}');
      }
    } catch (e) {
      print('Error updating account on server: $e');
    }
  }
}