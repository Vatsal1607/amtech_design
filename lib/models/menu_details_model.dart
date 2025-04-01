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
  List<String>? images; // Updated to List<String>
  List<String>? ingredients;
  String? description;
  num? ratings;
  List<Size>? size;
  bool? isActive;
  bool? isDelete;
  String? createdAt;
  String? updatedAt;
  int? iV;
  List<Size>? personalSize;
  bool? isFavorite; // New field added

  Data({
    this.sId,
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
    this.personalSize,
    this.isFavorite,
  });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryId = json['categoryId'];
    itemName = json['itemName'];
    images = json['images'] is List
        ? List<String>.from(json['images'].map((e) => e.toString()))
        : json['images'] is String
            ? [json['images']]
            : [];
    ingredients = json['ingredients'] is List
        ? List<String>.from(json['ingredients'])
        : [];
    description = json['description'];
    ratings = (json['ratings'] as num?)?.toDouble(); // Converts int to double
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
    isFavorite = json['isFavorite']; // Parse new field
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
    data['isFavorite'] = isFavorite; // Add new field to JSON
    return data;
  }
}

class Size {
  String? sizeId;
  String? volume;
  num? sizePrice;
  String? sId;

  Size({this.sizeId, this.volume, this.sizePrice, this.sId});

  Size.fromJson(Map<String, dynamic> json) {
    sizeId = json['sizeId'];
    volume = json['volume'];
    sizePrice = (json['sizePrice'] as num?)
        ?.toDouble(); // Converts int to double ! working
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
