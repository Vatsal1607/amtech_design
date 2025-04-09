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
  List<String>? images;
  List<String>? ingredients;
  String? description;
  String? recipe;
  num? ratings;
  List<Size>? size;
  List<Size>? personalSize;
  List<String>? addOn;
  bool? isActiveForBusiness;
  bool? isActiveForPersonal;
  bool? isActive;
  bool? isDelete;
  bool? isFavorite;
  String? createdAt;
  String? updatedAt;
  int? iV;
  List<IngredientDetails>? ingredientDetails;
  List<AddOnDetails>? addOnDetails;

  Data({
    this.sId,
    this.categoryId,
    this.itemName,
    this.images,
    this.ingredients,
    this.description,
    this.recipe,
    this.ratings,
    this.size,
    this.personalSize,
    this.addOn,
    this.isActiveForBusiness,
    this.isActiveForPersonal,
    this.isActive,
    this.isDelete,
    this.isFavorite,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.ingredientDetails,
    this.addOnDetails,
  });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryId = json['categoryId'];
    itemName = json['itemName'];
    images = (json['images'] as List?)?.map((e) => e.toString()).toList();
    ingredients =
        (json['ingredients'] as List?)?.map((e) => e.toString()).toList();
    description = json['description'];
    recipe = json['recipe'];
    ratings = (json['ratings'] as num?)?.toDouble();
    if (json['size'] != null) {
      size = (json['size'] as List).map((v) => Size.fromJson(v)).toList();
    }
    if (json['personalSize'] != null) {
      personalSize =
          (json['personalSize'] as List).map((v) => Size.fromJson(v)).toList();
    }
    addOn = (json['addOn'] as List?)?.map((e) => e.toString()).toList();
    isActiveForBusiness = json['isActiveForBusiness'];
    isActiveForPersonal = json['isActiveForPersonal'];
    isActive = json['isActive'];
    isDelete = json['isDelete'];
    isFavorite = json['isFavorite'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    if (json['ingredientDetails'] != null) {
      ingredientDetails = (json['ingredientDetails'] as List)
          .map((e) => IngredientDetails.fromJson(e))
          .toList();
    }
    if (json['addOnDetails'] != null) {
      addOnDetails = (json['addOnDetails'] as List)
          .map((e) => AddOnDetails.fromJson(e))
          .toList();
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
    data['recipe'] = recipe;
    data['ratings'] = ratings;
    data['size'] = size?.map((e) => e.toJson()).toList();
    data['personalSize'] = personalSize?.map((e) => e.toJson()).toList();
    data['addOn'] = addOn;
    data['isActiveForBusiness'] = isActiveForBusiness;
    data['isActiveForPersonal'] = isActiveForPersonal;
    data['isActive'] = isActive;
    data['isDelete'] = isDelete;
    data['isFavorite'] = isFavorite;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['ingredientDetails'] =
        ingredientDetails?.map((e) => e.toJson()).toList();
    data['addOnDetails'] = addOnDetails?.map((e) => e.toJson()).toList();
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
    sizePrice = (json['sizePrice'] as num?)?.toDouble();
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

class IngredientDetails {
  String? ingredientId;
  String? ingredientName;

  IngredientDetails({this.ingredientId, this.ingredientName});

  IngredientDetails.fromJson(Map<String, dynamic> json) {
    ingredientId = json['ingredientId'];
    ingredientName = json['ingredientName'];
  }

  Map<String, dynamic> toJson() {
    return {
      'ingredientId': ingredientId,
      'ingredientName': ingredientName,
    };
  }
}

class AddOnDetails {
  String? addOnId;
  String? addOnName;

  AddOnDetails({this.addOnId, this.addOnName});

  AddOnDetails.fromJson(Map<String, dynamic> json) {
    addOnId = json['addOnId'];
    addOnName = json['addOnName'];
  }

  Map<String, dynamic> toJson() {
    return {
      'addOnId': addOnId,
      'addOnName': addOnName,
    };
  }
}
