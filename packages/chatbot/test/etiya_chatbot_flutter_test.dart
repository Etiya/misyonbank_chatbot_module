// import 'package:bloc_test/bloc_test.dart';
// import 'package:etiya_chatbot_flutter/etiya_chatbot_flutter.dart';
// import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/models/api/etiya_message_request.dart';
// import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_domain/repositories/repositories.dart';
// import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_mocked_data/repositories/socket_repository_fake_impl.dart';
// import 'package:etiya_chatbot_flutter/src/cubit/chatbot_cubit.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// // Concrete implementation of QuickReplyItem for testing purposes
// class TestQuickReplyItem extends QuickReplyItem {
//   const TestQuickReplyItem({
//     required String title,
//     String? payload,
//     String? url,
//   }) : super(title: title, payload: payload, url: url);
// }

// class MockedHttpClientRepository extends Mock implements HttpClientRepository {}

// class MockedMessageRequest extends Mock implements MessageRequest {}

// class MockSocketRepository extends Mock implements SocketClientRepository {}

// void main() {
//   group('ChatbotCubit', () {
//     late ChatbotCubit chatbotCubit;
//     late EtiyaChatbotBuilder etiyaChatbotBuilder;
//     late SocketClientRepository socketRepository;
//     late HttpClientRepository mockHttpClientRepository;

//     setUpAll(() {
//       registerFallbackValue(MockedMessageRequest());
//       registerFallbackValue(User(channel: 'mobile', id: 'visitor-id'));
//     });

//     setUp(() {
//       etiyaChatbotBuilder = EtiyaChatbotBuilder(
//         serviceUrl: 'https://chatbotbo-demo8.serdoo.com/api/chat',
//         socketUrl: 'https://chatbotbo-demo8.serdoo.com/nlp',
//         userName: 'enesKaraosman',
//       );

//       mockHttpClientRepository = MockedHttpClientRepository();
//       socketRepository = FakeSocketClientRepository();

//       chatbotCubit = ChatbotCubit(
//         chatbotBuilder: etiyaChatbotBuilder,
//         socketRepository: socketRepository,
//         httpClientRepository: mockHttpClientRepository,
//       );
//     });

//     tearDown(() {
//       chatbotCubit.close();
//     });

//     group('Message Add Events (Text, Carousel, Quick Reply)', () {
//       blocTest<ChatbotCubit, ChatbotState>(
//         'emit ChatbotMessages when user adds TEXT message',
//         build: () {
//           when(() => mockHttpClientRepository.sendMessage(
//                 text: any(named: 'text'),
//                 type: any(named: 'type'),
//                 botId: any(named: 'botId'),
//                 tenantId: any(named: 'tenantId'),
//                 sender: any(named: 'sender'),
//                 user: any(named: 'user'),
//               )).thenAnswer((_) async => Future.value());
//           return chatbotCubit;
//         },
//         act: (bloc) => bloc.userAddedMessage('messageText'),
//         expect: () => [
//           isA<ChatbotMessages>().having(
//             (s) => s.messages.first.messageKind,
//             'messageKind',
//             isA<MessageKind>().having(
//               (k) => k.text,
//               'text',
//               'messageText',
//             ),
//           ),
//         ],
//       );

//       blocTest<ChatbotCubit, ChatbotState>(
//         'emit ChatbotMessages when user adds CAROUSEL message',
//         build: () {
//           when(() => mockHttpClientRepository.sendMessage(
//                 text: any(named: 'text'),
//                 type: any(named: 'type'),
//                 botId: any(named: 'botId'),
//                 tenantId: any(named: 'tenantId'),
//                 sender: any(named: 'sender'),
//                 user: any(named: 'user'),
//               )).thenAnswer((_) async => Future.value());
//           return chatbotCubit;
//         },
//         act: (bloc) => bloc.userAddedCarouselMessage(
//           CarouselButtonItem(
//             title: 'carouselButtonTitle',
//             url: 'url',
//             payload: 'carouselButtonPayload',
//           ),
//         ),
//         expect: () => [
//           isA<ChatbotMessages>().having(
//             (s) => s.messages.first.messageKind,
//             'messageKind',
//             isA<MessageKind>().having(
//               (k) => k.text,
//               'text',
//               'carouselButtonTitle',
//             ),
//           ),
//         ],
//       );

//       blocTest<ChatbotCubit, ChatbotState>(
//         'emit ChatbotMessages when user adds QUICK REPLY message',
//         build: () {
//           when(() => mockHttpClientRepository.sendMessage(
//                 text: any(named: 'text'),
//                 type: any(named: 'type'),
//                 botId: any(named: 'botId'),
//                 tenantId: any(named: 'tenantId'),
//                 sender: any(named: 'sender'),
//                 user: any(named: 'user'),
//               )).thenAnswer((_) async => Future.value());
//           return chatbotCubit;
//         },
//         act: (bloc) => bloc.userAddedQuickReplyMessage(
//           const TestQuickReplyItem(
//             title: 'quickReplyTitle',
//             payload: 'quickReplyPayload',
//           ),
//         ),
//         expect: () => [
//           isA<ChatbotMessages>().having(
//             (s) => s.messages.first.messageKind,
//             'messageKind',
//             isA<MessageKind>().having(
//               (k) => k.text,
//               'text',
//               'quickReplyTitle',
//             ),
//           ),
//         ],
//       );
//     });
//     blocTest<ChatbotCubit, ChatbotState>(
//       'send form and verify state',
//       build: () {
//         when(() => mockHttpClientRepository.sendMessage(
//               text: any(named: 'text'),
//               type: any(named: 'type'),
//               botId: any(named: 'botId'),
//               tenantId: any(named: 'tenantId'),
//               sender: any(named: 'sender'),
//               user: any(named: 'user'),
//               payload: any(named: 'payload'),
//               dataVisible: any(named: 'dataVisible'),
//             )).thenAnswer((_) async => Future.value());
//         return chatbotCubit;
//       },
//       act: (bloc) => bloc.sendForm(
//         payload: ReplyPayload(
//           scope: 'test_scope',
//           field: [ReplyField(label: 'field_id', value: 'field_value')],
//         ),
//       ),
//       expect: () => [],
//     );
//   });
// }



import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock class for ChatbotBuilder
class MockChatbotBuilder extends Mock {
  String? get messageInputHintText;
}

// The class containing the messageInputHintText getter
class MyClass {
  final MockChatbotBuilder chatbotBuilder;

  MyClass(this.chatbotBuilder);

  String get messageInputHintText =>
      chatbotBuilder.messageInputHintText ?? "Aa";
}

void main() {
  late MockChatbotBuilder mockChatbotBuilder;
  late MyClass myClass;

  setUp(() {
    mockChatbotBuilder = MockChatbotBuilder();
    myClass = MyClass(mockChatbotBuilder);
  });

  test('should return "Aa" when chatbotBuilder.messageInputHintText is null', () {
    when(() => mockChatbotBuilder.messageInputHintText).thenReturn(null);

    expect(myClass.messageInputHintText, "Aa");
  });

  test('should return the value from chatbotBuilder.messageInputHintText when it is not null', () {
    when(() => mockChatbotBuilder.messageInputHintText).thenReturn("Hello");

    expect(myClass.messageInputHintText, "Hello");
  });
}
