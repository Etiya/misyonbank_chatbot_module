import 'package:flutter/material.dart';

/// Dark
const dark = Color(0xff1f1c38);

/// N0
const neutral0 = Color(0xff1d1c21);

/// N2
const neutral2 = Color(0xff9e9cab);

/// N7
const neutral7 = Color(0xffffffff);

/// N7 with opacity
const neutral7WithOpacity = Color(0x80ffffff);

/// Primary
const primary = Color(0xff6f61e8);

/// Secondary
const secondary = Color(0xfff5f5f7);

/// Secondary dark
const secondaryDark = Color(0xff2b4250);

/// Base chat theme containing all required properties to make a theme.
/// Extend this class if you want to create a custom theme.
@immutable
abstract class PopupTheme {
  /// Creates a new chat theme based on provided colors and text styles.
  const PopupTheme();

  /// Text padding to it's container
  /// String get backgroundColor;
  String get titleText;
  String get subTitleText;
  String get descriptionText;
  String get imageUrl;

  BoxDecoration get mainBoxDecoration;
  BoxDecoration get imageBoxDecoration;
  TextStyle get titleTextStyle;
  TextStyle get subTitleTextStyle;
  TextStyle get descriptionTextStyle;

  double get containerHeight;
  double get containerWidth;
  double get containerPadding;
  double get imageHeight;
  double get imageWidth;

  double get titleTextPadding;
  double get subTitleTextPadding;
  double get descriptionTextPadding;
}
