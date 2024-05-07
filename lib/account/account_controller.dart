import 'package:get/get.dart';
import 'package:testapp/models/account.dart';
import 'package:testapp/services/storage_service.dart';

class AccountController extends GetxController {
  final _storageService = Get.find<StorageService>();

  // Getter
  Account? get account => _storageService.getAccount();

  // Getter for each column
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
    if (account != null) {
      _updateAccount(account!.copyWith(id: value));
    }
  }

  set provider(String value) {
    if (account != null) {
      _updateAccount(account!.copyWith(provider: value));
    }
  }

  set providerUserId(String value) {
    if (account != null) {
      _updateAccount(account!.copyWith(providerUserId: value));
    }
  }

  set nickname(String value) {
    if (account != null) {
      _updateAccount(account!.copyWith(nickname: value));
    }
  }

  set role(String value) {
    if (account != null) {
      _updateAccount(account!.copyWith(role: value));
    }
  }

  set licenseId(String value) {
    if (account != null) {
      _updateAccount(account!.copyWith(licenseId: value));
    }
  }

  set profileImageId(String value) {
    if (account != null) {
      _updateAccount(account!.copyWith(profileImageId: value));
    }
  }

  set premiumDate(String value) {
    if (account != null) {
      _updateAccount(account!.copyWith(premiumDate: value));
    }
  }

  set phone(String value) {
    if (account != null) {
      _updateAccount(account!.copyWith(phone: value));
    }
  }

  // Update account in storage
  void _updateAccount(Account updatedAccount) {
    _storageService.setAccount(updatedAccount);
    update();
  }
}