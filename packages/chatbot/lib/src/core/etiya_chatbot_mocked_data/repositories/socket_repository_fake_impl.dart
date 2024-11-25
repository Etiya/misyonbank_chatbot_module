import 'dart:convert';
import 'dart:io';

import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/models/models.dart';
import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_domain/repositories/repositories.dart';
import 'package:flutter/cupertino.dart';

class FakeSocketClientRepository extends SocketClientRepository {
  FakeSocketClientRepository() : super(url: '');

  @override
  void dispose() {}

  Future<void> simulateTextMessageReceiveEvent(String text) async {
    final textMessageResponseJson =
        File('test/mock/data/text_message_response.json');
    final MessageResponse messageResponse = MessageResponse.fromJson(
      jsonDecode(
        await textMessageResponseJson.readAsString(),
      ) as Map<String, dynamic>,
    );
    messageResponse.text = text;
    onEvent({'newMessage': (json) => jsonEncode(messageResponse.toJson())});
  }

  @override
  void connect() => debugPrint('Fake Socket Connected');

  @override
  void emit(String event, [dynamic data]) {}

  @override
  void onConnect(Handler handler) {}

  @override
  void onError(Handler? onError) {}

  @override
  void onEvent(Map<String, Handler> eventHandler) {}
}
