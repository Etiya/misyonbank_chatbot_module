import 'package:flutter/material.dart';

class StringConstant {
  static const String titleText = "title text";
  static const String subTitleText = "subtitle text";
  static const String descriptionText = "description text";
  static const String imageUrl =
      "https://www.istanbulgo.org/live/wp-content/uploads/2018/09/logo-1.png";

  static final BoxDecoration mainBoxDecoration = BoxDecoration(
    color: Colors.yellow,
    borderRadius: BorderRadius.circular(0),
  );

  static final BoxDecoration imageBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(20),
  );

  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 22,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subTitleTextStyle =
      TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold);

  static const TextStyle descriptionTextStyle = TextStyle(
    fontSize: 16,
    color: Colors.black,
  );

  static const double containerHeight = 400;
  static const double containerWidth = 400;
  static const double containerPadding = 20;
  static const double imageHeight = 200;
  static const double imageWidth = 200;
  static const double titleTextPadding = 10;
  static const double subTitleTextPadding = 10;
  static const double descriptionTextPadding = 10;
}
