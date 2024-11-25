import 'dart:ui';

import 'package:etiya_chatbot_flutter/src/localization/generated/app_localizations.dart';
import 'package:etiya_chatbot_flutter/src/localization/localization_delegate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('isSupported method test', () {
    const delegate = ChatBotAppLocalizationsDelegate();
    expect(delegate.isSupported(const Locale('en')), true);
    expect(delegate.isSupported(const Locale('tr')), true);
    expect(delegate.isSupported(const Locale('fr')), false);
  });

  test('load method test', () async {
    const delegate = ChatBotAppLocalizationsDelegate();
    final instance = await delegate.load(const Locale('en'));
    expect(instance, isA<AppLocalizations>());
    expect(ChatBotAppLocalizationsDelegate.instance, instance);
  });

  test('shouldReload method test', () {
    const delegate = ChatBotAppLocalizationsDelegate();
    const oldDelegate = ChatBotAppLocalizationsDelegate();
    expect(delegate.shouldReload(oldDelegate), false);
  });
}
