class MessageRequest {
  String botId;
  String tenantId;
  String sender;
  String type;
  String text;
  User user;
  ReplyPayload? replyPayload;
  bool? dataVisible;

  MessageRequest({
    required this.botId,
    required this.tenantId,
    required this.sender,
    required this.type,
    required this.text,
    required this.user,
    this.dataVisible,
    this.replyPayload,
  });

  factory MessageRequest.fromJson(Map<String, dynamic> json) => MessageRequest(
        dataVisible: json["dataVisible"] as bool?,
        botId: json["botId"] as String,
        tenantId: json["tenantId"] as String,
        sender: json["sender"] as String,
        type: json["type"] as String,
        text: json["text"] as String,
        user: User.fromJson(json["user"] as Map<String, dynamic>),
        replyPayload:
            ReplyPayload.fromJson(json["payload"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        "dataVisible": dataVisible,
        "botId": botId,
        "tenantId": tenantId,
        "sender": sender,
        "type": type,
        "text": text,
        "user": user.toJson(),
        "payload": replyPayload,
      };
}

class User {
  String id;
  String channel;
  String? firstName;
  String? lastName;

  User({
    required this.id,
    required this.channel,
    this.firstName,
    this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] as String,
        channel: json["channel"] as String,
        firstName: json["firstName"] as String,
        lastName: json["lastName"] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "channel": channel,
        "firstName": firstName,
        "lastName": lastName,
      };
}

class ReplyPayload {
  String? scope;
  List<ReplyField>? field;
  String? browserTimeZone;
  String? browserLang;
  String? date1;
  String? date2;
  String? dateType;

  ReplyPayload({
    this.scope,
    this.field,
    this.browserLang,
    this.browserTimeZone,
    this.date1,
    this.date2,
    this.dateType,
  });

  factory ReplyPayload.fromJson(Map<String, dynamic> json) => ReplyPayload(
        scope: json["scope"] as String,
        browserTimeZone: json["browserTimeZone"] as String,
        browserLang: json["browserLang"] as String,
        date1: json["date1"] as String,
        date2: json["date2"] as String,
        dateType: json["dateType"] as String,
        field: (json["field"] as List<dynamic>?)
            ?.map(
              (x) => ReplyField.fromJson(x as Map<String, dynamic>),
            )
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "scope": scope,
        "field": field,
        "browserTimeZone": browserTimeZone,
        "browserLang": browserLang,
        "date1": date1,
        "date2": date2,
        "dateType": dateType,
      };
}

class ReplyField {
  String? label;
  dynamic value;

  ReplyField({
    this.label,
    required this.value,
  });

  factory ReplyField.fromJson(Map<String, dynamic> json) => ReplyField(
        label: json["label"] as String?,
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "value": value,
      };
}
