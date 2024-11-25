part of 'chatbot_cubit.dart';

abstract class ChatbotState extends Equatable {
  const ChatbotState({
    this.messages = const [],
    this.isTyping = false,
  });

  final List<Message> messages;
  final bool isTyping;

  @override
  List<Object?> get props => [
        messages,
        isTyping,
      ];
}

class ChatbotMessages extends ChatbotState {
  const ChatbotMessages({
    super.messages,
    super.isTyping,
  });
}

class ChatbotUserAuthenticated extends ChatbotState {
  // ignore: avoid_positional_boolean_parameters
  const ChatbotUserAuthenticated(this.isAuthenticated);

  final bool isAuthenticated;

  @override
  List<Object?> get props => [
        messages,
        isAuthenticated,
        isTyping,
      ];
}

class ChatbotSessionEnded extends ChatbotState {
  const ChatbotSessionEnded(
    List<Message> messages,
    this.message,
  ) : super(
          messages: messages,
        );

  final MessageResponse message;

  @override
  List<Object?> get props => [
        messages,
        message,
        isTyping,
      ];
}

class CampaignCode extends ChatbotState {
  const CampaignCode(
    List<Message> messages,
    this.message,
  ) : super(
          messages: messages,
        );

  final MessageResponse message;

  @override
  List<Object?> get props => [
        messages,
        message,
        isTyping,
      ];
}
