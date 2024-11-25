import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/models/api/etiya_message_response.dart';
import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/models/etiya_chat_message.dart';
import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/models/etiya_date_picker_message_kind.dart';
import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/models/etiya_form_message_kind.dart';
import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/models/etiya_login_message_kind.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MessageMapper Tests', () {
    test('Map "login" message type to EtiyaChatMessage', () {
      final messageResponse = MessageResponse(
        id: 1,
        type: 'login',
        text: 'Login Message',
        createdAt: DateTime.now(),
        user: EtiyaChatUser(),
      );

      final messages = messageResponse.mapToChatMessage();

      expect(messages.length, 1);
      expect(
        messages.first.messageKind.custom,
        isA<EtiyaLoginMessageKind>(),
      );
      expect(
        (messages.first.messageKind.custom as EtiyaLoginMessageKind).title,
        'Login Message',
      );
    });

    test('Map "form" message type to EtiyaChatMessage', () {
      final messageResponse = MessageResponse(
        id: 2,
        type: 'form',
        text: 'Form Message',
        payload: Payload(
          fields: [
            Field(
              title: "",
            ),
            Field(
              title: "",
            ),
          ],
          typing: null,
        ),
        createdAt: DateTime.now(),
        user: EtiyaChatUser(),
      );

      final messages = messageResponse.mapToChatMessage();

      expect(messages.length, 1);
      expect(messages.first.messageKind.custom, isA<EtiyaFormMessageKind>());
      expect(
        (messages.first.messageKind.custom as EtiyaFormMessageKind).title,
        'Form Message',
      );
    });

    test('Map "date-picker" message type to EtiyaChatMessage', () {
      final messageResponse = MessageResponse(
        id: 3,
        type: 'date-picker',
        text: 'Date Picker Message',
        payload: Payload(dateType: 'single', typing: null),
        createdAt: DateTime.now(),
        user: EtiyaChatUser(),
      );

      final messages = messageResponse.mapToChatMessage();

      expect(messages.length, 1);
      expect(
        messages.first.messageKind.custom,
        isA<EtiyaDatePickerMessageKind>(),
      );
      expect(
        (messages.first.messageKind.custom as EtiyaDatePickerMessageKind).title,
        'Date Picker Message',
      );
    });

    test(
        'Map "single-choice" message type with quick replies to EtiyaChatMessage',
        () {
      final messageResponse = MessageResponse(
        id: 4,
        type: 'single-choice',
        text: 'Single Choice Message',
        payload: Payload(
          choices: [
            Choice(title: 'Option 1', value: 'Value 1'),
          ],
          typing: null,
        ),
        createdAt: DateTime.now(),
        user: EtiyaChatUser(),
      );

      final messages = messageResponse.mapToChatMessage();

      expect(messages.length, 2);
      expect(messages.first.messageKind.quickReplies, isNotEmpty);
      expect(messages.first.messageKind.quickReplies.length, 1);
    });

    test('Map "text" message type to EtiyaChatMessage', () {
      final messageResponse = MessageResponse(
        id: 5,
        type: 'text',
        text: 'Plain Text Message',
        createdAt: DateTime.now(),
        user: EtiyaChatUser(),
      );

      final messages = messageResponse.mapToChatMessage();

      expect(messages.length, 1);
      expect(messages.first.messageKind.text, 'Plain Text Message');
    });

    test('Map "carousel" message type to EtiyaChatMessage', () {
      final messageResponse = MessageResponse(
        id: 6,
        type: 'carousel',
        payload: Payload(
          items: [
            Item(
              title: 'Item 1',
              subtitle: 'Subtitle 1',
              picture: 'http://example.com/image1.png',
              buttons: [
                CarouselButton(title: 'Button 1', value: 'Action 1'),
              ],
            ),
            Item(
              title: 'Item 2',
              subtitle: 'Subtitle 2',
              picture: 'http://example.com/image2.png',
              buttons: [
                CarouselButton(title: 'Button 2', value: 'Action 2'),
              ],
            ),
          ],
          typing: null,
        ),
        createdAt: DateTime.now(),
        user: EtiyaChatUser(),
      );

      final messages = messageResponse.mapToChatMessage();

      expect(messages.length, 1);
      expect(messages.first.messageKind.carouselItems, isNotEmpty);
      expect(messages.first.messageKind.carouselItems.length, 2);
    });
  });
}
