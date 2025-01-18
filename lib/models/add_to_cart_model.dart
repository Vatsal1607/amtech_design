class AddToCartModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  AddToCartModel({this.success, this.statusCode, this.message, this.data});

  AddToCartModel.fromJson(Map<String, dynamic> json) {
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
  Cart? cart;

  Data({this.cart});

  Data.fromJson(Map<String, dynamic> json) {
    cart = json['cart'] != null ? Cart.fromJson(json['cart']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cart != null) {
      data['cart'] = cart!.toJson();
    }
    return data;
  }
}

class Cart {
  String? userId;
  List<Items>? items;
  double? totalAmount;
  bool? isActive;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Cart(
      {this.userId,
      this.items,
      this.totalAmount,
      this.isActive,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Cart.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    totalAmount = json['totalAmount'];
    isActive = json['isActive'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['totalAmount'] = totalAmount;
    data['isActive'] = isActive;
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
  int? quantity;
  double? price;
  double? totalPrice;
  String? sId;

  Items(
      {this.menuId,
      this.itemName,
      this.size,
      this.quantity,
      this.price,
      this.totalPrice,
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
    quantity = json['quantity'];
    price = json['price'];
    totalPrice = json['totalPrice'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menuId'] = menuId;
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
}

class Size {
  String? sizeId;
  String? volume;
  double? sizePrice;
  String? sId;

  Size({this.sizeId, this.volume, this.sizePrice, this.sId});

  Size.fromJson(Map<String, dynamic> json) {
    sizeId = json['sizeId'];
    volume = json['volume'];
    sizePrice = json['sizePrice'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sizeId'] = sizeId;
    data['volume'] = volume;
    data['sizePrice'] = sizePrice;
    data['_id'] = sId;
    return data;
  }
}
