import 'package:swifty_chat/swifty_chat.dart';

class MockMessage extends Message {
  MockMessage({
    required super.user,
    required super.id,
    required super.isMe,
    required super.date,
    required super.messageKind,
    super.canTap = true,
  });
}
