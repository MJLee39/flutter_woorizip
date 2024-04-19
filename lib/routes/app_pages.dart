import 'package:get/get.dart';
import 'package:testapp/chat/chat.dart';
import 'package:testapp/chat/chatroom_list.dart';
import 'package:testapp/map/screens/map_screen.dart';
import 'package:testapp/middleware/auth_guard.dart';
import 'package:testapp/screens/address_search_screen.dart';
import 'package:testapp/screens/home_screen.dart';
import 'package:testapp/screens/login_screen.dart';
import 'package:testapp/screens/see_more_screen.dart';
import 'package:testapp/screens/zip_find_screen.dart';
import 'package:testapp/screens/zip_list_agent_screen.dart';
import 'package:testapp/screens/zip_list_agent_private_screen.dart';
import 'package:testapp/screens/zip_detail_screen.dart';

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
      page: () => ZipFindScreen(),
      middlewares: [],
    ),
    _getPageWithMiddleware(
      name: '/addressSearch',
      page: () => AddressSearchScreen(),
    ),
    _getPageWithMiddleware(
      name: '/chatRoomList',
      page: () => ChatRoomList(accountId: 'qassadsadsa',),
      middlewares: [],
    ),

    _getPageWithMiddleware(
      name: '/chat/:chatRoomId',
      page: () {
        final chatRoomId = Get.parameters['chatRoomId'];
        final accountId = Get.arguments['accountId'];
        return Chat(
            chatRoomId: chatRoomId ?? "", accountId: accountId ?? "");
      },
      middlewares: [],
    ),
    _getPageWithMiddleware(
      name: '/seeMore',
      page: () => SeeMoreScreen(),
      middlewares: [],
    ),
    _getPageWithMiddleware(
      name: '/my_listings',
      page: () => const ZipListAgentScreen(),
      middlewares: [],
    ),
    _getPageWithMiddleware(
      name: '/map/:buildingType',
      page: () {
        final buildingType = Get.parameters['buildingType'];
        return MapScreen(buildingType: buildingType ?? "");
      },
      middlewares: [],
    ),
    _getPageWithMiddleware(
      name: '/my_private',
      page: () => const ZipListAgentPrivateScreen(),
      middlewares: [],
    ),
  ];
}
