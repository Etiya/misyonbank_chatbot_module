import 'package:flutter/material.dart';

class CustomToastWidget extends StatelessWidget {
  final String? titleText;
  final double? titleTextPadding;
  final TextStyle? titleTextStyle;
  final String? subTitleText;
  final double? subTitleTextPadding;
  final TextStyle? subTitleTextStyle;
  final String? descriptionText;
  final double? descriptionTextPadding;
  final TextStyle? descriptionTextStyle;
  final String? imageUrl;
  final BoxDecoration? imageBoxDecoration;
  final BoxDecoration? mainBoxDecoration;
  final double? containerPadding;
  final double? containerHeight;
  final double? containerWidth;
  final double? imageHeight;
  final double? imageWidth;
  final Widget? customPopupWidget;

  const CustomToastWidget({
    super.key,
    this.containerHeight,
    this.containerPadding,
    this.containerWidth,
    this.descriptionText,
    this.descriptionTextPadding,
    this.descriptionTextStyle,
    this.imageBoxDecoration,
    this.imageHeight,
    this.imageUrl,
    this.imageWidth,
    this.mainBoxDecoration,
    this.subTitleText,
    this.subTitleTextPadding,
    this.subTitleTextStyle,
    this.titleText,
    this.titleTextPadding,
    this.titleTextStyle,
    this.customPopupWidget,
  });

  @override
  Widget build(BuildContext context) {
    return customPopupWidget ??
        Container(
          width: containerWidth,
          height: containerHeight,
          decoration: mainBoxDecoration,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(titleTextPadding!),
                child: Text(titleText!, style: titleTextStyle),
              ),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(imageUrl!))),
              ),
              Padding(
                padding: EdgeInsets.all(subTitleTextPadding!),
                child: Text(
                  subTitleText!,
                  style: subTitleTextStyle,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(descriptionTextPadding!),
                child: Text(
                  descriptionText!,
                  style: descriptionTextStyle,
                ),
              )
            ],
          ),
        );
  }
}
