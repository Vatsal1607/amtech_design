class UnreadNotificationModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  UnreadNotificationModel(
      {this.success, this.statusCode, this.message, this.data});

  UnreadNotificationModel.fromJson(Map<String, dynamic> json) {
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
  int? unreadCount;

  Data({this.unreadCount});

  Data.fromJson(Map<String, dynamic> json) {
    unreadCount = json['unreadCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unreadCount'] = unreadCount;
    return data;
  }
}
