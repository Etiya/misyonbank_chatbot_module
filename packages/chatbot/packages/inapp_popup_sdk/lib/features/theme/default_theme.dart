import 'package:flutter/material.dart';
import 'package:inapp_popup_sdk/features/theme/popup_theme.dart';
import 'package:inapp_popup_sdk/features/theme/string_constant.dart';

/// Default chat theme which extends [PopupTheme]
@immutable
class DefaultPopupTheme extends PopupTheme {
  const DefaultPopupTheme();

  @override
  String get titleText => StringConstant.titleText;
  @override
  String get subTitleText => StringConstant.subTitleText;
  @override
  String get descriptionText => StringConstant.descriptionText;
  @override
  String get imageUrl => StringConstant.imageUrl;

  @override
  BoxDecoration get mainBoxDecoration => StringConstant.mainBoxDecoration;
  @override
  BoxDecoration get imageBoxDecoration => StringConstant.imageBoxDecoration;
  @override
  TextStyle get titleTextStyle => StringConstant.titleTextStyle;
  @override
  TextStyle get subTitleTextStyle => StringConstant.subTitleTextStyle;
  @override
  TextStyle get descriptionTextStyle => StringConstant.descriptionTextStyle;

  @override
  double get containerHeight => StringConstant.containerHeight;
  @override
  double get containerWidth => StringConstant.containerWidth;
  @override
  double get containerPadding => StringConstant.containerPadding;
  @override
  double get imageHeight => StringConstant.imageHeight;
  @override
  double get imageWidth => StringConstant.imageWidth;
  @override
  double get titleTextPadding => StringConstant.titleTextPadding;
  @override
  double get subTitleTextPadding => StringConstant.subTitleTextPadding;
  @override
  double get descriptionTextPadding => StringConstant.descriptionTextPadding;
}
