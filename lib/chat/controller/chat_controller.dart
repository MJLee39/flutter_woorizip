import 'dart:convert';
import 'package:eventflux/eventflux.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ChatController extends GetxController {
  late final String? accountId; // accountId를 선택적 매개변수로 변경
  final chatRooms = <Map<String, dynamic>>[].obs;
  String uriPrefix = 'http://localhost:4888/chat/';

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    print(arguments);
    if (arguments != null) {
      accountId = arguments['accountId'];
      if (accountId != null) {
        fetchChatRooms(); // accountId가 제공되었을 때만 fetchChatRooms 호출
      }
    }
  }

  Future<void> fetchChatRooms() async {
    final url = Uri.parse("$uriPrefix$accountId/room");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(utf8.decode(response.bodyBytes));
      final chatRoomList = jsonList.cast<Map<String, dynamic>>();
      chatRooms.assignAll(chatRoomList);

      for (final chatRoom in chatRooms) {
        subscribeToChatRoom(chatRoom['id']);
      }
    } else {
      throw Exception("Failed to fetch chat rooms");
    }
  }

  void subscribeToChatRoom(String chatRoomId) {
    EventFlux.instance.connect(
      EventFluxConnectionType.get,
      '${uriPrefix}connect/$chatRoomId',
      onSuccessCallback: (EventFluxResponse? response) {
        response?.stream?.listen((data) {
          if (data.event == 'connect') {
            print(data.event);
          } else if (data.event == 'chat') {
            var eventData = jsonDecode(data.data);
            var updatedChatRoomId = eventData['chatRoomId'];
            var message = eventData['message'];

            final index = chatRooms.indexWhere((room) => room['id'] == updatedChatRoomId);
            if (index != -1) {
              final updatedRoom = {...chatRooms[index], 'recentMessage': message};
              chatRooms.removeAt(index);
              chatRooms.insert(0, updatedRoom);
            }
          }
        });
      },
      onError: (error) {
        print('Error subscribing to chat room $chatRoomId: $error');
      },
      autoReconnect: true,
    );
  }
}