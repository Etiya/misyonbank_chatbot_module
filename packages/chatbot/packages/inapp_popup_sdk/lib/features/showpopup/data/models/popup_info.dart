// To parse this JSON data, do
//
//     final popupInfo = popupInfoFromMap(jsonString);

import 'dart:convert';

PopupInfo popupInfoFromMap(String str) => PopupInfo.fromMap(json.decode(str));

String popupInfoToMap(PopupInfo data) => json.encode(data.toMap());

class PopupInfo {
    PopupInfo({
        this.data,
        this.support,
    });

    Data? data;
    Support? support;

    factory PopupInfo.fromMap(Map<String, dynamic> json) => PopupInfo(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        support: json["support"] == null ? null : Support.fromMap(json["support"]),
    );

    Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "support": support?.toMap(),
    };
}

class Data {
    Data({
        this.id,
        this.name,
        this.year,
        this.color,
        this.pantoneValue,
    });

    int? id;
    String? name;
    int? year;
    String? color;
    String? pantoneValue;

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        year: json["year"],
        color: json["color"],
        pantoneValue: json["pantone_value"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "year": year,
        "color": color,
        "pantone_value": pantoneValue,
    };
}

class Support {
    Support({
        this.url,
        this.text,
    });

    String? url;
    String? text;

    factory Support.fromMap(Map<String, dynamic> json) => Support(
        url: json["url"],
        text: json["text"],
    );

    Map<String, dynamic> toMap() => {
        "url": url,
        "text": text,
    };
}
