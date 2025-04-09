class HomeMenuModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  HomeMenuModel({this.success, this.statusCode, this.message, this.data});

  HomeMenuModel.fromJson(Map<String, dynamic> json) {
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
  String? businessName;
  String? ownerName;
  String? firstName;
  String? lastName;
  List<MenuCategories>? menuCategories;
  num? rechargeAmount;
  num? usedAmount;
  num? totalPerks;
  num? usedPerks;
  String? address;
  num? remainingAmount;

  Data(
      {this.sId,
      this.businessName,
      this.ownerName,
      this.firstName,
      this.lastName,
      this.menuCategories,
      this.rechargeAmount,
      this.usedAmount,
      this.totalPerks,
      this.usedPerks,
      this.address,
      this.remainingAmount});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    businessName = json['businessName'];
    ownerName = json['ownerName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    if (json['menuCategories'] != null) {
      menuCategories = <MenuCategories>[];
      json['menuCategories'].forEach((v) {
        menuCategories!.add(MenuCategories.fromJson(v));
      });
    }
    rechargeAmount = json['rechargeAmount'];
    usedAmount = json['usedAmount'];
    totalPerks = json['totalPerks'];
    usedPerks = json['usedPerks'];
    address = json['address'];
    remainingAmount = json['remainingAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['businessName'] = businessName;
    data['ownerName'] = ownerName;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    if (menuCategories != null) {
      data['menuCategories'] = menuCategories!.map((v) => v.toJson()).toList();
    }
    data['rechargeAmount'] = rechargeAmount;
    data['usedAmount'] = usedAmount;
    data['totalPerks'] = totalPerks;
    data['usedPerks'] = usedPerks;
    data['address'] = address;
    return data;
  }
}

class MenuCategories {
  String? categoryTitle;
  List<MenuItems>? menuItems;
  String? categoryId;

  MenuCategories({this.categoryTitle, this.menuItems, this.categoryId});

  MenuCategories.fromJson(Map<String, dynamic> json) {
    categoryTitle = json['categoryTitle'];
    if (json['menuItems'] != null) {
      menuItems = <MenuItems>[];
      json['menuItems'].forEach((v) {
        menuItems!.add(MenuItems.fromJson(v));
      });
    }
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryTitle'] = categoryTitle;
    if (menuItems != null) {
      data['menuItems'] = menuItems!.map((v) => v.toJson()).toList();
    }
    data['categoryId'] = categoryId;
    return data;
  }
}

class MenuItems {
  String? menuId;
  String? itemName;
  List<String>? images; // Updated to List<String>
  String? description;
  num? ratings;
  List<Size>? size;
  List<Size>? personalSize;
  String? createdAt;
  String? updatedAt;

  MenuItems(
      {this.menuId,
      this.itemName,
      this.images,
      this.description,
      this.ratings,
      this.size,
      this.personalSize,
      this.createdAt,
      this.updatedAt});

  MenuItems.fromJson(Map<String, dynamic> json) {
    menuId = json['menuId'];
    itemName = json['itemName'];
    images = json['images'] != null
        ? List<String>.from(json['images'])
        : null; // Convert to List<String>
    description = json['description'];
    ratings = json['ratings'];
    if (json['size'] != null) {
      size = <Size>[];
      json['size'].forEach((v) {
        size!.add(Size.fromJson(v));
      });
    }
    if (json['personalSize'] != null) {
      personalSize = <Size>[];
      json['personalSize'].forEach((v) {
        personalSize!.add(Size.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menuId'] = menuId;
    data['itemName'] = itemName;
    data['images'] = images;
    data['description'] = description;
    data['ratings'] = ratings;
    if (size != null) {
      data['size'] = size!.map((v) => v.toJson()).toList();
    }
    if (personalSize != null) {
      data['personalSize'] = personalSize!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
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
