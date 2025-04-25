import 'package:amtech_design/models/subscription_summary_model.dart'
    as summary;

class SubscriptionModifyRequestModel {
  final String userId;
  final String userType;
  List<SubscriptionItem>? items;
  final double price;
  final String units;
  final String notes;
  final String paymentMethod;
  final bool paymentStatus;
  final DateTime? createdAt;
  final String? deliveryAddress;

  SubscriptionModifyRequestModel({
    required this.userId,
    required this.userType,
    required this.items,
    required this.price,
    required this.units,
    required this.notes,
    required this.paymentMethod,
    required this.paymentStatus,
    this.createdAt,
    this.deliveryAddress,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "userType": userType,
      "items": items?.map((item) => item.toJson()).toList(),
      "price": price,
      "units": units,
      "notes": notes,
      "paymentMethod": paymentMethod,
      "paymentStatus": paymentStatus,
      "createdAt": createdAt?.toIso8601String(),
      "deliveryAddress": deliveryAddress,
    };
  }
}

class SubscriptionItem {
  // String? menuId;
  String? menuIds; // Changed from menuId to menuIds
  String? itemName;
  List<Size>? size;
  List<Customization>? customize;
  List<MealSubscription>? mealSubscription;
  String? sId;

  SubscriptionItem({
    // this.menuId,
    this.menuIds, // Updated constructor
    this.itemName,
    this.size,
    this.customize,
    this.mealSubscription,
    this.sId,
  });

  factory SubscriptionItem.fromSummary(summary.SubscriptionItem item) {
    return SubscriptionItem(
      // menuId: item.menuId,
      menuIds: item
          .menuId, // Keep this as item.menuId if summary class still uses menuId
      itemName: item.itemName,
      sId: item.sId,
      size: item.size
          ?.map((s) => Size(
                sizeId: s.sizeId,
                sizeName: s.sizeName,
                sizePrice: s.sizePrice,
                sId: s.sId,
              ))
          .toList(),
      mealSubscription: item.mealSubscription
          ?.map((m) => MealSubscription(
                day: m.day ?? '',
                timeSlot: m.timeSlot ?? '',
                quantity: m.quantity ?? 0,
              ))
          .toList(),
      customize: item.customize
          ?.map((c) => Customization(
                ingredients: c.ingredients
                        ?.map((i) =>
                            Ingredient(ingredientId: i.ingredientId ?? ''))
                        .toList() ??
                    [],
                addOns: c.addOns
                        ?.map((a) => AddOn(
                            addOnId: a.addOnId ?? '',
                            quantity: a.quantity ?? 0))
                        .toList() ??
                    [],
              ))
          .toList(),
    );
  }

  SubscriptionItem.fromJson(Map<String, dynamic> json) {
    // menuId = json['menuId'];
    menuIds = json['menuIds']; // updated from 'menuId'
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
    // data['menuId'] = menuId;
    data['menuIds'] = menuIds; // updated from 'menuId'
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

class MealSubscription {
  final String day;
  String timeSlot;
  final int quantity;

  MealSubscription({
    required this.day,
    required this.timeSlot,
    required this.quantity,
  });

  MealSubscription.fromJson(Map<String, dynamic> json)
      : day = json['day'],
        timeSlot = json['timeSlot'],
        quantity = json['quantity'];

  Map<String, dynamic> toJson() {
    return {
      "day": day,
      "timeSlot": timeSlot,
      "quantity": quantity,
    };
  }
}

class Customization {
  final List<Ingredient> ingredients;
  final List<AddOn> addOns;

  Customization({
    required this.ingredients,
    required this.addOns,
  });

  factory Customization.fromJson(Map<String, dynamic> json) {
    return Customization(
      ingredients: (json['ingredients'] as List)
          .map((i) => Ingredient.fromJson(i))
          .toList(),
      addOns: (json['addOns'] as List).map((a) => AddOn.fromJson(a)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "ingredients": ingredients.map((i) => i.toJson()).toList(),
      "addOns": addOns.map((a) => a.toJson()).toList(),
    };
  }
}

class Ingredient {
  final String ingredientId;

  Ingredient({required this.ingredientId});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(ingredientId: json['ingredientId']);
  }

  Map<String, dynamic> toJson() {
    return {
      "ingredientId": ingredientId,
    };
  }
}

//NEW
class AddOn {
  final String addOnId;
  final int quantity;

  AddOn({required this.addOnId, required this.quantity});

  factory AddOn.fromJson(Map<String, dynamic> json) {
    return AddOn(
      addOnId: json['addOnId'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "addOnId": addOnId,
      "quantity": quantity,
    };
  }
}
