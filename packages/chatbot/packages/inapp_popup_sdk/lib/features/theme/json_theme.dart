import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inapp_popup_sdk/features/showpopup/data/models/custom_info.dart';
import 'package:inapp_popup_sdk/features/theme/popup_theme.dart';

/// Default chat theme which extends [PopupTheme]
@immutable
class JsonPopupTheme extends PopupTheme {
  const JsonPopupTheme(this.customInfo);
  final CustomInfo customInfo;

  @override
  String get titleText => customInfo.data!.titleText!;
  @override
  String get subTitleText => customInfo.data!.subTitleText!;
  @override
  String get descriptionText => customInfo.data!.descriptionText!;
  @override
  String get imageUrl => customInfo.data!.imageUrl!;

  @override
  BoxDecoration get mainBoxDecoration => createDecoration(
      color: customInfo.theme!.backgroundColor,
      radius: customInfo.theme!.imageRadius);
  @override
  BoxDecoration get imageBoxDecoration =>
      createDecoration(radius: customInfo.theme!.imageRadius);
  @override
  TextStyle get titleTextStyle => createTextStyle(
      color: customInfo.theme!.titleTextColor,
      fontSize: customInfo.theme!.titleTextSize,
      fontWeight: customInfo.theme!.titleTextFontWeight);
  @override
  TextStyle get subTitleTextStyle => createTextStyle(
      color: customInfo.theme!.subTitleTextColor,
      fontSize: customInfo.theme!.subTitleTextSize,
      fontWeight: customInfo.theme!.subTitleTextFontWeight);
  @override
  TextStyle get descriptionTextStyle => createTextStyle(
      color: customInfo.theme!.descriptionTextColor,
      fontSize: customInfo.theme!.descriptionTextSize,
      fontWeight: customInfo.theme!.descriptionTextFontWeight);

  @override
  double get containerHeight => customInfo.theme!.containerHeight!;
  @override
  double get containerWidth => customInfo.theme!.containerWidth!;
  @override
  double get containerPadding => customInfo.theme!.containerPadding!;
  @override
  double get imageHeight => customInfo.theme!.imageHeight!;
  @override
  double get imageWidth => customInfo.theme!.imageWidth!;

  @override
  double get titleTextPadding => customInfo.theme!.titleTextPadding!;

  @override
  double get subTitleTextPadding => customInfo.theme!.subTitleTextPadding!;

  @override
  double get descriptionTextPadding =>
      customInfo.theme!.descriptionTextPadding!;
}

int colorParser({String? color}) {
  final colors = color != null
      ? int.parse(jsonDecode(
          jsonEncode(color),
        ))
      : 0x00FFFFFF;
  return colors;
}

BoxDecoration createDecoration({String? color, double? radius}) {
  return BoxDecoration(
    color: Color(colorParser(color: color)),
    borderRadius: BorderRadius.circular(radius ?? 0),
  );
}

TextStyle createTextStyle({double? fontSize, String? color, bool? fontWeight}) {
  return TextStyle(
      color: Color(colorParser(color: color)),
      fontSize: fontSize,
      fontWeight: fontWeight == true ? FontWeight.bold : FontWeight.normal);
}
