import 'package:flutter/material.dart';
import 'package:inapp_popup_sdk/features/showpopup/presentation/widget/error_dialog_widget.dart';

extension ErrorDialogExtension on BuildContext {
  showErrorDialog(String? error) => showDialog<void>(
        context: this,
        useRootNavigator: true,
        builder: (BuildContext context) {
          return ErrorDialogWidget(
            errorText: error,
          );
        },
      );
}
