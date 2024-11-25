import 'dart:async';
import 'dart:io';
import 'package:etiya_chatbot_flutter/etiya_chatbot_flutter.dart';
import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_domain/repositories/repositories.dart';
import 'package:etiya_chatbot_flutter/src/cubit/chatbot_cubit.dart';
import 'package:etiya_chatbot_flutter/src/di/setup_locator.dart';
import 'package:etiya_chatbot_flutter/src/ui/etiya_chat_widget.dart';
import 'package:etiya_chatbot_flutter/src/util/chatbot_default_theme.dart';
import 'package:etiya_chatbot_flutter/src/util/default_app_bar_theme.dart';
import 'package:etiya_chatbot_flutter/src/util/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EtiyaChatbot {
  final EtiyaChatbotBuilder builder;

  const EtiyaChatbot({
    required this.builder,
  });

  Future<Widget> getChatWidget() async {
    WidgetsFlutterBinding.ensureInitialized();
    HttpOverrides.global = MyHttpOverrides();
    return MultiRepositoryProvider(
      providers: await DependencyInjection.build(builder),
      child: BlocProvider(
        create: (context) => ChatbotCubit(
          chatbotBuilder: builder,
          socketRepository: context.read<SocketClientRepository>(),
          httpClientRepository: context.read<HttpClientRepository>(),
        ),
        child: ScreenUtilInit(
          designSize: const Size(375, 812), // Based on your design size
          minTextAdapt: true,
          builder: (context, child) {
            return CustomChatWidget(
              builder: builder,
            );
          },
        ),
      ),
    );
  }
}

class CustomChatWidget extends StatelessWidget {
  const CustomChatWidget({
    super.key,
    required this.builder,
  });

  final EtiyaChatbotBuilder builder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: builder.appBarTheme.appBarTitle,
        backgroundColor: builder.appBarTheme.appBarBackgroundColor,
        actions: context.read<ChatbotCubit>().showAppBarRefreshButton == true
            ? [
                IconButton(
                  onPressed: () {
                    final chatbotCubit = context.read<ChatbotCubit>();
                    chatbotCubit.clearSession();
                  },
                  icon: builder.appBarTheme.appBarRefreshIcon,
                ),
              ]
            : null,
      ),
      body: EtiyaChatWidget(
        builder: builder,
      ),
    );
  }
}

class EtiyaChatbotBuilder {
  /// The connection URL for messages to be sent.
  String serviceUrl;

  /// The connection URL for socket.
  String socketUrl;

  /// Behaves like unique id to distinguish chat room for backend.
  String userName;

  String? authUrl;
  String? messageInputHintText;
  int? messageInputMaxLength;
  bool? showCharacterCount;
  bool? showAppBarRefreshButton;
  bool disableInputField = false;
  UserAvatar? outgoingAvatar;
  UserAvatar? incomingAvatar;
  ChatTheme chatTheme = const ChatbotDefaultTheme();
  ChatbotAppBarTheme appBarTheme = const DefaultAppBarTheme();
  MessageData? messageData;
  String? tenantId;
  String? botId;
  ShowPopupWidget? inappPopup;

  EtiyaChatbotBuilder({
    required this.serviceUrl,
    required this.socketUrl,
    required this.userName,
  }) {
    setLoggingEnabled();
  }

  /// The connection URL for ldap authorization.
  EtiyaChatbotBuilder setAuthUrl(String url) {
    authUrl = url;
    return this;
  }

  EtiyaChatbotBuilder setShowCharacterCount({required bool showCount}) {
    showCharacterCount = showCount;
    return this;
  }

  EtiyaChatbotBuilder setDisableInputField({required bool disable}) {
    disableInputField = disable;
    return this;
  }

  EtiyaChatbotBuilder setMessageInputMaxLength(int text) {
    messageInputMaxLength = text;
    return this;
  }

  /// The hint text displayed on message input field.
  EtiyaChatbotBuilder setMessageInputHintText(String text) {
    messageInputHintText = text;
    return this;
  }

  /// Avatar configuration for incoming messages.
  EtiyaChatbotBuilder setIncomingAvatar(UserAvatar avatar) {
    incomingAvatar = avatar;
    return this;
  }

  /// Avatar configuration for outgoing messages.
  EtiyaChatbotBuilder setOutgoingAvatar(UserAvatar avatar) {
    outgoingAvatar = avatar;
    return this;
  }

  /// Chat theme for styling the Chat widget and inner elements.
  EtiyaChatbotBuilder setChatTheme(ChatTheme theme) {
    chatTheme = theme;
    return this;
  }

  EtiyaChatbotBuilder setAppBarTheme(ChatbotAppBarTheme theme) {
    appBarTheme = theme;
    return this;
  }

  /// Configuration for logging internal events, disabled by default.
  // ignore: avoid_positional_boolean_parameters
  EtiyaChatbotBuilder setLoggingEnabled([bool enabled = false]) {
    Log.isEnabled = enabled;
    return this;
  }

  EtiyaChatbotBuilder setUserVisitMessageData(MessageData data) {
    messageData = data;
    return this;
  }

  EtiyaChatbotBuilder setShowAppBarRefreshButton(
      {required bool showRefreshButton,}) {
    showAppBarRefreshButton = showRefreshButton;
    return this;
  }

  EtiyaChatbotBuilder setTenantId(String id) {
    tenantId = id;
    return this;
  }

  EtiyaChatbotBuilder setBotId(String id) {
    botId = id;
    return this;
  }

  EtiyaChatbotBuilder setPopupOptions(ShowPopupWidget popup) {
    inappPopup = popup;
    return this;
  }

  EtiyaChatbot build() => EtiyaChatbot(builder: this);
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
