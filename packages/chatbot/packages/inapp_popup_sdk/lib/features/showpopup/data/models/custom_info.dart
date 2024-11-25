// To parse this JSON data, do
//
//     final customInfo = customInfoFromMap(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

CustomInfo customInfoFromMap(String str) =>
    CustomInfo.fromMap(json.decode(str));

String customInfoToMap(CustomInfo data) => json.encode(data.toMap());

class CustomInfo {
  Data? data;
  Theme? theme;
  bool? themeInfo;
  Widget? customPopupWidget;

  CustomInfo({
    this.data,
    this.theme,
    this.themeInfo,
    this.customPopupWidget,
  });

  factory CustomInfo.fromMap(Map<String, dynamic> json) => CustomInfo(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        theme: json["theme"] == null ? null : Theme.fromMap(json["theme"]),
        themeInfo: json["themeInfo"],
        customPopupWidget: json["customPopupWidget"],
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "theme": theme?.toMap(),
        "themeInfo": themeInfo,
        "customPopupWidget": customPopupWidget,
      };
}

class Data {
  String? imageUrl;
  String? titleText;
  String? subTitleText;
  String? descriptionText;

  Data({
    this.imageUrl,
    this.titleText,
    this.subTitleText,
    this.descriptionText,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        imageUrl: json["image_url"],
        titleText: json["title_text"],
        subTitleText: json["subTitle_text"],
        descriptionText: json["description_text"],
      );

  Map<String, dynamic> toMap() => {
        "image_url": imageUrl,
        "title_text": titleText,
        "subTitle_text": subTitleText,
        "description_text": descriptionText,
      };
}

class Theme {
  String? backgroundColor;
  double? containerRadius;
  double? containerHeight;
  double? containerWidth;
  double? containerPadding;
  double? imageHeight;
  double? imageWidth;
  double? imageRadius;
  double? titleTextSize;
  double? titleTextPadding;
  bool? titleTextFontWeight;
  String? titleTextColor;
  double? subTitleTextSize;
  double? subTitleTextPadding;
  bool? subTitleTextFontWeight;
  String? subTitleTextColor;
  double? descriptionTextSize;
  double? descriptionTextPadding;
  bool? descriptionTextFontWeight;
  String? descriptionTextColor;

  Theme({
    this.backgroundColor,
    this.containerRadius,
    this.containerHeight,
    this.containerWidth,
    this.containerPadding,
    this.imageHeight,
    this.imageWidth,
    this.imageRadius,
    this.titleTextSize,
    this.titleTextPadding,
    this.titleTextFontWeight,
    this.titleTextColor,
    this.subTitleTextSize,
    this.subTitleTextPadding,
    this.subTitleTextFontWeight,
    this.subTitleTextColor,
    this.descriptionTextSize,
    this.descriptionTextPadding,
    this.descriptionTextFontWeight,
    this.descriptionTextColor,
  });

  factory Theme.fromMap(Map<String, dynamic> json) => Theme(
        backgroundColor: json["background_color"],
        containerRadius: json["container_radius"]?.toDouble(),
        containerHeight: json["container_height"]?.toDouble(),
        containerWidth: json["container_width"]?.toDouble(),
        containerPadding: json["container_padding"]?.toDouble(),
        imageHeight: json["image_height"]?.toDouble(),
        imageWidth: json["image_width"]?.toDouble(),
        imageRadius: json["image_radius"]?.toDouble(),
        titleTextSize: json["title_text_size"]?.toDouble(),
        titleTextPadding: json["title_text_padding"]?.toDouble(),
        titleTextFontWeight: json["title_text_font_weight"],
        titleTextColor: json["title_text_color"],
        subTitleTextSize: json["subTitle_text_size"]?.toDouble(),
        subTitleTextPadding: json["subTitle_text_padding"]?.toDouble(),
        subTitleTextFontWeight: json["subTitle_text_font_weight"],
        subTitleTextColor: json["subTitle_text_color"],
        descriptionTextSize: json["description_text_size"]?.toDouble(),
        descriptionTextPadding: json["description_text_padding"]?.toDouble(),
        descriptionTextFontWeight: json["description_text_font_weight"],
        descriptionTextColor: json["description_text_color"],
      );

  Map<String, dynamic> toMap() => {
        "background_color": backgroundColor,
        "container_radius": containerRadius,
        "container_height": containerHeight,
        "container_width": containerWidth,
        "container_padding": containerPadding,
        "image_height": imageHeight,
        "image_width": imageWidth,
        "image_radius": imageRadius,
        "title_text_size": titleTextSize,
        "title_text_padding": titleTextPadding,
        "title_text_font_weight": titleTextFontWeight,
        "title_text_color": titleTextColor,
        "subTitle_text_size": subTitleTextSize,
        "subTitle_text_padding": subTitleTextPadding,
        "subTitle_text_font_weight": subTitleTextFontWeight,
        "subTitle_text_color": subTitleTextColor,
        "description_text_size": descriptionTextSize,
        "description_text_padding": descriptionTextPadding,
        "description_text_font_weight": descriptionTextFontWeight,
        "description_text_color": descriptionTextColor,
      };
}
