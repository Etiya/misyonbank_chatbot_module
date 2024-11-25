import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inapp_popup_sdk/features/showpopup/presentation/widget/custom_toast_widget.dart';
import 'package:inapp_popup_sdk/features/theme/popup_theme.dart';

extension ToastExtension on BuildContext {
  FToast get _ftoast => FToast()..init(this);

  showCustomToast(
    PopupTheme theme, {
    Duration duration = const Duration(seconds: 3),
    Widget? customPopupWidget,
  }) =>
      _ftoast
        ..removeQueuedCustomToasts()
        ..showToast(
          child: CustomToastWidget(
            titleText: theme.titleText,
            titleTextPadding: theme.titleTextPadding,
            titleTextStyle: theme.titleTextStyle,
            subTitleText: theme.subTitleText,
            subTitleTextPadding: theme.subTitleTextPadding,
            subTitleTextStyle: theme.subTitleTextStyle,
            descriptionText: theme.descriptionText,
            descriptionTextPadding: theme.descriptionTextPadding,
            descriptionTextStyle: theme.descriptionTextStyle,
            mainBoxDecoration: theme.mainBoxDecoration,
            imageBoxDecoration: theme.imageBoxDecoration,
            imageHeight: theme.imageHeight,
            imageWidth: theme.imageWidth,
            imageUrl: theme.imageUrl,
            containerHeight: theme.containerHeight,
            containerWidth: theme.containerWidth,
            containerPadding: theme.containerPadding,
            customPopupWidget: customPopupWidget,
          ),
          gravity: ToastGravity.BOTTOM,
          toastDuration: duration,
        );
}
