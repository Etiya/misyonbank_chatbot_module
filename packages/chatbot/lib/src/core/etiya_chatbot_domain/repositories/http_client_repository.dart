import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/models/api/etiya_message_request.dart';

abstract class HttpClientRepository {
  final String serviceUrl;
  final String authUrl;
  final String userId;

  HttpClientRepository({
    required this.serviceUrl,
    required this.authUrl,
    required this.userId,
  });

  /// LDAP Auth
  /// - Parameter username: User Name
  /// - Parameter password: User Password
  /// Returns authentication status.
  Future<bool> auth({
    required String username,
    required String password,
  });

  /// Send Message to Server
  Future<void> sendMessage({
    required String botId,
    required String tenantId,
    required String sender,
    required String type,
    required String text,
    required User user,
    ReplyPayload? payload,
    bool? dataVisible,
  });
}
