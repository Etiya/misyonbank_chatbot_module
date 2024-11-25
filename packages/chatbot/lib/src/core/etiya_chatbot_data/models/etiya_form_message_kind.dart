import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/models/api/etiya_message_response.dart';

class EtiyaFormMessageKind {
  final String title;
  final List<Field> fields;

  EtiyaFormMessageKind({
    required this.title,
    required this.fields,
  });
}
