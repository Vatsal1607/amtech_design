// Main model for the request
class OrderCreateRequestModel {
  final String userId;
  final String userType;
  final List<OrderCreateRequestItem> items;
  final double totalAmount;
  final String paymentMethod;
  final String deliveryAddress;

  OrderCreateRequestModel({
    required this.userId,
    required this.userType,
    required this.items,
    required this.totalAmount,
    required this.paymentMethod,
    required this.deliveryAddress,
  });

  // Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "userType": userType,
      "items": items.map((item) => item.toJson()).toList(),
      "totalAmount": totalAmount,
      "paymentMethod": paymentMethod,
      "deliveryAddress": deliveryAddress,
    };
  }
}

// Model for each item in the list
class OrderCreateRequestItem {
  final String menuId;
  final int quantity;
  final List<OrderCreateSizeOption> size;

  OrderCreateRequestItem({
    required this.menuId,
    required this.quantity,
    required this.size,
  });

  Map<String, dynamic> toJson() {
    return {
      "menuId": menuId,
      "quantity": quantity,
      "size": size.map((s) => s.toJson()).toList(),
    };
  }
}

// Model for size options
class OrderCreateSizeOption {
  final String sizeId;
  final String sizeName;

  OrderCreateSizeOption({
    required this.sizeId,
    required this.sizeName,
  });

  Map<String, dynamic> toJson() {
    return {
      "sizeId": sizeId,
      "sizeName": sizeName,
    };
  }
}
