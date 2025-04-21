class SubsDayDetailsModel {
  bool? success;
  String? message;
  List<SubsDayDetails>? data;

  SubsDayDetailsModel({this.success, this.message, this.data});

  SubsDayDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SubsDayDetails>[];
      json['data'].forEach((v) {
        data!.add(SubsDayDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubsDayDetails {
  String? customerName;
  String? itemName;
  String? subscriptionId;
  String? timeSlot;
  int? quantity;
  List<AddOn>? addOns;
  List<Ingredient>? ingredients;

  SubsDayDetails({
    this.customerName,
    this.itemName,
    this.subscriptionId,
    this.timeSlot,
    this.quantity,
    this.addOns,
    this.ingredients,
  });

  SubsDayDetails.fromJson(Map<String, dynamic> json) {
    customerName = json['customerName'];
    itemName = json['itemName'];
    subscriptionId = json['subscription_id'];
    timeSlot = json['timeSlot'];
    quantity = json['quantity'];
    if (json['addOns'] != null) {
      addOns = <AddOn>[];
      json['addOns'].forEach((v) {
        addOns!.add(AddOn.fromJson(v));
      });
    }
    if (json['ingredients'] != null) {
      ingredients = <Ingredient>[];
      json['ingredients'].forEach((v) {
        ingredients!.add(Ingredient.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customerName'] = customerName;
    data['itemName'] = itemName;
    data['subscription_id'] = subscriptionId;
    data['timeSlot'] = timeSlot;
    data['quantity'] = quantity;
    if (addOns != null) {
      data['addOns'] = addOns!.map((v) => v.toJson()).toList();
    }
    if (ingredients != null) {
      data['ingredients'] = ingredients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddOn {
  String? addOnId;
  String? name;
  int? quantity;

  AddOn({this.addOnId, this.name, this.quantity});

  AddOn.fromJson(Map<String, dynamic> json) {
    addOnId = json['addOnId'];
    name = json['name'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['addOnId'] = addOnId;
    data['name'] = name;
    data['quantity'] = quantity;
    return data;
  }
}

class Ingredient {
  String? ingredientId;
  String? ingreName;

  Ingredient({this.ingredientId, this.ingreName});

  Ingredient.fromJson(Map<String, dynamic> json) {
    ingredientId = json['ingredientId'];
    ingreName = json['ingreName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ingredientId'] = ingredientId;
    data['ingreName'] = ingreName;
    return data;
  }
}
