class AllOrderStatusModel {
  String? message;
  List<Data>? data;

  AllOrderStatusModel({this.message, this.data});

  AllOrderStatusModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? orderId;
  List<Item>? items;
  String? orderStatus;
  String? createdAt;
  String? currentStatus;

  Data({
    this.orderId,
    this.items,
    this.orderStatus,
    this.createdAt,
    this.currentStatus,
  });

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['_id'];
    if (json['items'] != null) {
      items = <Item>[];
      json['items'].forEach((v) {
        items!.add(Item.fromJson(v));
      });
    }
    orderStatus = json['orderStatus'];
    createdAt = json['createdAt'];
    currentStatus = json['currentStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = orderId;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['orderStatus'] = orderStatus;
    data['createdAt'] = createdAt;
    data['currentStatus'] = currentStatus;
    return data;
  }
}

class Item {
  String? menuId;
  String? itemName;
  List<Size>? size;
  List<dynamic>? ingredients; // Keeping it dynamic since it's an array
  List<dynamic>? addOns;
  int? quantity;
  int? price;
  int? totalPrice;
  String? itemId;

  Item({
    this.menuId,
    this.itemName,
    this.size,
    this.ingredients,
    this.addOns,
    this.quantity,
    this.price,
    this.totalPrice,
    this.itemId,
  });

  Item.fromJson(Map<String, dynamic> json) {
    menuId = json['menuId'];
    itemName = json['itemName'];
    if (json['size'] != null) {
      size = <Size>[];
      json['size'].forEach((v) {
        size!.add(Size.fromJson(v));
      });
    }
    ingredients = json['ingredients'] ?? [];
    addOns = json['addOns'] ?? [];
    quantity = json['quantity'];
    price = json['price'];
    totalPrice = json['totalPrice'];
    itemId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menuId'] = menuId;
    data['itemName'] = itemName;
    if (size != null) {
      data['size'] = size!.map((v) => v.toJson()).toList();
    }
    data['ingredients'] = ingredients;
    data['addOns'] = addOns;
    data['quantity'] = quantity;
    data['price'] = price;
    data['totalPrice'] = totalPrice;
    data['_id'] = itemId;
    return data;
  }
}

class Size {
  String? sizeId;
  String? sizeName;
  int? sizePrice;
  String? id;

  Size({this.sizeId, this.sizeName, this.sizePrice, this.id});

  Size.fromJson(Map<String, dynamic> json) {
    sizeId = json['sizeId'];
    sizeName = json['sizeName'];
    sizePrice = json['sizePrice'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sizeId'] = sizeId;
    data['sizeName'] = sizeName;
    data['sizePrice'] = sizePrice;
    data['_id'] = id;
    return data;
  }
}
