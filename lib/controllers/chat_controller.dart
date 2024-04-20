import 'dart:convert';

import 'package:http/http.dart' as http;

class ChatController {

  Future<List<ChatRoomResponseDTO>> fetchChatRooms(String accountId) async {
    final url = Uri.parse("https://chat.teamwaf.app/chat/$accountId/room");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(utf8.decode(response.bodyBytes));
      return jsonList.map((json) => ChatRoomResponseDTO.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch chat rooms");
    }
  }

  Future<Map<String, dynamic>> createChatRoom(String clientId, String agentId) async {
    final response = await http.post(
        Uri.parse('https://chat.teamwaf.app/chat/create'),
        body: {
          'clientId': clientId,
          'agentId': agentId
        }
    );

    if (response.statusCode == 200) {
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to load zip data');
    }
  }
}

class ChatRoomResponseDTO {
  final String id;
  final List<String> participantIds;
  final String nickname;
  final String clientId;
  final String brokerId;
  String recentMessage;

  ChatRoomResponseDTO({
    required this.id,
    required this.participantIds,
    required this.nickname,
    required this.clientId,
    required this.brokerId,
    required this.recentMessage,
  });

  factory ChatRoomResponseDTO.fromJson(Map<String, dynamic> json) {
    return ChatRoomResponseDTO(
      id: json['id'],
      participantIds: List<String>.from(json['participantIds']),
      nickname: json['nickname'],
      clientId: json['clientId'],
      brokerId: json['brokerId'],
      recentMessage: json['recentMessage'] ?? "",
    );
  }
}