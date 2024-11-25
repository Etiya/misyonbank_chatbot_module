import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import 'package:swifty_chat/src/chat.dart';
import 'package:swifty_chat/src/extensions/theme_context.dart';
import 'package:swifty_chat/swifty_chat.dart';


final class QuickReplyWidget extends StatelessWidget {
  const QuickReplyWidget(
    this.chatMessage,
  );

  final Message chatMessage;

  @override
  Widget build(BuildContext context) {
    return chatMessage.isQuickReplyVertical
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buttons(context),
            ).padding(all: 8),
          )
        : Wrap(
            spacing: 8,
            children: _buttons(context),
          ).padding(all: 8);
  }

  List<Widget> _buttons(BuildContext context) {
    return chatMessage.messageKind.quickReplies
        .map(
          (qr) => IgnorePointer(
            ignoring: !chatMessage.canTap,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: SizedBox(
                width: chatMessage.isQuickReplyVertical ? MediaQuery.of(context).size.width / 2 : null,
                child: OutlinedButton(
                  style: context.theme.quickReplyButtonStyle,
                  onPressed: () => ChatStateContainer.of(context)
                      .onQuickReplyItemPressed
                      ?.call(qr),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(qr.title),
                  ),
                ),
              ),
            ),
          ),
        )
        .toList();
  }
}
