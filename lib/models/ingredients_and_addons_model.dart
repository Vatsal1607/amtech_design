class IngredientsAndAddOnsModel {
  bool? success;
  int? statusCode;
  String? message;
  SubscriptionMenuData? data;

  IngredientsAndAddOnsModel(
      {this.success, this.statusCode, this.message, this.data});

  factory IngredientsAndAddOnsModel.fromJson(Map<String, dynamic> json) {
    return IngredientsAndAddOnsModel(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null
          ? SubscriptionMenuData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'statusCode': statusCode,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class SubscriptionMenuData {
  List<MenuDetail>? ingredientDetails;
  List<MenuDetail>? addOnDetails;

  SubscriptionMenuData({this.ingredientDetails, this.addOnDetails});

  factory SubscriptionMenuData.fromJson(Map<String, dynamic> json) {
    return SubscriptionMenuData(
      ingredientDetails: (json['ingredientDetails'] as List<dynamic>?)
          ?.map((e) => MenuDetail.fromJson(e))
          .toList(),
      addOnDetails: (json['addOnDetails'] as List<dynamic>?)
          ?.map((e) => MenuDetail.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ingredientDetails': ingredientDetails?.map((e) => e.toJson()).toList(),
      'addOnDetails': addOnDetails?.map((e) => e.toJson()).toList(),
    };
  }
}

class MenuDetail {
  String? id;
  String? name;

  MenuDetail({this.id, this.name});

  factory MenuDetail.fromJson(Map<String, dynamic> json) {
    return MenuDetail(
      id: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}
