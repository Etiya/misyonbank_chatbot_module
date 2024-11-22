import 'dart:convert';
import 'package:etiya_chatbot_flutter/etiya_chatbot_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Etiya Chatbot',
      home: InitialScreen(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}

class InitialScreen extends StatelessWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MyHomePage(),
              ),
            );
          },
          child: const Text("Open Chatbot"),
        ),
      ),
    );
  }
}

class CustomChatbotTheme extends ChatTheme {
  const CustomChatbotTheme() : super();

  final Color toggPrimary = const Color(0xFFF2F2F2);
  final Color toggSecondary = const Color(0xFF7368F4);

  @override
  Color get backgroundColor => neutral7;

  @override
  double get messageBorderRadius => 20;

  @override
  double get textMessagePadding => 12;

  @override
  Color get primaryColor => toggSecondary;

  @override
  TextStyle get incomingMessageBodyTextStyle => TextStyle(
        fontFamily: 'Fedra-Sans-Std',
        fontSize: 17,
        color: Colors.grey.shade900,
      );

  @override
  TextStyle get outgoingMessageBodyTextStyle => const TextStyle(
        fontFamily: 'Fedra-Sans-Std',
        fontSize: 17,
        color: Colors.white,
      );

  @override
  Color get secondaryColor => toggPrimary;

  @override
  EdgeInsets get messageInset => const EdgeInsets.symmetric(vertical: 8);

  @override
  TextStyle get carouselTitleTextStyle =>
      const TextStyle(fontFamily: 'Fedra-Sans-Std', fontSize: 19);

  @override
  TextStyle get carouselSubtitleTextStyle =>
      const TextStyle(fontFamily: 'Fedra-Sans-Std', fontSize: 17);

  @override
  ButtonStyle get carouselButtonStyle => ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(toggSecondary),
        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
      );

  @override
  BoxDecoration get carouselBoxDecoration => BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFFF2F2F2),
      );

  @override
  ButtonStyle get quickReplyButtonStyle => ButtonStyle(
        shape: WidgetStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        foregroundColor: WidgetStateProperty.all<Color>(toggSecondary),
        textStyle: WidgetStateProperty.all<TextStyle>(
          TextStyle(
            fontWeight: FontWeight.bold,
            color: toggSecondary,
          ),
        ),
      );

  @override
  Color get htmlTextColor => Colors.blueAccent;

  @override
  String? get htmlTextFontFamily => 'Avenir';

  @override
  BorderRadius get imageBorderRadius => BorderRadius.circular(10);

  @override
  TextStyle get htmlWidgetTextTime => const TextStyle(
        fontFamily: 'Fedra-Sans-Std',
        fontSize: 12,
      );

  @override
  TextStyle get imageWidgetTextTime => const TextStyle(
        fontFamily: 'Fedra-Sans-Std',
        fontSize: 12,
        color: Colors.white,
      );

  @override
  TextStyle get incomingChatTextTime => TextStyle(
        fontFamily: 'Fedra-Sans-Std',
        fontSize: 12,
        color: Colors.grey.shade900,
      );
  @override
  TextStyle get outgoingChatTextTime => const TextStyle(
        fontFamily: 'Fedra-Sans-Std',
        fontSize: 12,
        color: Colors.white,
      );
}

class CustomAppBarTheme extends ChatbotAppBarTheme {
  @override
  Color get appBarBackgroundColor => const Color(0xff242441);

  @override
  Icon get appBarRefreshIcon => const Icon(
        Icons.refresh,
        color: Colors.white,
      );

  @override
  Widget? get appBarTitle => const Text(
        "Chatbot",
        style: TextStyle(
          color: Colors.white,
        ),
      );
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  final EtiyaChatbot etiyaChatbot = EtiyaChatbotBuilder(
    serviceUrl: 'service_url',
    socketUrl: 'socket_url',
    userName: 'username',
  )
      .setLoggingEnabled(true)
      .setChatTheme(const CustomChatbotTheme())
      .setAppBarTheme(CustomAppBarTheme())
      .setTenantId("tenant_id")
      .setBotId("bot_id")
      .setAuthUrl('https://chatbotosb-demo8.serdoo.com/api/auth')
      .setMessageInputHintText("Hint text")
      .setMessageInputMaxLength(50)
      .setShowCharacterCount(showCount: true)
      .setShowAppBarRefreshButton(showRefreshButton: true)
      .setUserVisitMessageData(MessageData())
      .build();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.etiyaChatbot.getChatWidget(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data! as Widget;
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

final ShowPopupWidget showPopupWidget = ShowPopupWidgetBuilder(
  getResponse: GetInfo().getInfo(),
).setType(PopupType.bottomsheet).build();

class GetInfo implements ServiceRepository {
  @override
  Future<Either<String, CustomInfo>> getInfo() async {
    try {
      final response = await http.get(
        Uri.parse("http://localhost:3000/info"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      final result = CustomInfo.fromMap(json.decode(response.body));
      return Right(result);
    } catch (e) {
      return const Left("");
    }
  }
}
