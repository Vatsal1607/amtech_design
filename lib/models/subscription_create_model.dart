class SubscriptionCreateModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  SubscriptionCreateModel(
      {this.success, this.statusCode, this.message, this.data});

  SubscriptionCreateModel.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? userType;
  List<Items>? items;
  String? units;
  String? notes;
  int? price;
  String? paymentMethod;
  bool? paymentStatus;
  bool? isActive;
  bool? isDelete;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.userId,
      this.userType,
      this.items,
      this.units,
      this.notes,
      this.price,
      this.paymentMethod,
      this.paymentStatus,
      this.isActive,
      this.isDelete,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userType = json['userType'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    units = json['units'];
    notes = json['notes'];
    price = json['price'];
    paymentMethod = json['paymentMethod'];
    paymentStatus = json['paymentStatus'];
    isActive = json['isActive'];
    isDelete = json['isDelete'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['userType'] = userType;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['units'] = units;
    data['notes'] = notes;
    data['price'] = price;
    data['paymentMethod'] = paymentMethod;
    data['paymentStatus'] = paymentStatus;
    data['isActive'] = isActive;
    data['isDelete'] = isDelete;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Items {
  String? menuId;
  String? itemName;
  List<Size>? size;
  List<Customize>? customize;
  List<MealSubscription>? mealSubscription;
  String? sId;

  Items(
      {this.menuId,
      this.itemName,
      this.size,
      this.customize,
      this.mealSubscription,
      this.sId});

  Items.fromJson(Map<String, dynamic> json) {
    menuId = json['menuId'];
    itemName = json['itemName'];
    if (json['size'] != null) {
      size = <Size>[];
      json['size'].forEach((v) {
        size!.add(Size.fromJson(v));
      });
    }
    if (json['customize'] != null) {
      customize = <Customize>[];
      json['customize'].forEach((v) {
        customize!.add(Customize.fromJson(v));
      });
    }
    if (json['mealSubscription'] != null) {
      mealSubscription = <MealSubscription>[];
      json['mealSubscription'].forEach((v) {
        mealSubscription!.add(MealSubscription.fromJson(v));
      });
    }
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menuId'] = menuId;
    data['itemName'] = itemName;
    if (size != null) {
      data['size'] = size!.map((v) => v.toJson()).toList();
    }
    if (customize != null) {
      data['customize'] = customize!.map((v) => v.toJson()).toList();
    }
    if (mealSubscription != null) {
      data['mealSubscription'] =
          mealSubscription!.map((v) => v.toJson()).toList();
    }
    data['_id'] = sId;
    return data;
  }
}

class Size {
  String? sizeId;
  String? sizeName;
  int? sizePrice;
  String? sId;

  Size({this.sizeId, this.sizeName, this.sizePrice, this.sId});

  Size.fromJson(Map<String, dynamic> json) {
    sizeId = json['sizeId'];
    sizeName = json['sizeName'];
    sizePrice = json['sizePrice'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sizeId'] = sizeId;
    data['sizeName'] = sizeName;
    data['sizePrice'] = sizePrice;
    data['_id'] = sId;
    return data;
  }
}

class Customize {
  List<Ingredients>? ingredients;
  List<AddOns>? addOns;
  String? sId;

  Customize({this.ingredients, this.addOns, this.sId});

  Customize.fromJson(Map<String, dynamic> json) {
    if (json['ingredients'] != null) {
      ingredients = <Ingredients>[];
      json['ingredients'].forEach((v) {
        ingredients!.add(Ingredients.fromJson(v));
      });
    }
    if (json['addOns'] != null) {
      addOns = <AddOns>[];
      json['addOns'].forEach((v) {
        addOns!.add(AddOns.fromJson(v));
      });
    }
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ingredients != null) {
      data['ingredients'] = ingredients!.map((v) => v.toJson()).toList();
    }
    if (addOns != null) {
      data['addOns'] = addOns!.map((v) => v.toJson()).toList();
    }
    data['_id'] = sId;
    return data;
  }
}

class Ingredients {
  String? ingredientId;
  String? ingreName;
  String? sId;

  Ingredients({this.ingredientId, this.ingreName, this.sId});

  Ingredients.fromJson(Map<String, dynamic> json) {
    ingredientId = json['ingredientId'];
    ingreName = json['ingreName'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ingredientId'] = ingredientId;
    data['ingreName'] = ingreName;
    data['_id'] = sId;
    return data;
  }
}

class AddOns {
  String? addOnId;
  String? name;
  int? quantity;
  String? sId;

  AddOns({this.addOnId, this.name, this.quantity, this.sId});

  AddOns.fromJson(Map<String, dynamic> json) {
    addOnId = json['addOnId'];
    name = json['name'];
    quantity = json['quantity'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['addOnId'] = addOnId;
    data['name'] = name;
    data['quantity'] = quantity;
    data['_id'] = sId;
    return data;
  }
}

class MealSubscription {
  String? day;
  String? timeSlot;
  String? saladName;
  int? quantity;
  String? sId;

  MealSubscription(
      {this.day, this.timeSlot, this.saladName, this.quantity, this.sId});

  MealSubscription.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    timeSlot = json['timeSlot'];
    saladName = json['saladName'];
    quantity = json['quantity'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['timeSlot'] = timeSlot;
    data['saladName'] = saladName;
    data['quantity'] = quantity;
    data['_id'] = sId;
    return data;
  }
}
