import 'package:etiya_chatbot_flutter/src/util/app_bar_theme.dart';
import 'package:etiya_chatbot_flutter/src/util/default_app_bar_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DefaultAppBarTheme Tests', () {
    const defaultAppBarTheme = DefaultAppBarTheme();

    test('appBarBackgroundColor should return primaryColor', () {
      expect(defaultAppBarTheme.appBarBackgroundColor, primaryColor);
    });

    test('appBarRefreshIcon should return an Icon widget with Icons.refresh',
        () {
      expect(defaultAppBarTheme.appBarRefreshIcon.icon, Icons.refresh);
    });

    test('appBarTitle should return a Text widget with "Chatbot"', () {
      expect(defaultAppBarTheme.appBarTitle, isA<Text>());
      expect((defaultAppBarTheme.appBarTitle! as Text).data, 'Chatbot');
    });
  });
}
