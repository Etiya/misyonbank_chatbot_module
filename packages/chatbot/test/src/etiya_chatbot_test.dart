// import 'package:etiya_chatbot_flutter/etiya_chatbot_flutter.dart';
// import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_domain/repositories/repositories.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// class MockChatTheme extends Mock implements ChatTheme {}

// class MockSocketClientRepository extends Mock
//     implements SocketClientRepository {}

// class MockHttpClientRepository extends Mock implements HttpClientRepository {}

// final mockChatTheme = MockChatTheme();
// void main() {
//   group(
//     "Test",
//     () {
//       test('EtiyaChatbotBuilder has correct properties', () async {
//         final EtiyaChatbotBuilder builder = EtiyaChatbotBuilder(
//           serviceUrl: "test_service_url",
//           socketUrl: "test_socket_url",
//           userName: "test_user_name",
//         );
//         builder.setAuthUrl("test_auth_url");
//         builder.setMessageInputHintText("test_input_hint");
//         builder.setMessageInputMaxLength(10);
//         builder.setShowCharacterCount(true);
//         builder.setIncomingAvatar(
//           UserAvatar(
//             imageProvider: const NetworkImage(
//               "https://upload.wikimedia.org/wikipedia/commons/7/70/Example.png",
//             ),
//           ),
//         );
//         builder.setOutgoingAvatar(
//           UserAvatar(
//             imageProvider: const NetworkImage(
//               "https://upload.wikimedia.org/wikipedia/commons/7/70/Example.png",
//             ),
//           ),
//         );
//         builder.setChatTheme(mockChatTheme);

//         expect(builder.authUrl, "test_auth_url");
//         expect(builder.messageInputHintText, "test_input_hint");
//         expect(builder.messageInputMaxLength, 10);
//         expect(builder.showCharacterCount, true);
//         expect(builder.incomingAvatar, isA<UserAvatar>());
//         expect(builder.outgoingAvatar, isA<UserAvatar>());
//         expect(builder.chatTheme, isA<ChatTheme>());
//       });
//       test('EtiyaChatbot build method test', () {
//         final etiyaChatbotBuilder = EtiyaChatbotBuilder(
//           serviceUrl: 'https://service.url',
//           socketUrl: 'https://socket.url',
//           userName: 'testUser',
//         );

//         final etiyaChatbot = etiyaChatbotBuilder.build();

//         expect(etiyaChatbot.builder, etiyaChatbotBuilder);
//       });

//       TestWidgetsFlutterBinding.ensureInitialized();

//       test('Test Etiya Chatbot Widget', () async {
//         final etiyaChatbotBuilder = EtiyaChatbotBuilder(
//           serviceUrl: 'https://service.url',
//           socketUrl: 'https://socket.url',
//           userName: 'testUser',
//         );
//         await Future.delayed(const Duration(seconds: 3));
//         final etiyaChatbot = etiyaChatbotBuilder.build();
//         final widget = etiyaChatbot.getChatWidget();
//         expect(widget, isNotNull);
//       });
//     },
//   );
// }
void main() {
  
}
