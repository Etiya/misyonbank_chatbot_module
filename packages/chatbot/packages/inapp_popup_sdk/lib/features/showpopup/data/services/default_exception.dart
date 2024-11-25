import 'package:inapp_popup_sdk/features/showpopup/data/services/exception_handler.dart';

class DefaultException extends ExceptionHandler {
  DefaultException();

  @override
  String getErrorMessage(exception) {
    String? message;

    try {
      return message = "ERROR MESSAGE";
    } catch (e) {
      return message!;
    }
  }
}
