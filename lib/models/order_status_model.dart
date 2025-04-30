class OrderStatusModel {
  final String message;
  final String? data;
  final String? currentStatus;
  final List<OrderItem> items;

  OrderStatusModel({
    required this.message,
    this.data,
    this.currentStatus,
    required this.items,
  });

  factory OrderStatusModel.fromJson(Map<String, dynamic> json) {
    return OrderStatusModel(
      message: json['message'],
      data: json['data'],
      currentStatus: json['currentStatus'],
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderItem.fromJson(e))
          .toList(),
    );
  }
}

class OrderItem {
  final String menuId;
  final String itemName;
  final List<ItemSize> size;
  final List<dynamic> ingredients;
  final List<dynamic> addOns;
  final int quantity;
  final int price;
  final int totalPrice;
  final String id;

  OrderItem({
    required this.menuId,
    required this.itemName,
    required this.size,
    required this.ingredients,
    required this.addOns,
    required this.quantity,
    required this.price,
    required this.totalPrice,
    required this.id,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      menuId: json['menuId'],
      itemName: json['itemName'],
      size: (json['size'] as List).map((e) => ItemSize.fromJson(e)).toList(),
      ingredients: json['ingredients'] ?? [],
      addOns: json['addOns'] ?? [],
      quantity: json['quantity'],
      price: json['price'],
      totalPrice: json['totalPrice'],
      id: json['_id'],
    );
  }
}

class ItemSize {
  final String sizeId;
  final String sizeName;
  final int sizePrice;
  final String id;

  ItemSize({
    required this.sizeId,
    required this.sizeName,
    required this.sizePrice,
    required this.id,
  });

  factory ItemSize.fromJson(Map<String, dynamic> json) {
    return ItemSize(
      sizeId: json['sizeId'],
      sizeName: json['sizeName'],
      sizePrice: json['sizePrice'],
      id: json['_id'],
    );
  }
}
