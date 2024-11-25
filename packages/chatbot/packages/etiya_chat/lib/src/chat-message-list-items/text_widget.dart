import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import 'package:swifty_chat/src/extensions/date_extensions.dart';
import 'package:swifty_chat/src/extensions/theme_context.dart';
import 'package:swifty_chat/src/protocols/has_avatar.dart';
import 'package:swifty_chat/src/protocols/incoming_outgoing_message_widgets.dart';
import 'package:swifty_chat/swifty_chat.dart';

final class TextMessageWidget extends StatelessWidget
    with HasAvatar, IncomingOutgoingMessageWidgets {
  TextMessageWidget(this._chatMessage);

  final Message _chatMessage;

  @override
  Widget incomingMessageWidget(BuildContext context) => Row(
        crossAxisAlignment: avatarPosition.alignment,
        children: [
          ...avatarWithPadding(),
          _DecoratedText(message: message).flexible(),
          const SizedBox(width: 24)
        ],
      );

  @override
  Widget outgoingMessageWidget(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: avatarPosition.alignment,
        children: [
          const SizedBox(width: 24),
          _DecoratedText(message: message).flexible(),
          ...avatarWithPadding(),
        ],
      );

  @override
  Widget build(BuildContext context) => message.isMe
      ? outgoingMessageWidget(context)
      : incomingMessageWidget(context);

  @override
  Message get message => _chatMessage;
}

final class _DecoratedText extends StatelessWidget {
  const _DecoratedText({required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final messageBorderRadius = theme.messageBorderRadius;

    final borderRadius = BorderRadius.only(
      bottomLeft: Radius.circular(message.isMe ? messageBorderRadius : 0),
      bottomRight: Radius.circular(message.isMe ? 0 : messageBorderRadius),
      topLeft: Radius.circular(messageBorderRadius),
      topRight: Radius.circular(messageBorderRadius),
    );

    final timeTextPainter = TextPainter(
      text: TextSpan(
        text: message.date.relativeTimeFromNow(),
        style: message.isMe
            ? theme.outgoingChatTextTime
            : theme.incomingChatTextTime,
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final minBubbleWidth = timeTextPainter.width + 24;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: message.isMe ? theme.primaryColor : theme.secondaryColor,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: minBubbleWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: borderRadius,
              child: Text(
                message.messageKind.text!,
                softWrap: true,
                style: message.isMe
                    ? theme.outgoingMessageBodyTextStyle
                    : theme.incomingMessageBodyTextStyle,
              ).padding(all: theme.textMessagePadding),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 12,
                bottom: 6,
              ),
              child: Text(
                message.date.relativeTimeFromNow(),
                style: message.isMe
                    ? theme.outgoingChatTextTime
                    : theme.incomingChatTextTime,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
