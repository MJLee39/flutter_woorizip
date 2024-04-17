import 'package:get/get.dart';
import 'package:testapp/middleware/auth_guard.dart';
import 'package:testapp/screens/address_search_screen.dart';
import 'package:testapp/screens/home_screen.dart';
import 'package:testapp/screens/login_screen.dart';
import 'package:testapp/screens/zip_find_screen.dart';

class AppPages {
  static const initial = '/';

  static GetPage _getPageWithMiddleware({
    required String name,
    required GetPageBuilder page,
    List<GetMiddleware>? middlewares,
  }) {
    return GetPage(
      name: name,
      page: page,
      transition: Transition.noTransition,
      middlewares: middlewares ?? [AuthGuard()],
    );
  }

  static final routes = [
    _getPageWithMiddleware(
      name: '/',
      page: () => const HomeScreen(),
      middlewares: [], // 미들웨어를 사용하지 않을 때는 빈 리스트를 전달, 로그인이 필요하지 않은 페이지만 빈 리스트 전달하세요
    ),
    _getPageWithMiddleware(
      name: '/login',
      page: () => const LoginScreen(),
      middlewares: [],
    ),
    _getPageWithMiddleware(
      name: '/zipFind',
      page: () => const ZipFindScreen(),
      middlewares: [],
    ),
    _getPageWithMiddleware(
      name: '/addressSearch',
      page: () => AddressSearchScreen(),
    ),
    // _getPageWithMiddleware(
    //   name: '/zipListLocation',
    //   page: () => const ZipListLocationScreen(),
    //   middlewares: [],
    // ),
  ];
}
