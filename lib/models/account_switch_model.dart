class AccountSwitchModel {
  bool? success;
  int? statusCode;
  String? message;
  List<AccountData>? data;

  AccountSwitchModel({this.success, this.statusCode, this.message, this.data});

  AccountSwitchModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AccountData>[];
      json['data'].forEach((v) {
        data!.add(AccountData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AccountData {
  String? id;
  String? name;
  int? contact;
  String? userType;
  String? image; // <-- added field

  AccountData({this.id, this.name, this.contact, this.userType, this.image});

  AccountData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    contact = json['contact'];
    userType = json['userType'];
    image = json['image']; // <-- mapped from response
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['contact'] = contact;
    data['userType'] = userType;
    data['image'] = image; // <-- included in JSON
    return data;
  }
}
