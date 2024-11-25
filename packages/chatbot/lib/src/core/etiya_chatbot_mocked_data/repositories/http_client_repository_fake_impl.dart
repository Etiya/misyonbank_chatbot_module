import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/models/api/etiya_message_request.dart';
import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_domain/repositories/repositories.dart';

class FakeHttpClientRepository extends HttpClientRepository {
  FakeHttpClientRepository({
    required super.serviceUrl,
    required super.authUrl,
    required super.userId,
  });

  @override
  Future<bool> auth({
    required String username,
    required String password,
  }) =>
      Future.value(
        username == 'username' && password == 'password',
      );

  @override
  Future<void> sendMessage({
    required String botId,
    required String tenantId,
    required String sender,
    required String type,
    required String text,
    required User user,
    ReplyPayload? payload,
    bool? dataVisible,
  }) =>
      Future.delayed(const Duration(milliseconds: 700));
}
