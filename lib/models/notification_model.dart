class NotificationModel {
  String? body;
  Data? data;
  String? title;
  String? clickAction;
  String? type;
  String? userType;

  NotificationModel(
      {this.body,
      this.data,
      this.title,
      this.clickAction,
      this.type,
      this.userType});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    body = json['body'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    title = json['title'];
    clickAction = json['click_action'];
    type = json['type'];
    userType = json['user_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['body'] = body;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['title'] = title;
    data['click_action'] = clickAction;
    data['type'] = type;
    data['user_type'] = userType;
    return data;
  }
}

class Data {
  String? userId;
  bool? isActive;

  Data({this.userId, this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['isActive'] = isActive;
    return data;
  }
}
