import 'package:get/get.dart';
import 'package:testapp/services/auth_service.dart';
import 'package:testapp/services/storage_service.dart';

class AuthGuard extends GetMiddleware {
  final StorageService _storageService = Get.find<StorageService>();

  @override
  GetPage? onPageCalled(GetPage? page) {
    AuthService.to.checkLoginStatus();
      print(_storageService.getAccount().toString());
    if (!AuthService.to.isLoggedInValue) {
      String intendedRoute = page?.name ?? '/';
      _storageService.write('intendedRoute', intendedRoute);
      Get.snackbar(
        '로그인 필요',
        '로그인이 필요한 서비스입니다.\n로그인 후 이용해주세요.',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
      Get.offAllNamed('/login');
      return null;
      // Unexpected null value. 어쩔수 없음
    }


    return super.onPageCalled(page);
  }
}
