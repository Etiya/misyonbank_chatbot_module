class MessageData {
  MessageData({
    this.page,
    this.title,
    this.payload,
    this.feedbackExist,
    this.rate,
    this.comment,
    this.sessionId,
  });

  String? page;
  String? title;
  String? payload;
  bool? feedbackExist;
  String? rate;
  String? comment;
  int? sessionId;

  factory MessageData.fromJson(Map<String, dynamic> json) => MessageData(
        title: json["title"] as String?,
        payload: json["payload"] as String?,
        page: json["page"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "title": title,
        "payload": payload,
        "feedbackExist": feedbackExist,
        "rate": rate,
        "comment": comment,
        "sessionId": sessionId,
      };
}
