import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/models/api/etiya_message_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Payload Tests', () {
    test('Payload serialization/deserialization works correctly', () {
      final mockJson = {
        "typing": true,
        "choices": [
          {"title": "Choice1", "value": "Value1"},
          {"title": "Choice2", "value": "Value2"},
        ],
        "thank": "Thanks!",
        "url": "https://example.com",
        "dateType": "single",
      };

      final payload = Payload.fromJson(mockJson);

      expect(payload.typing, true);
      expect(payload.choices?.length, 2);
      expect(payload.choices?[0].title, "Choice1");
      expect(payload.url, "https://example.com");
      expect(payload.dateType, "single");

      final serialized = payload.toJson();
      expect(serialized["typing"], mockJson["typing"]);
      expect(serialized["url"], "https://example.com");
    });
  });

  group('Choice Tests', () {
    test('Choice serialization/deserialization works correctly', () {
      final mockJson = {
        "type": "button",
        "title": "Option1",
        "value": "Value1",
      };

      final choice = Choice.fromJson(mockJson);

      expect(choice.type, "button");
      expect(choice.title, "Option1");
      expect(choice.value, "Value1");

      final serialized = choice.toJson();
      expect(serialized["type"], "button");
      expect(serialized["title"], "Option1");
    });
  });

  group('Config Tests', () {
    test('Config serialization/deserialization works correctly', () {
      final mockJson = {
        "faqId": "123",
        "entity": "entity1",
        "intent": "intent1",
        "entityValue": "value1",
      };

      final config = Config.fromJson(mockJson);

      expect(config.faqId, "123");
      expect(config.entity, "entity1");
      expect(config.intent, "intent1");
      expect(config.entityValue, "value1");

      final serialized = config.toJson();
      expect(serialized["faqId"], "123");
      expect(serialized["entity"], "entity1");
    });
  });

  group('Item Tests', () {
    test('Item serialization/deserialization works correctly', () {
      final mockJson = {
        "title": "Item1",
        "subtitle": "Subtitle1",
        "picture": "https://example.com/image.png",
        "buttons": [
          {"type": "button", "title": "Button1", "value": "Value1"},
        ],
      };

      final item = Item.fromJson(mockJson);

      expect(item.title, "Item1");
      expect(item.subtitle, "Subtitle1");
      expect(item.picture, "https://example.com/image.png");
      expect(item.buttons?.length, 1);

      final serialized = item.toJson();
      expect(serialized["title"], "Item1");
      expect(serialized["picture"], "https://example.com/image.png");
    });
  });

  group('Field Tests', () {
    test('Field serialization/deserialization works correctly', () {
      final mockJson = {
        "type": "text",
        "label": "Label1",
        "title": "Title1",
        "value": "Value1",
        "required": true,
      };

      final field = Field.fromJson(mockJson);

      expect(field.type, "text");
      expect(field.label, "Label1");
      expect(field.title, "Title1");
      expect(field.value, "Value1");
      expect(field.required, true);

      final serialized = field.toJson();
      expect(serialized["type"], "text");
      expect(serialized["label"], "Label1");
    });
  });

  group('Extras Tests', () {
    test('Extras serialization/deserialization works correctly', () {
      final mockJson = {"access_token": "mock_token"};

      final extras = Extras.fromJson(mockJson);

      expect(extras.accessToken, "mock_token");

      final serialized = extras.toJson();
      expect(serialized["access_token"], "mock_token");
    });
  });

  group('EtiyaChatUser Tests', () {
    test('EtiyaChatUser serialization/deserialization works correctly', () {
      final mockJson = {
        "id": "user1",
        "firstName": "John",
        "lastName": "Doe",
        "createdOn": "2024-01-01T12:00:00Z",
      };

      final user = EtiyaChatUser.fromJson(mockJson);

      expect(user.id, "user1");
      expect(user.firstName, "John");
      expect(user.lastName, "Doe");

      final serialized = user.toJson();
      expect(serialized["id"], "user1");
      expect(serialized["firstName"], "John");
    });
  });
}
