class NotificationHistoryModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  NotificationHistoryModel(
      {this.success, this.statusCode, this.message, this.data});

  NotificationHistoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Notifications>? notifications;

  Data({this.notifications});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (notifications != null) {
      data['notifications'] = notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  String? sId;
  String? userId;
  String? userType;
  String? title;
  String? body;
  int? readStatus;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Notifications(
      {this.sId,
      this.userId,
      this.userType,
      this.title,
      this.body,
      this.readStatus,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Notifications.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    userType = json['userType'];
    title = json['title'];
    body = json['body'];
    readStatus = json['readStatus'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['userType'] = userType;
    data['title'] = title;
    data['body'] = body;
    data['readStatus'] = readStatus;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
