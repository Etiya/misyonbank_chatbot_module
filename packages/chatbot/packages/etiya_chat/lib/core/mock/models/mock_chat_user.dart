import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:swifty_chat/swifty_chat.dart';

class MockChatUser extends ChatUser {
  MockChatUser({
    required super.userName,
    super.avatar,
  });

  static MockChatUser incomingUser = MockChatUser(
    userName: "incoming",
    avatar: UserAvatar(
      imageProvider: const AssetImage(
        'assets/images/mock_image_avatar.png',
      ),
    ),
  );

  static MockChatUser outgoingUser = MockChatUser(userName: "outgoing");

  static MockChatUser get randomUser =>
      Random().nextBool() ? incomingUser : outgoingUser;
}
