class SubscriptionCreateRequestModel {
  final String userId;
  final String userType;
  final List<SubscriptionItem> items;
  final double price;
  final String units;
  final String notes;
  final String paymentMethod;
  final bool paymentStatus;

  SubscriptionCreateRequestModel({
    required this.userId,
    required this.userType,
    required this.items,
    required this.price,
    required this.units,
    required this.notes,
    required this.paymentMethod,
    required this.paymentStatus,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "userType": userType,
      "items": items.map((item) => item.toJson()).toList(),
      "price": price,
      "units": units,
      "notes": notes,
      "paymentMethod": paymentMethod,
      "paymentStatus": paymentStatus,
    };
  }
}

class SubscriptionItem {
  final String menuIds;
  final Size? size;
  final List<MealSubscription>? mealSubscription;
  final List<Customization>? customize;

  SubscriptionItem({
    required this.menuIds,
    this.size,
    this.mealSubscription,
    this.customize,
  });

  Map<String, dynamic> toJson() {
    return {
      "menuIds": menuIds,
      "size": size?.toJson(),
      "mealSubscription": mealSubscription
          ?.map((m) => m.toJson())
          .toList(), // Safely handle nullable list
      "customize": customize
          ?.map((c) => c.toJson())
          .toList(), // Safely handle nullable list
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
