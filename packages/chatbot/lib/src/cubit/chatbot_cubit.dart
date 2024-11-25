import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:etiya_chatbot_flutter/etiya_chatbot_flutter.dart';
import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/models/models.dart';
import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_domain/repositories/repositories.dart';
import 'package:etiya_chatbot_flutter/src/util/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

part 'chatbot_state.dart';

class ChatbotCubit extends Cubit<ChatbotState> {
  final SocketClientRepository socketRepository;
  final HttpClientRepository httpClientRepository;
  final EtiyaChatbotBuilder chatbotBuilder;

  String get messageInputHintText =>
      chatbotBuilder.messageInputHintText ?? "Aa";

  String get tenantId =>
      chatbotBuilder.tenantId ?? "198bfb10-1fcd-11ed-861d-0242ac120002";

  String get botId =>
      chatbotBuilder.botId ?? "840489b8-1fcc-11ed-861d-0242ac120002";

  bool get disableInputField => chatbotBuilder.disableInputField;

  int get messageInputMaxLength => chatbotBuilder.messageInputMaxLength ?? 500;

  bool get showCharacterCount => chatbotBuilder.showCharacterCount ?? false;

  bool get showAppBarRefreshButton =>
      chatbotBuilder.showAppBarRefreshButton ?? false;

  String get visitorId =>
      socketRepository.query['visitorId'] as String? ?? 'Unknown visitor id';

  MessageData? get data => chatbotBuilder.messageData;

  /// Customer User
  EtiyaChatUser get _customerUser {
    final user = EtiyaChatUser(
      firstName: chatbotBuilder.userName,
    );
    user.avatar = chatbotBuilder.outgoingAvatar;
    return user;
  }

  ChatbotCubit({
    required this.chatbotBuilder,
    required this.socketRepository,
    required this.httpClientRepository,
  }) : super(const ChatbotMessages()) {
    socketRepository
      ..onEvent({
        'newMessage': (json) {
          final messageResponse =
              MessageResponse.fromJson(json as Map<String, dynamic>);
          Log.info('socketRepository.onNewMessageReceived');
          messageResponse.user?.firstName = chatbotBuilder.userName;
          messageResponse.user?.avatar = chatbotBuilder.incomingAvatar;
          Log.info(messageResponse.toJson().toString());
          if (messageResponse.type == 'feedback') {
            _insertNewMessages(
              messageResponse.mapToChatMessage(),
              response: messageResponse,
              isPopup: true,
            );
            emit(
              ChatbotSessionEnded(
                state.messages,
                messageResponse,
              ),
            );
          } else if (messageResponse.type == 'campaign-code') {
            _insertNewMessages(
              messageResponse.mapToChatMessage(),
              response: messageResponse,
              isPopup: true,
            );
            emit(
              CampaignCode(
                state.messages,
                messageResponse,
              ),
            );
          } else {
            _insertNewMessages(
              messageResponse.mapToChatMessage(),
              response: messageResponse,
            );
          }
        },
      })
      ..onError((handler) {
        if (handler is String?) {
          Log.error(handler ?? 'Error');
        } else {
          Log.error('An unexpected error occurred: $handler');
        }
      })
      ..onConnect((handler) async {
        Log.info('socketRepository.onSocketConnected (visitorId=$visitorId)');
        await _sendUserVisitMessage();
      })
      ..connect();
  }

  Future<void> _sendUserVisitMessage() async {
    await httpClientRepository.sendMessage(
      type: "user_visit",
      text: '/user_visit',
      botId: botId,
      tenantId: tenantId,
      sender: visitorId,
      user: User(
        id: visitorId,
        channel: "mobile",
      ),
      payload: ReplyPayload(),
    );
  }

  Future<void> _sendCloseSessionMessage() async {
    await httpClientRepository.sendMessage(
      type: "close_session",
      text: '/close_session',
      botId: botId,
      tenantId: tenantId,
      sender: visitorId,
      user: User(
        id: visitorId,
        channel: ":mobile",
      ),
    );
    Log.info('Chat Session is closed');
  }

  void _insertNewMessages(
    List<Message> messages, {
    MessageResponse? response,
    bool isPopup = false,
  }) {
    bool isTyping;
    isTyping = state.isTyping;

    if (response?.text == "typing") {
      isTyping = true;
    }
    if (isTyping && response?.type != "typing") {
      state.messages.removeAt(0);
      isTyping = false;
    }
    if (state.messages.isNotEmpty) {
      log(state.messages[0].messageKind.typing.toString());
    }
    List<Message>? updatedMessages;
    updatedMessages = [...state.messages];

    if (!isPopup) {
      updatedMessages.insertAll(0, messages);
      if (updatedMessages.length > 1) {
        bool foundFirstIsMe = false;
        for (int i = 0; i < updatedMessages.length; i++) {
          if (updatedMessages[i].isMe == true) {
            foundFirstIsMe = true;
          }
          if (foundFirstIsMe) {
            updatedMessages[i].canTap = false;
          }
        }
      }
    }

    emit(
      ChatbotMessages(
        messages: updatedMessages,
        isTyping: isTyping,
      ),
    );
  }

  void _cleanAllMessages() => emit(
        const ChatbotMessages(),
      );

