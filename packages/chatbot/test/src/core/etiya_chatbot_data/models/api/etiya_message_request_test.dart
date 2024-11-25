import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/models/api/etiya_message_request.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MessageRequest', () {
    test('toJson and fromJson work correctly', () {
      final user = User(
        id: 'user123',
        channel: 'web',
        firstName: 'John',
        lastName: 'Doe',
      );

      final replyPayload = ReplyPayload(
        scope: 'global',
        field: [
          ReplyField(label: 'Field1', value: 'Value1'),
        ],
        browserTimeZone: 'UTC',
        browserLang: 'en',
        date1: '2024-11-01',
        date2: '2024-11-02',
        dateType: 'range',
      );

      final messageRequest = MessageRequest(
        dataVisible: true,
        botId: 'bot123',
        tenantId: 'tenant123',
        sender: 'sender123',
        type: 'text',
        text: 'Hello, world!',
        user: user,
        replyPayload: replyPayload,
      );

      final json = messageRequest.toJson();

      final expectedJson = {
        'dataVisible': true,
        'botId': 'bot123',
        'tenantId': 'tenant123',
        'sender': 'sender123',
        'type': 'text',
        'text': 'Hello, world!',
        'user': {
          'id': 'user123',
          'channel': 'web',
          'firstName': 'John',
          'lastName': 'Doe',
        },
        'payload': {
          'scope': 'global',
          'field': [
            {'label': 'Field1', 'value': 'Value1'},
          ],
          'browserTimeZone': 'UTC',
          'browserLang': 'en',
          'date1': '2024-11-01',
          'date2': '2024-11-02',
          'dateType': 'range',
        },
      };

      final newMessageRequest = MessageRequest.fromJson(expectedJson);

      expect(newMessageRequest.dataVisible, messageRequest.dataVisible);
      expect(newMessageRequest.botId, messageRequest.botId);
      expect(newMessageRequest.tenantId, messageRequest.tenantId);
      expect(newMessageRequest.sender, messageRequest.sender);
      expect(newMessageRequest.type, messageRequest.type);
      expect(newMessageRequest.text, messageRequest.text);
      expect(newMessageRequest.user.id, user.id);
      expect(newMessageRequest.user.channel, user.channel);
      expect(newMessageRequest.user.firstName, user.firstName);
      expect(newMessageRequest.user.lastName, user.lastName);
      expect(newMessageRequest.replyPayload?.scope, replyPayload.scope);
      expect(newMessageRequest.replyPayload?.browserTimeZone,
          replyPayload.browserTimeZone);
      expect(newMessageRequest.replyPayload?.browserLang,
          replyPayload.browserLang);
      expect(newMessageRequest.replyPayload?.date1, replyPayload.date1);
      expect(newMessageRequest.replyPayload?.date2, replyPayload.date2);
      expect(newMessageRequest.replyPayload?.dateType, replyPayload.dateType);
      expect(newMessageRequest.replyPayload?.field?.length,
          replyPayload.field?.length);
      expect(newMessageRequest.replyPayload?.field?.first.label,
          replyPayload.field?.first.label);
      expect(newMessageRequest.replyPayload?.field?.first.value,
          replyPayload.field?.first.value);
    });
  });
}
