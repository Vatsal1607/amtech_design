class SubscriptionCreateRequestModel {
  final String userId;
  final String userType;
  final List<SubscriptionItem> items;
  final double price;
  final String units;
  // final String notes; // replaced with particular item note
  final String paymentMethod;
  final bool paymentStatus;
  final DateTime? createdAt;
  final String? deliveryAddress;

  SubscriptionCreateRequestModel({
    required this.userId,
    required this.userType,
    required this.items,
    required this.price,
    required this.units,
    // required this.notes,
    required this.paymentMethod,
    required this.paymentStatus,
    this.createdAt,
    this.deliveryAddress,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "userType": userType,
      "items": items.map((item) => item.toJson()).toList(),
      "price": price,
      "units": units,
      // "notes": notes,
      "paymentMethod": paymentMethod,
      "paymentStatus": paymentStatus,
      "createdAt": createdAt?.toIso8601String(),
      "deliveryAddress": deliveryAddress,
    };
  }
}

class SubscriptionItem {
  final String menuIds;
  final Size? size;
  final List<MealSubscription>? mealSubscription;
  final List<Customization>? customize;
  final String? notes; // ✅ newly added here

  SubscriptionItem({
    required this.menuIds,
    this.size,
    this.mealSubscription,
    this.customize,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      "menuIds": menuIds,
      "size": size?.toJson(),
      "mealSubscription": mealSubscription?.map((m) => m.toJson()).toList(),
      "customize": customize?.map((c) => c.toJson()).toList(),
      "notes": notes,
    };
  }
}

class Size {
  final String sizeId;
  final String name; // volume
  final double price;

  Size({
    required this.sizeId,
    required this.name,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      "sizeId": sizeId,
      "name": name,
      "price": price,
    };
  }
}

class MealSubscription {
  final String day;
  final String timeSlot;
  final int quantity;

  MealSubscription({
    required this.day,
    required this.timeSlot,
    required this.quantity,
  });

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

  Map<String, dynamic> toJson() {
    return {
      "ingredientId": ingredientId,
    };
  }
}

class AddOn {
  final String addOnId;
  final int quantity;

  AddOn({required this.addOnId, required this.quantity});

  Map<String, dynamic> toJson() {
    return {
      "addOnId": addOnId,
      "quantity": quantity,
    };
  }
}
