import 'package:flutter/material.dart';
import 'package:inapp_popup_sdk/features/showpopup/presentation/widget/custom_bottom_sheet_widget.dart';
import 'package:inapp_popup_sdk/features/theme/popup_theme.dart';

extension BottomSheetExtension on BuildContext {
  showCustomBottomSheet(
    PopupTheme theme, {
    Widget? customPopupWidget,
  }) =>
      showModalBottomSheet<void>(
        isScrollControlled: true,
        enableDrag: true,
        isDismissible: true,
        context: this,
        useRootNavigator: true,
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        builder: (BuildContext context) {
          return CustomBottomSheetWidget(
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
