import 'package:flutter/material.dart';
import 'package:inapp_popup_sdk/features/showpopup/presentation/widget/custom_dialog_widget.dart';
import 'package:inapp_popup_sdk/features/theme/popup_theme.dart';

extension DialogExtension on BuildContext {
  showCustomDialog(
    PopupTheme theme, {
    Widget? customPopupWidget,
  }) =>
      showDialog<void>(
        context: this,
        useRootNavigator: true,
        builder: (BuildContext context) {
          return CustomDialogWidget(
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
          );
        },
      );
}
