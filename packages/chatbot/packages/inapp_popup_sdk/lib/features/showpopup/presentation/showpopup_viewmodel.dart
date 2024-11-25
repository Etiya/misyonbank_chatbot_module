import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:inapp_popup_sdk/features/showpopup/data/models/custom_info.dart';
import 'package:inapp_popup_sdk/features/theme/json_theme.dart';
import 'package:inapp_popup_sdk/features/theme/popup_theme.dart';

class ShowPopupViewModel with ChangeNotifier {
  CustomInfo _customInfo = CustomInfo();

  CustomInfo get customInfo => _customInfo;
  set customInfo(CustomInfo value) {
    _customInfo = value;
    notifyListeners();
  }

  Future<PopupTheme> getTheme(PopupTheme popupTheme1) async {
    PopupTheme popupTheme = popupTheme1;
    try {
      if (customInfo.themeInfo == true) {
        popupTheme = JsonPopupTheme(customInfo);
      }
    } catch (e, stackTrace) {
      log(e.toString(), stackTrace: stackTrace);
      rethrow;
    }
    return popupTheme;
  }
}
