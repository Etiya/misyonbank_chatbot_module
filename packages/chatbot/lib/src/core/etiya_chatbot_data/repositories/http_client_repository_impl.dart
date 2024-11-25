import 'dart:convert';

import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/models/models.dart';
import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_domain/repositories/repositories.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class HttpClientRepositoryImpl extends HttpClientRepository {
  HttpClientRepositoryImpl({
    required super.serviceUrl,
    required super.authUrl,
    required super.userId,
  });

  @override
  Future<bool> auth({
    required String username,
    required String password,
  }) async {
    final url = Uri.parse(authUrl);
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "username": username,
          "password": password,
          "chatId": "mobile:$userId",
        }),
      );
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        debugPrint(response.body);
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final isAuth = json["isAuth"] as bool? ?? false;
        debugPrint("isAuthenticated: $isAuth");
        return isAuth;
      } else {
        debugPrint(
          "User's message could not sent, statusCode: ${response.statusCode}",
        );
        return false;
      }
    } catch (error) {
      debugPrint(error.toString());
      return false;
    }
  }

  @override
  Future<void> sendMessage({
    required String botId,
    required String tenantId,
    required String sender,
    required String type,
    required String text,
    required User user,
    bool? dataVisible,
    ReplyPayload? payload,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$serviceUrl/mobile'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          MessageRequest(
            botId: botId,
            tenantId: tenantId,
            sender: sender,
            type: type,
            text: text,
            dataVisible: dataVisible,
            user: user,
            replyPayload: payload,
          ).toJson(),
        ),
      );
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        debugPrint("User's message sent successfully");
        debugPrint(
          jsonEncode(
            MessageRequest(
              botId: botId,
              tenantId: tenantId,
              sender: sender,
              type: type,
              text: text,
              user: user,
              replyPayload: payload,
              dataVisible: dataVisible,
            ).toJson(),
          ),
        );
      } else {
        debugPrint(
          "User's message could not sent, statusCode: ${response.statusCode}",
        );
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
