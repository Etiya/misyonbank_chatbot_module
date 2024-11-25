import 'package:etiya_chatbot_flutter/src/util/chatbot_default_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChatbotDefaultTheme Tests', () {
    test('ChatbotDefaultTheme default values are correct', () {
      const theme = ChatbotDefaultTheme();

      expect(theme.backgroundColor, const Color(0xffffffff));
      expect(theme.primaryColor, const Color(0xFF7368F4));
      expect(theme.secondaryColor, const Color(0xFFF2F2F2));
      expect(theme.htmlTextColor, Colors.blueAccent);

      expect(theme.incomingMessageBodyTextStyle.fontFamily, 'Fedra-Sans-Std');
      expect(theme.incomingMessageBodyTextStyle.fontSize, 17);
      expect(theme.incomingMessageBodyTextStyle.color, Colors.grey.shade900);

      expect(theme.outgoingMessageBodyTextStyle.fontFamily, 'Fedra-Sans-Std');
      expect(theme.outgoingMessageBodyTextStyle.fontSize, 17);
      expect(theme.outgoingMessageBodyTextStyle.color, Colors.white);

      expect(theme.carouselTitleTextStyle.fontFamily, 'Fedra-Sans-Std');
      expect(theme.carouselTitleTextStyle.fontSize, 19);

      expect(theme.carouselSubtitleTextStyle.fontFamily, 'Fedra-Sans-Std');
      expect(theme.carouselSubtitleTextStyle.fontSize, 17);

      expect(theme.htmlWidgetTextTime.fontFamily, 'Fedra-Sans-Std');
      expect(theme.htmlWidgetTextTime.fontSize, 12);

      expect(theme.imageWidgetTextTime.fontFamily, 'Fedra-Sans-Std');
      expect(theme.imageWidgetTextTime.fontSize, 12);
      expect(theme.imageWidgetTextTime.color, Colors.white);

      expect(theme.incomingChatTextTime.fontFamily, 'Fedra-Sans-Std');
      expect(theme.incomingChatTextTime.fontSize, 12);
      expect(theme.incomingChatTextTime.color, Colors.grey.shade900);

      expect(theme.outgoingChatTextTime.fontFamily, 'Fedra-Sans-Std');
      expect(theme.outgoingChatTextTime.fontSize, 12);
      expect(theme.outgoingChatTextTime.color, Colors.white);

      expect(theme.messageBorderRadius, 20);
      expect(theme.textMessagePadding, 12);
      expect(theme.messageInset, const EdgeInsets.symmetric(vertical: 8));

      expect(
        theme.carouselButtonStyle.backgroundColor?.resolve({}),
        const Color(0xFF7368F4),
      );
      expect(
        theme.carouselButtonStyle.foregroundColor?.resolve({}),
        Colors.white,
      );

      expect(
        theme.quickReplyButtonStyle.shape?.resolve({}),
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      );

      expect(
        theme.carouselBoxDecoration.borderRadius,
        BorderRadius.circular(16),
      );
      expect(theme.carouselBoxDecoration.color, const Color(0xFFF2F2F2));
    });
  });
}
