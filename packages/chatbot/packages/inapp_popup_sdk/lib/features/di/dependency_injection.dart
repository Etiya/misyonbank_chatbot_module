import 'package:inapp_popup_sdk/features/inapp_popup.dart';

class DependencyInjector {
  late ShowPopupWidgetBuilder builder;
  static final DependencyInjector _singleton = DependencyInjector._internal();

  factory DependencyInjector() {
    return _singleton;
  }
  DependencyInjector._internal();
}
