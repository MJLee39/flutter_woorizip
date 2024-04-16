import 'package:get/get.dart';
import 'package:testapp/services/auth_service.dart';

class AuthGuard extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    AuthService.to.checkLoginStatus();

    if (!AuthService.to.isLoggedInValue) {
      Get.offAllNamed('/login');
      return null; 
      // Unexpected null value. 어쩔수 없음
    }

    return super.onPageCalled(page);
  }
}