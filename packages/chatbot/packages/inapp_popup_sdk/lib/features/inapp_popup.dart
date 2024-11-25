import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:inapp_popup_sdk/features/extensions/app_bottom_sheet_extension.dart';
import 'package:inapp_popup_sdk/features/extensions/app_dialog_extension.dart';
import 'package:inapp_popup_sdk/features/extensions/app_toast_extension.dart';
import 'package:inapp_popup_sdk/features/extensions/error_dialog_extension.dart';
import 'package:inapp_popup_sdk/features/showpopup/data/models/custom_info.dart';
import 'package:inapp_popup_sdk/features/showpopup/data/services/default_exception.dart';
import 'package:inapp_popup_sdk/features/showpopup/data/services/exception_handler.dart';
import 'package:inapp_popup_sdk/features/showpopup/presentation/showpopup_viewmodel.dart';
import 'package:inapp_popup_sdk/features/theme/default_theme.dart';
import 'package:inapp_popup_sdk/features/theme/popup_theme.dart';

class ShowPopupWidget {
  ShowPopupWidget({required this.builder});
  final ShowPopupWidgetBuilder builder;
  ShowPopupViewModel showPopupViewModel = ShowPopupViewModel();

  Future<dynamic> getPopupWidget(BuildContext? context) async {
    final response = await builder.getResponse;
    response.fold(
        (error) => context?.showErrorDialog(
              error,
            ), // Hata durumunda yapılacak işlemler
        (result) async {
      showPopupViewModel.customInfo = result;
      final mainTheme = await showPopupViewModel.getTheme(builder.popupTheme);
      switch (builder.popupType) {
        case PopupType.dialog:
          await context?.showCustomDialog(
            mainTheme,
            customPopupWidget: builder.customWidget,
          );
          break;
        case PopupType.bottomsheet:
          await context?.showCustomBottomSheet(
            mainTheme,
            customPopupWidget: builder.customWidget,
          );
          break;
        case PopupType.toast:
          await context?.showCustomToast(
            mainTheme,
            customPopupWidget: builder.customWidget,
          );
          break;
        default:
          await context?.showCustomDialog(
            mainTheme,
            customPopupWidget: builder.customWidget,
          );
      }
    } // Başarılı sonuçta yapılacak işlemler
        );
  }
}

class ShowPopupWidgetBuilder {
  ShowPopupViewModel showPopupViewModel = ShowPopupViewModel();

  Future<Either<String, CustomInfo>> getResponse;
  PopupTheme popupTheme = const DefaultPopupTheme();
  PopupType? popupType;
  ExceptionHandler? exceptionHandler = DefaultException();
  Widget? customWidget;

  ShowPopupWidgetBuilder({
    required this.getResponse,
  });

  ShowPopupWidgetBuilder setType(PopupType type) {
    popupType = type;
    return this;
  }

  ShowPopupWidgetBuilder setTheme(PopupTheme theme) {
    popupTheme = theme;
    return this;
  }

  ShowPopupWidgetBuilder setErrorMessage(ExceptionHandler exception) {
    exceptionHandler = exception;
    return this;
  }

  ShowPopupWidgetBuilder setCustomPopupWidget(Widget customPopupWidget) {
    customWidget = customPopupWidget;
    return this;
  }

  ShowPopupWidget build() => ShowPopupWidget(builder: this);
}

enum PopupType { dialog, bottomsheet, toast }
