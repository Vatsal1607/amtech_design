class ListCartModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  ListCartModel({this.success, this.statusCode, this.message, this.data});

  ListCartModel.fromJson(Map<String, dynamic> json) {
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
  List<Carts>? carts;

  Data({this.carts});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['carts'] != null) {
      carts = <Carts>[];
      json['carts'].forEach((v) {
        carts!.add(Carts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (carts != null) {
      data['carts'] = carts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Carts {
  String? sId;
  String? userId;
  List<CartItems>? items;
  num? totalAmount;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Carts(
      {this.sId,
      this.userId,
      this.items,
      this.totalAmount,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Carts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    if (json['items'] != null) {
      items = <CartItems>[];
      json['items'].forEach((v) {
        items!.add(CartItems.fromJson(v));
      });
    }
    totalAmount = json['totalAmount'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['totalAmount'] = totalAmount;
    data['isActive'] = isActive;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class CartItems {
  MenuId? menuId;
  String? itemName;
  List<Size>? size;
  int? quantity;
  num? price;
  num? totalPrice;
  String? sId;

  CartItems(
      {this.menuId,
      this.itemName,
      this.size,
      this.quantity,
      this.price,
      this.totalPrice,
      this.sId});

  CartItems.fromJson(Map<String, dynamic> json) {
    menuId = json['menuId'] != null ? MenuId.fromJson(json['menuId']) : null;
    itemName = json['itemName'];
    if (json['size'] != null) {
      size = <Size>[];
      json['size'].forEach((v) {
        size!.add(Size.fromJson(v));
      });
    }
    quantity = json['quantity'];
    price = json['price'];
    totalPrice = json['totalPrice'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (menuId != null) {
      data['menuId'] = menuId!.toJson();
    }
    data['itemName'] = itemName;
    if (size != null) {
      data['size'] = size!.map((v) => v.toJson()).toList();
    }
    data['quantity'] = quantity;
    data['price'] = price;
    data['totalPrice'] = totalPrice;
    data['_id'] = sId;
    return data;
  }

  // Method to generate a JSON object with limited fields
  Map<String, dynamic> toLimitedJson() {
    return {
      'menuId': menuId?.sId, // Assuming MenuId class has an sId field
      'quantity': quantity,
      'size': size?.map((s) => {'sizeId': s.sizeId}).toList(),
    };
  }
}

class MenuId {
  String? sId;
  String? itemName;
  bool? isActive;

  MenuId({this.sId, this.itemName, this.isActive});

  MenuId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    itemName = json['itemName'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['itemName'] = itemName;
    data['isActive'] = isActive;
    return data;
  }
}

class Size {
  String? sizeId;
  String? name;
  String? volume;
  num? sizePrice;

  Size({this.sizeId, this.name, this.volume, this.sizePrice});

  Size.fromJson(Map<String, dynamic> json) {
    sizeId = json['sizeId'];
    name = json['name'];
    volume = json['volume'];
    sizePrice = json['sizePrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sizeId'] = sizeId;
    data['name'] = name;
    data['volume'] = volume;
    data['sizePrice'] = sizePrice;
    return data;
  }
}
