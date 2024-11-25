import 'dart:developer';
import 'package:etiya_chatbot_flutter/etiya_chatbot_flutter.dart';
import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/models/api/etiya_message_request.dart';
import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/models/etiya_date_picker_message_kind.dart';
import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/models/etiya_date_range_picker_message_kind.dart';
import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/models/etiya_form_message_kind.dart';
import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/models/etiya_login_message_kind.dart';
import 'package:etiya_chatbot_flutter/src/cubit/chatbot_cubit.dart';
import 'package:etiya_chatbot_flutter/src/presentation/widgets/conversation_feedback.dart';
import 'package:etiya_chatbot_flutter/src/ui/custom_popup_widget.dart';
import 'package:etiya_chatbot_flutter/src/ui/date_picker.dart';
import 'package:etiya_chatbot_flutter/src/ui/date_range_picker.dart';
import 'package:etiya_chatbot_flutter/src/ui/etiya_message_input.dart';
import 'package:etiya_chatbot_flutter/src/ui/form_sheet.dart';
import 'package:etiya_chatbot_flutter/src/ui/image_viewer.dart';
import 'package:etiya_chatbot_flutter/src/ui/login_sheet.dart';
import 'package:etiya_chatbot_flutter/src/util/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class EtiyaChatWidget extends StatefulWidget {
  const EtiyaChatWidget({
    required this.builder,
  });

  final EtiyaChatbotBuilder builder;

  @override
  _EtiyaChatWidgetState createState() => _EtiyaChatWidgetState();
}

class _EtiyaChatWidgetState extends State<EtiyaChatWidget> {
  late Chat _chatView;
  final TextEditingController _datePickerController = TextEditingController();
  final TextEditingController _dateRangeStartController =
      TextEditingController();
  final TextEditingController _dateRangeEndController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatbotCubit, ChatbotState>(
      listener: (context, state) {
        if (state is ChatbotMessages) {
          _chatView.scrollToBottom();
        } else if (state is ChatbotSessionEnded) {
          showDialog(
            context: context,
            builder: (ctx) {
              return BlocProvider.value(
                value: context.read<ChatbotCubit>(),
                child: ConversationFeedback(
                  state.message,
                  theme: context.read<ChatTheme>(),
                ),
              );
            },
          );
        } else if (state is CampaignCode) {
          final ShowPopupWidget showPopupWidget = widget.builder.inappPopup ??
              ShowPopupWidgetBuilder(
                getResponse: InAppPopupCustomInfo().getInfo(),
              )
                  .setType(PopupType.bottomsheet)
                  .setCustomPopupWidget(
                    PopupWidget(
                      messageResponse: state.message,
                    ),
                  )
                  .build();

          showPopupWidget.getPopupWidget(context);
        }
      },
      builder: (context, state) {
        _chatView = Chat(
          messages: state.messages,
          customMessageWidget: _customWidget,
          theme: context.read<ChatTheme>(),
          messageCellSizeConfigurator:
              MessageCellSizeConfigurator.defaultConfiguration(),
          chatMessageInputField: context
                      .read<ChatbotCubit>()
                      .disableInputField ==
                  false
              ? EtiyaMessageInput(
                  sendButtonTapped: _sendButtonPressedAction,
                  hintText: context.read<ChatbotCubit>().messageInputHintText,
                  maxLength: context.read<ChatbotCubit>().messageInputMaxLength,
                  showCharacterCount:
                      context.read<ChatbotCubit>().showCharacterCount,
                )
              : Container(),
        )
            .setOnMessagePressed(_messagePressedAction)
            .setOnCarouselItemButtonPressed(_carouselPressedAction)
            .setOnQuickReplyItemPressed(_quickReplyPressedAction);
        return _chatView;
      },
    );
  }
}

extension ChatInteractions on _EtiyaChatWidgetState {
  void _sendButtonPressedAction(String text) {
    context.read<ChatbotCubit>().userAddedMessage(text);
  }

