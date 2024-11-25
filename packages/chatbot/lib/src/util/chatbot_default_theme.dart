import 'package:etiya_chatbot_flutter/etiya_chatbot_flutter.dart';
import 'package:flutter/material.dart';

class ChatbotDefaultTheme extends ChatTheme {
  const ChatbotDefaultTheme() : super();

  static const Color chatbotPrimary = Color(0xFF7368F4);
  static const Color chatbotSecondary = Color(0xFFF2F2F2);

  @override
  Color get backgroundColor => neutral7;

  @override
  double get messageBorderRadius => 20;

  @override
  double get textMessagePadding => 12;

  @override
  Color get primaryColor => chatbotPrimary;

  @override
  Color get secondaryColor => chatbotSecondary;

  @override
  TextStyle get incomingMessageBodyTextStyle => TextStyle(
        fontFamily: 'Fedra-Sans-Std',
        fontSize: 17,
        color: Colors.grey.shade900,
      );

  @override
  TextStyle get outgoingMessageBodyTextStyle => const TextStyle(
        fontFamily: 'Fedra-Sans-Std',
        fontSize: 17,
        color: Colors.white,
      );

  @override
  EdgeInsets get messageInset => const EdgeInsets.symmetric(vertical: 8);

  @override
  TextStyle get carouselTitleTextStyle =>
      const TextStyle(fontFamily: 'Fedra-Sans-Std', fontSize: 19);

  @override
  TextStyle get carouselSubtitleTextStyle =>
      const TextStyle(fontFamily: 'Fedra-Sans-Std', fontSize: 17);

  @override
  ButtonStyle get carouselButtonStyle => ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(chatbotPrimary),
        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
      );

  @override
  BoxDecoration get carouselBoxDecoration => BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFFF2F2F2),
      );

  @override
  ButtonStyle get quickReplyButtonStyle => ButtonStyle(
        shape: WidgetStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        foregroundColor: WidgetStateProperty.all<Color>(chatbotPrimary),
        textStyle: WidgetStateProperty.all<TextStyle>(
          const TextStyle(
            fontWeight: FontWeight.bold,
            color: chatbotSecondary,
          ),
        ),
      );

  @override
  Color get htmlTextColor => Colors.blueAccent;

  @override
  String? get htmlTextFontFamily => 'Avenir';

  @override
  BorderRadius get imageBorderRadius => BorderRadius.circular(10);

  @override
  TextStyle get htmlWidgetTextTime => const TextStyle(
        fontFamily: 'Fedra-Sans-Std',
        fontSize: 12,
      );

  @override
  TextStyle get imageWidgetTextTime => const TextStyle(
        fontFamily: 'Fedra-Sans-Std',
        fontSize: 12,
        color: Colors.white,
      );

  @override
  TextStyle get incomingChatTextTime => TextStyle(
        fontFamily: 'Fedra-Sans-Std',
        fontSize: 12,
        color: Colors.grey.shade900,
      );
  @override
  TextStyle get outgoingChatTextTime => const TextStyle(
        fontFamily: 'Fedra-Sans-Std',
        fontSize: 12,
        color: Colors.white,
      );
}