  /// Triggered when user fills message input field.
  Future<void> userAddedMessage(String messageText) async {
    await httpClientRepository.sendMessage(
      type: "text",
      text: messageText,
      botId: botId,
      tenantId: tenantId,
      sender: visitorId,
      user: User(
        id: visitorId,
        channel: ":mobile",
      ),
    );
    _insertNewMessages(
      [
        EtiyaChatMessage(
          date: DateTime.now(),
          isMe: true,
          id: const Uuid().v1(),
          messageKind: MessageKind.text(messageText),
          chatUser: _customerUser,
        ),
      ],
    );
  }

  /// Triggered when user taps quick reply button
  void userAddedQuickReplyMessage(QuickReplyItem item) {
    httpClientRepository.sendMessage(
      type: "quick_reply",
      text: item.payload!,
      botId: botId,
      tenantId: tenantId,
      sender: visitorId,
      user: User(
        id: visitorId,
        channel: ":mobile",
      ),
    );
    _insertNewMessages([
      EtiyaChatMessage(
        date: DateTime.now(),
        isMe: true,
        id: const Uuid().v1(),
        messageKind: MessageKind.text(item.title),
        chatUser: _customerUser,
      ),
    ]);
  }

  /// Triggered when user taps date picker button
  void userAddedDateTimeMessage(
    String startDate, {
    String? endDate,
  }) {
    final date1 = formatDateWithSlash(startDate);
    String date2;
    if (endDate != null) {
      date2 = formatDateWithSlash(endDate);
    } else {
      date2 = '';
    }

    final textDate1 = formatDateWithDot(startDate);
    String textDate2;
    if (endDate != null) {
      textDate2 = formatDateWithDot(endDate);
    } else {
      textDate2 = '';
    }

    httpClientRepository.sendMessage(
      type: "date-picked",
      text: endDate == null ? textDate1 : "$textDate1 - $textDate2",
      botId: botId,
      tenantId: tenantId,
      sender: visitorId,
      user: User(
        id: visitorId,
        channel: ":mobile",
      ),
      payload: ReplyPayload(
        browserTimeZone: "Europe/Istanbul",
        browserLang: "tr-TR",
        date1: startDate,
        date2: endDate,
        dateType: endDate == null ? "single" : "range",
      ),
    );
    _insertNewMessages([
      EtiyaChatMessage(
        date: DateTime.now(),
        isMe: true,
        id: const Uuid().v1(),
        messageKind: MessageKind.text(
          endDate == null ? date1 : ("$date1 - $date2"),
        ),
        chatUser: _customerUser,
      ),
    ]);
  }

  /// Triggered when user taps carousel button
  void userAddedCarouselMessage(CarouselButtonItem item) {
    httpClientRepository.sendMessage(
      type: "text",
      text: item.payload!,
      botId: botId,
      tenantId: tenantId,
      sender: visitorId,
      user: User(
        id: visitorId,
        channel: ":mobile",
      ),
    );
    _insertNewMessages([
      EtiyaChatMessage(
        date: DateTime.now(),
        isMe: true,
        id: const Uuid().v1(),
        messageKind: MessageKind.text(item.title),
        chatUser: _customerUser,
      ),
    ]);
  }

  /// Triggered when user submits feedback
  Future<void> userSubmittedFeedbackMessage({
    required double ratingScore,
    required int sessionId,
    String? feedback,
  }) async {
    await httpClientRepository.sendMessage(
      type: "feedback",
      text: feedback ?? 'empty_text',
      botId: botId,
      tenantId: tenantId,
      sender: visitorId,
      user: User(
        id: visitorId,
        channel: ":mobile",
      ),
    );
    await clearSession();
  }

  Future<void> clearSession() async {
    _cleanAllMessages();
    await _sendCloseSessionMessage();
  }

  Future<void> authenticate({
    required String username,
    required String password,
  }) async {
    final isAuthenticated =
        await httpClientRepository.auth(username: username, password: password);
    emit(ChatbotUserAuthenticated(isAuthenticated));
    _insertNewMessages([
      EtiyaChatMessage(
        date: DateTime.now(),
        isMe: false,
        id: const Uuid().v1(),
        messageKind: MessageKind.text(
          isAuthenticated ? "Giriş Başarılı" : "Giriş Başarısız",
        ),
        chatUser: _customerUser,
      ),
    ]);
  }

  Future<void> sendForm({
    required ReplyPayload payload,
  }) async {
    await httpClientRepository.sendMessage(
      type: "form_reply",
      text: "form_reply",
      botId: botId,
      tenantId: tenantId,
      sender: visitorId,
      user: User(
        id: visitorId,
        channel: ":mobile",
      ),
      payload: payload,
      dataVisible: true,
    );
  }

  @override
  Future<void> close() async {
    socketRepository.dispose();
    await _sendCloseSessionMessage();
    return super.close();
  }
}

String formatDateWithSlash(String isoDateString) {
  // We are converting a date in ISO format to a DateTime object.
  final DateTime date = DateTime.parse(isoDateString);

  // We are creating a date in dd/MM/yyyy format using DateFormat.
  final String formattedDate = DateFormat('dd/MM/yyyy').format(date);

  return formattedDate;
}

String formatDateWithDot(String isoDateString) {
  // We are converting a date in ISO format to a DateTime object.
  final DateTime date = DateTime.parse(isoDateString);

  // We are creating a date in dd/MM/yyyy format using DateFormat.
  final String formattedDate = DateFormat('dd.MM.yyyy').format(date);

  return formattedDate;
}
