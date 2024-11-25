import 'package:flutter/material.dart';

/// Dark
const darkColor = Color(0xff1f1c38);

/// N0
const neutral0Color = Color(0xff1d1c21);

/// N2
const neutral2Color = Color(0xff9e9cab);

/// N7
const neutral7Color = Color(0xffffffff);

/// N7 with opacity
const neutral7WithOpacityColor = Color(0x80ffffff);

/// Primary
const primaryColor = Color(0xFF00C2E7);

/// Secondary
const secondaryColor = Color(0xfff5f5f7);

/// Secondary dark
const secondaryDarkColor = Color(0xff2b4250);

@immutable
abstract class ChatbotAppBarTheme {
  const ChatbotAppBarTheme();
  Color get appBarBackgroundColor;

  Widget? get appBarTitle;

  Icon get appBarRefreshIcon;
}
