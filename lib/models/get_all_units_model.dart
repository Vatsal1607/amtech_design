class GetAllUnitsModel {
  bool? success;
  int? statusCode;
  String? message;
  List<UnitItem>? data;

  GetAllUnitsModel({this.success, this.statusCode, this.message, this.data});

  GetAllUnitsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UnitItem>[];
      json['data'].forEach((v) {
        data!.add(UnitItem.fromJson(v));
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

class UnitItem {
  String? label;
  String? value;
  String? price;

  UnitItem({this.label, this.value, this.price});

  UnitItem.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    data['price'] = price;
    return data;
  }
}
