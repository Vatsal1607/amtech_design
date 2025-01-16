class MenuDetailsModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  MenuDetailsModel({this.success, this.statusCode, this.message, this.data});

  MenuDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? sId;
  String? categoryId;
  String? itemName;
  String? images;
  String? ingredients;
  String? description;
  double? ratings;
  List<Size>? size;
  bool? isActive;
  bool? isDelete;
  String? createdAt;
  String? updatedAt;
  int? iV;
  List<Size>? personalSize;

  Data(
      {this.sId,
      this.categoryId,
      this.itemName,
      this.images,
      this.ingredients,
      this.description,
      this.ratings,
      this.size,
      this.isActive,
      this.isDelete,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.personalSize});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryId = json['categoryId'];
    itemName = json['itemName'];
    images = json['images'];
    ingredients = json['ingredients'];
    description = json['description'];
    ratings = json['ratings'];
    if (json['size'] != null) {
      size = <Size>[];
      json['size'].forEach((v) {
        size!.add(Size.fromJson(v));
      });
    }
    isActive = json['isActive'];
    isDelete = json['isDelete'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    if (json['personalSize'] != null) {
      personalSize = <Size>[];
      json['personalSize'].forEach((v) {
        personalSize!.add(Size.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['categoryId'] = categoryId;
    data['itemName'] = itemName;
    data['images'] = images;
    data['ingredients'] = ingredients;
    data['description'] = description;
    data['ratings'] = ratings;
    if (size != null) {
      data['size'] = size!.map((v) => v.toJson()).toList();
    }
    data['isActive'] = isActive;
    data['isDelete'] = isDelete;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    if (personalSize != null) {
      data['personalSize'] = personalSize!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Size {
  String? sizeId;
  String? volume;
  double? sizePrice;
  String? sId;

  Size({this.sizeId, this.volume, this.sizePrice, this.sId});

  Size.fromJson(Map<String, dynamic> json) {
    sizeId = json['sizeId'];
    volume = json['volume'];
    sizePrice = json['sizePrice'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sizeId'] = sizeId;
    data['volume'] = volume;
    data['sizePrice'] = sizePrice;
    data['_id'] = sId;
    return data;
  }
}
