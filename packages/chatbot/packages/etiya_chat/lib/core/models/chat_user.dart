import 'dart:core';
import 'package:swifty_chat/swifty_chat.dart';

abstract class ChatUser {
  ChatUser({required this.userName, this.avatar});

  /// Username
  final String userName;

  /// User's avatar options
  UserAvatar? avatar;
}
