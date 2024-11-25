import 'package:swifty_chat/swifty_chat.dart';

class MessageResponse {
  MessageResponse({
    this.id,
    this.tenantId,
    this.botId,
    this.sessionId,
    this.sender,
    this.receiver,
    this.channel,
    this.type,
    this.text,
    this.direction,
    this.payload,
    this.extras,
    this.createdAt,
    this.session,
    this.user,
  });

  int? id;
  String? tenantId;
  String? botId;
  String? sessionId;
  String? sender;
  String? receiver;
  String? channel;
  String? type;
  String? text;
  String? direction;
  Payload? payload;
  Extras? extras;
  DateTime? createdAt;
  Session? session;
  EtiyaChatUser? user;

  factory MessageResponse.fromJson(Map<String, dynamic> json) =>
      MessageResponse(
        id: json["id"] as int?,
        tenantId: json["tenantId"] as String?,
        botId: json["botId"] as String?,
        sessionId: json["sessionId"] as String?,
        sender: json["sender"] as String?,
        receiver: json["receiver"] as String?,
        channel: json["channel"] as String?,
        type: json["type"] as String?,
        text: json["text"] as String?,
        direction: json["direction"] as String?,
        payload: json["payload"] == null
            ? null
            : Payload.fromJson(json["payload"] as Map<String, dynamic>),
        extras: json["extras"] == null
            ? null
            : Extras.fromJson(json["extras"] as Map<String, dynamic>),
        createdAt: DateTime.parse(json["createdAt"] as String),
        session: json["session"] == null
            ? null
            : Session.fromJson(json["session"] as Map<String, dynamic>),
        user: json["user"] == null
            ? null
            : EtiyaChatUser.fromJson(json["user"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tenantId": tenantId,
        "botId": botId,
        "sessionId": sessionId,
        "sender": sender,
        "receiver": receiver,
        "channel": channel,
        "type": type,
        "text": text,
        "direction": direction,
        "payload": payload,
        "extras": extras,
        "createdAt": createdAt,
        "session": session,
        "user": user,
      };

  bool get hasQuickReply {
    final qrCount = payload?.choices?.length ?? 0;
    return type == 'single-choice' && qrCount != 0;
  }

  bool get hasImage {
    // final mimeType = rawMessage?.data?.payload?.mime;
    return type == 'file'; // && mimeType.contains("image")
  }
}

class Extras {
  dynamic accessToken;

  Extras({
    this.accessToken,
  });

  factory Extras.fromJson(Map<String, dynamic> json) => Extras(
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
      };
}

// MARK: - Element 👍🏻
// class Element {
//   Element({this.title, this.buttons, this.picture, this.subtitle});

//   String? title;
//   List<CarouselButton>? buttons;
//   String? picture;
//   String? subtitle;

//   factory Element.fromJson(Map<String, dynamic> json) => Element(
//         title: json["title"] as String?,
//         buttons: json["buttons"] == null
//             ? null
//             : List<CarouselButton>.from(
//                 json["buttons"].map(
//                   (x) => CarouselButton.fromJson(x as Map<String, dynamic>),
//                 ) as Iterable,
//               ),
//         picture: json["picture"] as String?,
//         subtitle: json["subtitle"] as String?,
//       );

//   Map<String, dynamic> toJson() => {
//         "title": title,
//         "buttons": buttons,
//         "picture": picture,
//         "subtitle": subtitle,
//       };

//   @override
//   toString() => toJson().toString();
// }

class EmojiName {
  String? title;
  String? value;

  EmojiName({
    this.title,
    this.value,
  });

  factory EmojiName.fromJson(Map<String, dynamic> json) => EmojiName(
        title: json["title"] as String?,
        value: json["value"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "value": value,
      };
}

// MARK: - CarouselButton 👍🏻
class CarouselButton {
  CarouselButton({
    this.type,
    this.title,
    this.value,
    this.config,
  });

  String? type;
  String? title;
  String? value;
  Config? config;

  factory CarouselButton.fromJson(Map<String, dynamic> json) => CarouselButton(
        type: json["type"] as String?,
        title: json["title"] as String?,
        value: json["value"] as String?,
        config: json["config"] == null
            ? null
            : Config.fromJson(json["config"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "title": title,
        "value": value,
        "config": config,
      };
}

// MARK: - QuickReply 👍🏻
class QuickReply {
  QuickReply({this.title, this.payload});

  String? title;
  String? payload;

  factory QuickReply.fromJson(Map<String, dynamic> json) => QuickReply(
        title: json["title"] as String?,
        payload: json["payload"] as String?,
      );

  Map<String, dynamic> toJson() => {"title": title, "payload": payload};
}

class Payload {
  bool? typing;
  List<Item>? items;
  List<Choice>? choices;
  String? thank;
  String? sessionId;
  List<EmojiName>? emojiNames;
  String? placeHolder;
  String? denyButtonText;
  String? sendButtonText;
  String? from;
  bool? feedbackExist;
  String? rate;
  String? comment;
  String? text;
  String? scope;
  String? colors;
  String? defaultColor;
  String? name;
  bool? isColorpicker;
  String? colorid;
  String? url;
  String? mime;
  String? type;
  String? subText;
  List<Field>? fields;
  bool? closable;
  bool? clickandopen;
  String? showFormText;
  String? feedbackMessage;
  String? confirmationText;
  String? formThankDuration;
  bool? showDataAfterSubmit;
  String? dateType;
  List<dynamic>? enabledDates;
  List<dynamic>? disabledDates;
  String? dateDisplayOption;
  String? header;
  String? content;
  bool? feedback;
  bool? showPopup;
  String? subHeader;
  String? annotation;
  String? buttonText;

  Payload({
    required this.typing,
    this.choices,
    this.items,
    this.thank,
    this.sessionId,
    this.emojiNames,
    this.placeHolder,
    this.denyButtonText,
    this.sendButtonText,
    this.from,
    this.feedbackExist,
    this.rate,
    this.comment,
    this.text,
    this.scope,
    this.colors,
    this.defaultColor,
    this.name,
    this.isColorpicker,
    this.colorid,
    this.url,
    this.mime,
    this.type,
    this.subText,
    this.fields,
    this.closable,
    this.clickandopen,
    this.showFormText,
    this.feedbackMessage,
    this.confirmationText,
    this.formThankDuration,
    this.showDataAfterSubmit,
    this.dateDisplayOption,
    this.dateType,
    this.disabledDates,
    this.enabledDates,
    this.annotation,
    this.buttonText,
    this.content,
    this.feedback,
    this.header,
    this.showPopup,
    this.subHeader,
  });

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        typing: json["typing"] as bool?,
        choices: (json["choices"] as List<dynamic>?)
            ?.map(
              (x) => Choice.fromJson(x as Map<String, dynamic>),
            )
            .toList(),
        items: (json["items"] as List<dynamic>?)
            ?.map(
              (x) => Item.fromJson(x as Map<String, dynamic>),
            )
            .toList(),
        thank: json["thank"] as String?,
        sessionId: json["sessionId"] as String?,
        emojiNames: (json["emojiNames"] as List<dynamic>?)
            ?.map(
              (x) => EmojiName.fromJson(x as Map<String, dynamic>),
            )
            .toList(),
        placeHolder: json["placeHolder"] as String?,
        denyButtonText: json["denyButtonText"] as String?,
        sendButtonText: json["sendButtonText"] as String?,
        from: json["from"] as String?,
        feedbackExist: json["feedbackExist"] as bool?,
        rate: json["rate"] as String?,
        comment: json["comment"] as String?,
        text: json["text"] as String?,
        scope: json["scope"] as String?,
        colors: json["colors"] as String?,
        defaultColor: json["defaultColor"] as String?,
        name: json["name"] as String?,
        isColorpicker: json["isColorpicker"] as bool?,
        colorid: json["colorid"] as String?,
        url: json["url"] as String?,
        mime: json["mime"] as String?,
        type: json["type"] as String?,
        subText: json["subText"] as String?,
        fields: (json["fields"] as List<dynamic>?)
            ?.map(
              (x) => Field.fromJson(x as Map<String, dynamic>),
            )
            .toList(),
        closable: json["closable"] as bool?,
        clickandopen: json["clickandopen"] as bool?,
        showFormText: json["showFormText"] as String?,
        feedbackMessage: json["feedbackMessage"] as String?,
        confirmationText: json["confirmationText"] as String?,
        formThankDuration: json["formThankDuration"] as String?,
        showDataAfterSubmit: json["showDataAfterSubmit"] as bool?,
        dateType: json["dateType"] as String?,
        enabledDates: json["enableDates"] as List<dynamic>?,
        disabledDates: json["disabledDates"] as List<dynamic>?,
        dateDisplayOption: json["dateDisplayOption"] as String?,
        header: json["header"] as String?,
        content: json["content"] as String?,
        feedback: json["feedback"] as bool?,
        showPopup: json["showPopup"] as bool?,
        subHeader: json["subHeader"] as String?,
        annotation: json["annotation"] as String?,
        buttonText: json["buttonText"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "typing": typing,
        "choices": choices,
        "items": items,
        "thank": thank,
        "sessionId": sessionId,
        "emojiNames": emojiNames,
        "placeHolder": placeHolder,
        "denyButtonText": denyButtonText,
        "sendButtonText": sendButtonText,
        "from": from,
        "feedbackExist": feedbackExist,
        "rate": rate,
        "comment": comment,
        "text": text,
        "scope": scope,
        "colors": colors,
        "defaultColor": defaultColor,
        "name": name,
        "isColorpicker": isColorpicker,
        "colorid": colorid,
        "url": url,
        "mime": mime,
        "type": type,
        "subText": subText,
        "fields": fields,
        "closable": closable,
        "clickandopen": clickandopen,
        "showFormText": showFormText,
        "feedbackMessage": feedbackMessage,
        "confirmationText": confirmationText,
        "formThankDuration": formThankDuration,
        "showDataAfterSubmit": showDataAfterSubmit,
        "dateType": dateType,
        "enabledDates": enabledDates,
        "disabledDates": disabledDates,
        "dateDisplayOption": dateDisplayOption,
        "header": header,
        "content": content,
        "feedback": feedback,
        "showPopup": showPopup,
        "subHeader": subHeader,
        "annotation": annotation,
        "buttonText": buttonText,
      };
}

class Choice {
  String? type;
  String? title;
  String? value;
  Config? config;

  Choice({
    this.type,
    this.title,
    this.value,
    this.config,
  });

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        type: json["type"] as String?,
        title: json["title"] as String?,
        value: json["value"] as String?,
        config: json["config"] == null
            ? null
            : Config.fromJson(json["config"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "title": title,
        "value": value,
        "config": config,
      };
}

class Config {
  String? faqId;
  String? entity;
  String? intent;
  String? entityValue;

  Config({
    this.faqId,
    this.entity,
    this.intent,
    this.entityValue,
  });

  factory Config.fromJson(Map<String, dynamic> json) => Config(
        faqId: json["faqId"] as String?,
        entity: json["entity"] as String?,
        intent: json["intent"] as String?,
        entityValue: json["entityValue"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "faqId": faqId,
        "entity": entity,
        "intent": intent,
        "entityValue": entityValue,
      };
}

class Item {
  String? title;
  List<CarouselButton>? buttons;
  String? picture;
  String? subtitle;

  Item({
    this.title,
    this.buttons,
    this.picture,
    this.subtitle,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        title: json["title"] as String?,
        buttons: (json["buttons"] as List<dynamic>?)
            ?.map(
              (x) => CarouselButton.fromJson(x as Map<String, dynamic>),
            )
            .toList(),
        picture: json["picture"] as String?,
        subtitle: json["subtitle"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "buttons": List<dynamic>.from(buttons!.map((x) => x.toJson())),
        "picture": picture,
        "subtitle": subtitle,
      };
}

class Session {
  String? id;
  dynamic externalId;
  String? tenantId;
  String? botId;
  String? userId;
  String? channel;
  dynamic externalChannel;
  String? status;
  DateTime? lastHeardOn;
  dynamic lastReplyOn;
  DateTime? createdOn;
  DateTime? updatedOn;
  bool? gdpr;

  Session({
    this.id,
    this.externalId,
    this.tenantId,
    this.botId,
    this.userId,
    this.channel,
    this.externalChannel,
    this.status,
    this.lastHeardOn,
    this.lastReplyOn,
    this.createdOn,
    this.updatedOn,
    this.gdpr,
  });

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        id: json["id"] as String?,
        externalId: json["externalId"],
        tenantId: json["tenantId"] as String?,
        botId: json["botId"] as String?,
        userId: json["userId"] as String?,
        channel: json["channel"] as String?,
        externalChannel: json["externalChannel"],
        status: json["status"] as String?,
        lastHeardOn: DateTime.parse(
          json["lastHeardOn"] as String,
        ),
        lastReplyOn: json["lastReplyOn"],
        createdOn: DateTime.parse(
          json["createdOn"] as String,
        ),
        updatedOn: DateTime.parse(
          json["updatedOn"] as String,
        ),
        gdpr: json["gdpr"] as bool?,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "externalId": externalId,
        "tenantId": tenantId,
        "botId": botId,
        "userId": userId,
        "channel": channel,
        "externalChannel": externalChannel,
        "status": status,
        "lastHeardOn": lastHeardOn,
        "lastReplyOn": lastReplyOn,
        "createdOn": createdOn,
        "updatedOn": updatedOn,
        "gdpr": gdpr,
      };
}

class Field {
  String? type;
  String? label;
  String? title;
  String? value;
  String? fieldDefault;
  List<dynamic>? options;
  bool? required;
  bool? validate;
  String? errorMessage;
  String? validationRule;

  Field({
    this.type,
    this.label,
    this.title,
    this.value,
    this.fieldDefault,
    this.options,
    this.required,
    this.validate,
    this.errorMessage,
    this.validationRule,
  });

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        type: json["type"] as String?,
        label: json["label"] as String?,
        title: json["title"] as String?,
        value: json["value"] as String?,
        fieldDefault: json["default"] as String?,
        options: json["options"] as List<dynamic>?,
        required: json["required"] as bool?,
        validate: json["validate"] as bool?,
        errorMessage: json["errorMessage"] as String?,
        validationRule: json["validationRule"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "label": label,
        "title": title,
        "value": value,
        "default": fieldDefault,
        "options": options,
        "required": required,
        "validate": validate,
        "errorMessage": errorMessage,
        "validationRule": validationRule,
      };
}

class EtiyaChatUser extends ChatUser {
  EtiyaChatUser({
    this.id,
    this.channel,
    this.tenantId,
    this.firstName,
    this.lastName,
    this.gender,
    this.userType,
    this.createdOn,
    this.updatedOn,
  }) : super(userName: firstName ?? "", avatar: null);

  String? id;
  String? channel;
  String? tenantId;
  String? firstName;
  String? lastName;
  dynamic gender;
  String? userType;
  DateTime? createdOn;
  dynamic updatedOn;

  @override
  String get userName => firstName ?? 'userName';

  Uri? get avatarURL {
    return null;
  }

  factory EtiyaChatUser.fromJson(Map<String, dynamic> json) => EtiyaChatUser(
        id: json["id"] as String?,
        channel: json["channel"] as String?,
        tenantId: json["tenantId"] as String?,
        firstName: json["firstName"] as String?,
        lastName: json["lastName"] as String?,
        gender: json["gender"],
        userType: json["userType"] as String?,
        createdOn: DateTime.parse(json["createdOn"] as String),
        updatedOn: json["updatedOn"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "channel": channel,
        "tenantId": tenantId,
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "userType": userType,
        "createdOn": createdOn?.toIso8601String(),
        "updatedOn": updatedOn,
      };
}
