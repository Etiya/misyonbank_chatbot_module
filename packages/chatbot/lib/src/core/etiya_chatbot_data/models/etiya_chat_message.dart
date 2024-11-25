import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/models/api/etiya_message_response.dart';
import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/models/etiya_carousel_item.dart';
import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/models/etiya_date_picker_message_kind.dart';
import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/models/etiya_date_range_picker_message_kind.dart';
import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/models/etiya_form_message_kind.dart';
import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/models/etiya_login_message_kind.dart';
import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/models/etiya_quick_reply.dart';
import 'package:flutter/material.dart';
import 'package:swifty_chat/swifty_chat.dart';

extension CheckHTMLExist on String {
  bool get containsHTML {
    return contains(RegExp(r'<\/?[a-z][\s\S]*>'));
  }
}

class EtiyaChatMessage extends Message {
  final EtiyaChatUser chatUser;

  EtiyaChatMessage({
    required this.chatUser,
    required super.id,
    required super.isMe,
    required super.date,
    required super.messageKind,
    super.canTap,
  }) : super(user: chatUser);
}

extension MessageMapper on MessageResponse {
  List<EtiyaChatMessage> mapToChatMessage() {
    final List<EtiyaChatMessage> messages = [];
    final msgId = id.toString();
    final EtiyaChatUser msgUser = user ?? EtiyaChatUser();
    final date = (createdAt ?? DateTime.now()).toLocal();

    switch (type) {
      case 'login':
        messages.add(
          EtiyaChatMessage(
            id: msgId,
            isMe: false,
            chatUser: msgUser,
            date: date,
            messageKind: MessageKind.custom(
              EtiyaLoginMessageKind(title: text ?? 'Login'),
            ),
          ),
        );
      case 'form':
        final formFields = payload?.fields ?? [];
        messages.add(
          EtiyaChatMessage(
            id: msgId,
            isMe: false,
            chatUser: msgUser,
            date: date,
            messageKind: MessageKind.custom(
              EtiyaFormMessageKind(
                title: text ?? 'Form',
                fields: formFields,
              ),
            ),
          ),
        );
      case 'date-picker':
        messages.add(
          EtiyaChatMessage(
            id: msgId,
            isMe: false,
            chatUser: msgUser,
            date: date,
            messageKind: MessageKind.custom(
              payload?.dateType == "single"
                  ? EtiyaDatePickerMessageKind(
                      title: text ?? 'Date Picker',
                    )
                  : EtiyaDateRangePickerMessageKind(
                      title: text ?? 'Date Range Picker',
                    ),
            ),
          ),
        );
      case 'single-choice':
        if (hasQuickReply) {
          Future<void> quick(List<EtiyaQuickReplyItem>? items) async {
            messages.add(
              EtiyaChatMessage(
                id: msgId,
                isMe: false,
                chatUser: msgUser,
                date: date,
                messageKind: MessageKind.quickReply(items!),
              ),
            );
          }

          final quickReplies = payload?.choices ?? [];
          final List<EtiyaQuickReplyItem> items = quickReplies
              .map(
                (qr) => EtiyaQuickReplyItem(
                  title: qr.title ?? "",
                  payload: qr.value ?? "unknown_payload",
                ),
              )
              .toList();
          if (text != null) {
            MessageKind kind = MessageKind.text(text);
            if (text!.containsHTML) {
              kind = MessageKind.html(text);
            }
            messages.add(
              EtiyaChatMessage(
                id: msgId,
                isMe: false,
                chatUser: msgUser,
                date: date,
                messageKind: kind,
              ),
            );
          }

          quick(items);
        } else {
          if (text != null) {
            MessageKind kind = MessageKind.text(text);
            if (text!.containsHTML) {
              kind = MessageKind.html(text);
            }
            messages.add(
              EtiyaChatMessage(
                id: msgId,
                isMe: false,
                chatUser: msgUser,
                date: date,
                messageKind: kind,
              ),
            );
          }
        }
      case 'typing':
        if (text != null) {
          messages.add(
            EtiyaChatMessage(
              id: msgId,
              isMe: false,
              chatUser: msgUser,
              date: date,
              messageKind: MessageKind.typing(type),
            ),
          );
        }
      case 'text':
        if (text != null) {
          MessageKind kind = MessageKind.text(text);
          if (text!.containsHTML) {
            kind = MessageKind.html(text);
          }
          messages.add(
            EtiyaChatMessage(
              id: msgId,
              isMe: false,
              chatUser: msgUser,
              date: date,
              messageKind: kind,
            ),
          );
        }
      case 'carousel':
        final items = payload?.items ?? [];
        if (items.isEmpty) {
          break;
        }

        final List<EtiyaCarouselItem> carouselItems = items.map((e) {
          final title = e.title ?? '';
          final subtitle = e.subtitle ?? '';
          final url = e.picture;
          final buttons = e.buttons ?? [];

          final List<CarouselButtonItem> carouselButtons = buttons.map((btn) {
            return CarouselButtonItem(
              title: btn.title ?? '',
              url: btn.value,
              payload: btn.value,
            );
          }).toList();

          return EtiyaCarouselItem(
            title: title,
            subtitle: subtitle,
            imageProvider: NetworkImage(url ?? ""),
            buttons: carouselButtons,
          );
        }).toList();

        messages.add(
          EtiyaChatMessage(
            chatUser: msgUser,
            id: msgId,
            isMe: false,
            date: date,
            messageKind: MessageKind.carousel(carouselItems),
          ),
        );

      case 'file':
        if (hasImage) {
          final String? url = payload?.url;
          if (url == null) break;
          messages.add(
            EtiyaChatMessage(
              id: msgId,
              isMe: false,
              chatUser: msgUser,
              date: date,
              messageKind: MessageKind.file(
                FileData(
                  url: url,
                  imageUrl: NetworkImage(
                    url,
                  ),
                  mime: payload!.mime!,
                  type: payload!.type!,
                  subText: payload!.subText!,
                ),
              ),
            ),
          );
        }
    }

    return messages.reversed.toList();
  }
}
