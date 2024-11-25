import 'package:etiya_chatbot_flutter/etiya_chatbot_flutter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MessageData Tests', () {
    test('MessageData serialization/deserialization works correctly', () {
      final mockJson = {
        "page": "home",
        "title": "Welcome",
        "payload": "data",
        "feedbackExist": true,
        "rate": "5",
        "comment": "Great",
        "sessionId": 12345,
      };

      final messageData = MessageData.fromJson(mockJson);

      expect(messageData.page, "home");
      expect(messageData.title, "Welcome");
      expect(messageData.payload, "data");
      expect(
        messageData.feedbackExist,
        null,
      );
      expect(messageData.rate, null);
      expect(messageData.comment, null);
      expect(
        messageData.sessionId,
        null,
      );

      messageData.feedbackExist = mockJson["feedbackExist"] as bool?;
      messageData.rate = mockJson["rate"] as String?;
      messageData.comment = mockJson["comment"] as String?;
      messageData.sessionId = mockJson["sessionId"] as int?;

      final serializedJson = messageData.toJson();

      expect(serializedJson["page"], "home");
      expect(serializedJson["title"], "Welcome");
      expect(serializedJson["payload"], "data");
      expect(serializedJson["feedbackExist"], true);
      expect(serializedJson["rate"], "5");
      expect(serializedJson["comment"], "Great");
      expect(serializedJson["sessionId"], 12345);
    });
  });
}