  Future<void> _messagePressedAction(Message message) async {
    final file = message.messageKind.file;
    if (file?.type == "Image") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ImageViewer(
            imageProvider: message.messageKind.file!.imageUrl!,
            closeAction: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      );
    } else if (message.messageKind.htmlData != null) {
      log("VARRRRRRRRRRRRRRRRR");
    } else {
      if (message.messageKind.file != null) {
        final uri = Uri.tryParse(message.messageKind.file!.url);
        if (uri != null && await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      }
    }
  }

  Future<void> _carouselPressedAction(CarouselButtonItem item) async {
    Log.info(item.toString());
    if (item.url != null) {
      if (await canLaunchUrlString(item.url!)) {
        await launchUrlString(item.url!);
      }
    } else if (item.payload != null) {
      context.read<ChatbotCubit>().userAddedCarouselMessage(item);
    }
  }

  void _quickReplyPressedAction(QuickReplyItem item) {
    context.read<ChatbotCubit>().userAddedQuickReplyMessage(item);
  }
}

extension CustomMessageWidget on _EtiyaChatWidgetState {
  Widget _customWidget(Message message) {
    if (message.messageKind.custom is EtiyaLoginMessageKind) {
      return _loginButton(
        message,
        buttonStyle: widget.builder.chatTheme.quickReplyButtonStyle,
      );
    }
    if (message.messageKind.custom is EtiyaDatePickerMessageKind) {
      return _datePickerButton(message);
    }
    if (message.messageKind.custom is EtiyaDateRangePickerMessageKind) {
      return _dateRangePickerButton(message);
    }
    if (message.messageKind.custom is EtiyaFormMessageKind) {
      return _formButton(
        message,
        buttonStyle: widget.builder.chatTheme.quickReplyButtonStyle,
      );
    }
    return Container();
  }

  Widget _loginButton(
    Message message, {
    required ButtonStyle buttonStyle,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 30,
      ),
      child: LoginButton(
        buttonStyle: buttonStyle,
        buttonText: (message.messageKind.custom as EtiyaLoginMessageKind).title,
        onPressed: () async {
          final formData = await showModalBottomSheet(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.7,
              maxHeight: MediaQuery.of(context).size.height * 0.75,
            ),
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            context: context,
            builder: (_) => const LoginSheet(),
          );
          debugPrint("FormData $formData");
          if (formData == null || formData is! Map) {
            return;
          }
          final String email = formData["email"] as String;
          final String password = formData["password"] as String;

          if (!mounted) return;
          context.read<ChatbotCubit>().authenticate(
                username: email,
                password: password,
              );
        },
      ),
    );
  }

  Widget _formButton(
    Message message, {
    required ButtonStyle buttonStyle,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 30,
      ),
      child: FormButton(
        buttonStyle: buttonStyle,
        buttonText: (message.messageKind.custom as EtiyaFormMessageKind).title,
        onPressed: () async {
          final formData = await showModalBottomSheet(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.7,
              maxHeight: MediaQuery.of(context).size.height * 0.75,
            ),
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            context: context,
            builder: (_) => FormSheet(
              fields:
                  (message.messageKind.custom as EtiyaFormMessageKind).fields,
            ),
          );
          debugPrint("FormData $formData");
          if (formData == null || formData is! Map) {
            return;
          }

          final List<ReplyField> field =
              formData["replyField"] as List<ReplyField>;

          if (!mounted) return;

          log(field.toString());

          context.read<ChatbotCubit>().sendForm(
                payload: ReplyPayload(
                  scope: "session",
                  field: field,
                ),
              );
        },
      ),
    );
  }

  Widget _datePickerButton(Message message) {
    return Container(
      margin: const EdgeInsets.only(
        left: 30,
        right: 130,
      ),
      child: DatePickerPopup(
        controller: _datePickerController,
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2025),
        message: message,
      ),
    );
  }

  Widget _dateRangePickerButton(Message message) {
    return Container(
      margin: const EdgeInsets.only(
        left: 30,
        right: 100,
      ),
      child: DateRangePickerPopup(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2025),
        startDateController: _dateRangeStartController,
        endDateController: _dateRangeEndController,
        message: message,
      ),
    );
  }
}

bool hasSixDigitCode(String text) {
  final RegExp sixDigitCodeRegExp = RegExp(r'\b\d{6}\b');
  return sixDigitCodeRegExp.hasMatch(text);
}
