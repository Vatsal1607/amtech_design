class ApiGlobalModel {
  bool? success;
  int? statusCode;
  String? message;
  String? error;

  ApiGlobalModel({this.success, this.statusCode, this.message, this.error});

  ApiGlobalModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['statusCode'] = statusCode;
    data['message'] = message;
    data['error'] = error;
    return data;
  }
}
