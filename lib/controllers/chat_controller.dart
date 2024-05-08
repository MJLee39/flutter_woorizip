import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:testapp/utils/api_config.dart';

class ChatController {

  final String urlPrefix = '${ApiConfig.chatApiEndpointUrl}';

  Future<String> getNicknameBy(String accountId) async {
    final url = Uri.parse("https://api.teamwaf.app/v1/account/$accountId");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final account = AccountResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      return account.nickname;
    } else {
      throw Exception("Failed to fetch chat rooms");
    }
  }

  Future<List<ChatRoomResponseDTO>> fetchChatRooms(String accountId) async {

    final url = Uri.parse("$urlPrefix/chat/find/$accountId/room");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList =
          jsonDecode(utf8.decode(response.bodyBytes));
      return jsonList
          .map((json) => ChatRoomResponseDTO.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to fetch chat rooms");
    }
  }

  Future<Map<String, dynamic>> createChatRoom(
      String clientId, String agentId) async {
    final response = await http.post(
      Uri.parse('$urlPrefix/chat/create'),
      headers: {'content-type': 'application/json'},
      body: jsonEncode({'clientId': clientId, 'brokerId': agentId}),
    );

    if (response.statusCode == 200) {
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to create chatRoom');
    }
  }

  Future<String> exitChatRoom(String chatRoomId) async {
    final url = Uri.parse("$urlPrefix/chat/room/$chatRoomId");
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      return "deleted";
    } else {
      throw Exception('Failed to delete exit chatRoom');
    }
  }

  Future<dynamic> fetchChatRoom(String chatRoomId) async {
    print(chatRoomId);
    final url =
        Uri.parse("$urlPrefix/chat/room?chatRoomId=$chatRoomId");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      final chatMessages = jsonResponse['chatMessagesInRoom'];
      return chatMessages;
    } else {
      throw Exception("Failed to fetch chat room");
    }
  }

  Future<String> sendReport(String senderId, String targetId) async {
    final url = Uri.parse("$urlPrefix/chat/report");
    final response = await http.post(url,
        headers: {'content-type': 'application/json'},
        body: jsonEncode({'senderId': senderId, 'targetId': targetId}));

    if (response.statusCode == 200) {
      return "신고가 성공적으로 접수됐습니다.";
    } else {
      throw Exception("Failed to fetch chat room");
    }
  }

}

class ChatRoomResponseDTO {
  final String id;
  final String nickname;
  final String clientId;
  final String agentId;
  String recentMessage;

  ChatRoomResponseDTO({
    required this.id,
    required this.nickname,
    required this.clientId,
    required this.agentId,
    required this.recentMessage,
  });

  factory ChatRoomResponseDTO.fromJson(Map<String, dynamic> json) {
    return ChatRoomResponseDTO(
      id: json['id'],
      nickname: json['nickname'],
      clientId: json['clientId'],
      agentId: json['agentId'],
      recentMessage: json['recentMessage'] ?? "",
    );
  }
}

class AccountResponse {
  final String id;
  final String provider;
  final String providerUserId;
  final String nickname;
  final String role;
  final String licenseId;
  final String profileImageId;
  final String premiumDate;
  final String phone;

  AccountResponse({
    required this.id,
    required this.provider,
    required this.providerUserId,
    required this.nickname,
    required this.role,
    required this.licenseId,
    required this.profileImageId,
    required this.premiumDate,
    required this.phone,
  });

  factory AccountResponse.fromJson(Map<String, dynamic> json) {
    return AccountResponse(
      id: json['Id'],
      provider: json['Provider'],
      providerUserId: json['ProviderUserId'],
      nickname: json['Nickname'],
      role: json['Role'],
      licenseId: json['LicenseId'],
      profileImageId: json['ProfileImageId'],
      premiumDate: json['PremiumDate'],
      phone: json['Phone'],
    );
  }
}
