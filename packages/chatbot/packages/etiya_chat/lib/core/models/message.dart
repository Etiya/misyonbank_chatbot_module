import 'package:equatable/equatable.dart';
import 'package:swifty_chat/swifty_chat.dart';

abstract class Message extends Equatable {
  Message({
    required this.user,
    required this.id,
    required this.isMe,
    required this.messageKind,
    required this.date,
    this.canTap = true,
    this.isQuickReplyVertical = false,
  });

  final ChatUser user;
  final String id;
  final bool isMe;
  final MessageKind messageKind;
  final DateTime date;
  bool canTap;
  bool isQuickReplyVertical;

  @override
  List<Object?> get props => [id];
}
