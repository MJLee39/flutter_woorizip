import 'package:get/get.dart';
import 'package:testapp/chat/chat.dart';
import 'package:testapp/chat/chatroom_list.dart';
import 'package:testapp/controllers/chat_controller.dart';
import 'package:testapp/map/screens/map_screen.dart';
import 'package:testapp/middleware/auth_guard.dart';
import 'package:testapp/screens/admin_screen.dart';
import 'package:testapp/screens/condition/condition_read_all_screen.dart';
import 'package:testapp/screens/condition/condition_read_by_where_screen.dart';
import 'package:testapp/screens/condition/condition_update_screen.dart';
import 'package:testapp/screens/seemore/myinfo_screen.dart';
import 'package:testapp/screens/zip_registration/address_search_1_screen.dart';
import 'package:testapp/screens/home_screen.dart';
import 'package:testapp/screens/login_screen.dart';
import 'package:testapp/screens/zip_registration/result_summary_2_screen.dart';
import 'package:testapp/screens/condition/condition_read_one_screen.dart';
import 'package:testapp/screens/seemore/see_more_screen.dart';
import 'package:testapp/screens/condition/set_hashtag_screen.dart';
import 'package:testapp/screens/condition/set_details_screen.dart';
import 'package:testapp/screens/condition/set_move_in_date_screen.dart';
import 'package:testapp/screens/zip_find_screen.dart';
import 'package:testapp/screens/zip_list_agent_screen.dart';
import 'package:testapp/screens/zip_registration/rental_info_4_screen.dart';
import 'package:testapp/screens/zip_registration/zip_detail_registration_5_screen.dart';
import 'package:testapp/screens/zip_registration/zip_detail_registration_next_6_screen.dart';
import 'package:testapp/screens/zip_registration/zip_hashtag_7_screen.dart';
import 'package:testapp/screens/zip_registration/zip_detail_registration_5_5_screen.dart';
import 'package:testapp/screens/zip_update/update_zip_address_result_screen.dart';
import 'package:testapp/screens/zip_update/update_zip_picture_screen.dart';

import '../screens/zip_update/update_zip_address_screen.dart';

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
      middlewares: [],
    ),
    _getPageWithMiddleware(
      name: '/result',
      page: () => const ResultSummaryScreen(),
      middlewares: [],
    ),
    _getPageWithMiddleware(
      name: '/chatRoomList',
      page: () => ChatRoomListScreen(
        accountId: 'qassadsadsa',
      ),
      middlewares: [],
    ),
    _getPageWithMiddleware(
      name: '/chat/:chatRoomId',
      page: () {
        final ChatController _chatController = ChatController();
        final chatRoomId = Get.parameters['chatRoomId'];
        final accountId = Get.arguments['accountId'];
        var otherNickname;
        _chatController.getNicknameBy(accountId).then((value) => otherNickname = value);
        return Chat(chatRoomId: chatRoomId ?? "", accountId: accountId ?? "", myNickname: "허위 매물 사기꾼", otherNickname: otherNickname,);
      },
      middlewares: [],
    ),
    _getPageWithMiddleware(
      name: '/seeMore',
      page: () => SeeMoreScreen(),
      middlewares: [],
    ),
    //중개사의 내 매물 리스트 보기
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

    /*
    client set location, building, fee
     */
    _getPageWithMiddleware(
      name: '/setdetails',
      page: () => const SetDetailsScreen(),
      middlewares: [],
    ),

    _getPageWithMiddleware(
      name: '/myinfo',
      page: () => const MyinfoScreen(),
      middlewares: [],
    ),
    /*
    client set Move In Data
     */
    _getPageWithMiddleware(
      name: '/setmoveindate',
      page: () => const SetMoveInDateScreen(),
      middlewares: [],
    ),

    /*
    client set Hashtag
     */
    _getPageWithMiddleware(
      name: '/sethashtag',
      page: () => SetHashtagScreen(),
      middlewares: [],
    ),

    /*
    client condition read one
     */
    _getPageWithMiddleware(
      name: '/conditionreadone',
      page: () => const ConditionReadOneScreen(),
      middlewares: [],
    ),

    /*
    client condition read all
     */
    _getPageWithMiddleware(
      name: '/conditionreadall',
      page: () => ConditionReadAllScreen(),
      middlewares: [],
    ),

    /*
    client readByWhere
     */
    _getPageWithMiddleware(
      name: '/conditionreadbywhere',
      page: () => ConditionReadByWhereScreen(),
      middlewares: [],
    ),

    /*
    client update
     */
    _getPageWithMiddleware(
      name: '/conditionupdate',
      page: () => ConditionUpdateScreen(),
      middlewares: [],
    ),

    //매물 등록에서 보증금 입력 페이지로 이동
    _getPageWithMiddleware(
      name: '/depositAndFee',
      page: () => RentalInfoScreen(),
      middlewares: [],
    ),

    //매물 등록에서 상세 정보 입력 페이지로 이동
    /*
    client condition update
     */
    _getPageWithMiddleware(
      name: '/detail_registration',
      page: () => ZipDetailRegistrationScreen(),
      middlewares: [],
    ),

    //매물 등록에서 상세 정보 입력 다음 페이지로 이동
    _getPageWithMiddleware(
      name: '/detail_registration2',
      page: () => ZipDetailRegistrationNextScreen(),
      middlewares: [],
    ),

    //매물 등록에서 옵션 입력
    _getPageWithMiddleware(
      name: '/zip_hashtag',
      page: () => ZipHashtagScreen(),
      middlewares: [],
    ),

    //매물 등록에서 상세 입력 2
    _getPageWithMiddleware(
      name: '/detail_registration5_5',
      page: () => ZipDetailRegistration55Screen(),
      middlewares: [],
    ),

    //매물 수정에서 주소 검색
    _getPageWithMiddleware(
      name: '/update_zip_address',
      page: () => UpdateZipAddressScreen(),
      middlewares: [],
    ),

    //매물 수정에서 주소 결과
    _getPageWithMiddleware(
      name: '/update_zip_address_result',
      page: () => UpdateZipAddressResultScreen(),
      middlewares: [],
    ),

    //매물 수정에서 사진 변경
    _getPageWithMiddleware(
      name: '/update_zip_picture_screen',
      page: () => UpdateZipPictureScreen(),
      middlewares: [],
    ),

    _getPageWithMiddleware(
        name: '/admin', page: () => AdminScreen(), middlewares: [])
  ];
}
