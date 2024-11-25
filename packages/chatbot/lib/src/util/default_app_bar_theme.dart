import 'package:etiya_chatbot_flutter/src/util/app_bar_theme.dart';
import 'package:flutter/material.dart';

@immutable
final class DefaultAppBarTheme extends ChatbotAppBarTheme {
  const DefaultAppBarTheme() : super();

  @override
  Color get appBarBackgroundColor => primaryColor;

  @override
  Icon get appBarRefreshIcon => const Icon(Icons.refresh);

  @override
  Widget? get appBarTitle => const Text("Chatbot");
}
