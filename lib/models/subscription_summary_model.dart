class SubscriptionSummaryModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  SubscriptionSummaryModel(
      {this.success, this.statusCode, this.message, this.data});

  SubscriptionSummaryModel.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? userType;
  List<SubscriptionItem>? items;
  String? units;
  String? notes;
  int? price;
  String? paymentMethod;
  bool? paymentStatus;
  bool? isActive;
  bool? isDelete;
  String? createdAt;
  String? updatedAt;
  int? iV;
  UserDetails? userDetails;
  SubscriptionHistory? history;

  Data({
    this.sId,
    this.userId,
    this.userType,
    this.items,
    this.units,
    this.notes,
    this.price,
    this.paymentMethod,
    this.paymentStatus,
    this.isActive,
    this.isDelete,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.userDetails,
    this.history,
  });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    userType = json['userType'];
    if (json['items'] != null) {
      items = <SubscriptionItem>[];
      json['items'].forEach((v) {
        items!.add(SubscriptionItem.fromJson(v));
      });
    }
    units = json['units'];
    notes = json['notes'];
    price = json['price'];
    paymentMethod = json['paymentMethod'];
    paymentStatus = json['paymentStatus'];
    isActive = json['isActive'];
    isDelete = json['isDelete'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    userDetails = json['userDetails'] != null
        ? UserDetails.fromJson(json['userDetails'])
        : null;
    history = json['history'] != null
        ? SubscriptionHistory.fromJson(json['history'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
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
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    if (userDetails != null) {
      data['userDetails'] = userDetails!.toJson();
    }
    if (history != null) {
      data['history'] = history!.toJson();
    }
    return data;
  }
}

class SubscriptionHistory {
  int? totalUnits;
  int? remainingUnits;
  int? deliveredUnits;

  SubscriptionHistory(
      {this.totalUnits, this.remainingUnits, this.deliveredUnits});

  SubscriptionHistory.fromJson(Map<String, dynamic> json) {
    totalUnits = json['totalUnits'];
    remainingUnits = json['remainingUnits'];
    deliveredUnits = json['deliveredUnits'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalUnits'] = totalUnits;
    data['remainingUnits'] = remainingUnits;
    data['deliveredUnits'] = deliveredUnits;
    return data;
  }
}

class UserDetails {
  String? sId;
  String? businessName; // For BusinessUser
  String? firstName; // For PersonalUser
  String? lastName; // For PersonalUser
  int? contact;

  UserDetails({
    this.sId,
    this.businessName,
    this.firstName,
    this.lastName,
    this.contact,
  });

  UserDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    businessName = json['businessName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    contact = json['contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (businessName != null) data['businessName'] = businessName;
    if (firstName != null) data['firstName'] = firstName;
    if (lastName != null) data['lastName'] = lastName;
    data['contact'] = contact;
    return data;
  }
}

class SubscriptionItem {
  String? menuId;
  String? itemName;
  List<Size>? size;
  List<Customization>? customize;
  List<MealSubscription>? mealSubscription;
  String? sId;

  SubscriptionItem(
      {this.menuId,
      this.itemName,
      this.size,
      this.customize,
      this.mealSubscription,
      this.sId});

  SubscriptionItem.fromJson(Map<String, dynamic> json) {
    menuId = json['menuId'];
    itemName = json['itemName'];
    if (json['size'] != null) {
      size = <Size>[];
      json['size'].forEach((v) {
        size!.add(Size.fromJson(v));
      });
    }
    if (json['customize'] != null) {
      customize = <Customization>[];
      json['customize'].forEach((v) {
        customize!.add(Customization.fromJson(v));
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

class Customization {
  List<Ingredients>? ingredients;
  List<AddOns>? addOns;
  String? sId;

  Customization({this.ingredients, this.addOns, this.sId});

  Customization.fromJson(Map<String, dynamic> json) {
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
  int? price;
  int? quantity;
  String? sId;

  AddOns({this.addOnId, this.name, this.quantity, this.sId, this.price});

  AddOns.fromJson(Map<String, dynamic> json) {
    addOnId = json['addOnId'];
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['addOnId'] = addOnId;
    data['name'] = name;
    data['price'] = price;
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
