class ReorderModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  ReorderModel({this.success, this.statusCode, this.message, this.data});

  ReorderModel.fromJson(Map<String, dynamic> json) {
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
  int? totalOrders;
  List<ReOrders>? reOrders;

  Data({this.totalOrders, this.reOrders});

  Data.fromJson(Map<String, dynamic> json) {
    totalOrders = json['totalOrders'];
    if (json['orders'] != null) {
      reOrders = <ReOrders>[];
      json['orders'].forEach((v) {
        reOrders!.add(ReOrders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalOrders'] = totalOrders;
    if (reOrders != null) {
      data['orders'] = reOrders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReOrders {
  String? sId;
  String? userId;
  String? userType;
  List<Items>? items;
  int? totalAmount;
  String? paymentMethod;
  String? paymentStatus;
  String? orderStatus;
  String? deliveryAddress;
  bool? isActive;
  int? orderIds;
  String? acceptedAt;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? currentStatus;

  ReOrders(
      {this.sId,
      this.userId,
      this.userType,
      this.items,
      this.totalAmount,
      this.paymentMethod,
      this.paymentStatus,
      this.orderStatus,
      this.deliveryAddress,
      this.isActive,
      this.orderIds,
      this.acceptedAt,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.currentStatus});

  ReOrders.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    userType = json['userType'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    totalAmount = json['totalAmount'];
    paymentMethod = json['paymentMethod'];
    paymentStatus = json['paymentStatus'];
    orderStatus = json['orderStatus'];
    deliveryAddress = json['deliveryAddress'];
    isActive = json['isActive'];
    orderIds = json['orderIds'];
    acceptedAt = json['acceptedAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    currentStatus = json['currentStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['userType'] = userType;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['totalAmount'] = totalAmount;
    data['paymentMethod'] = paymentMethod;
    data['paymentStatus'] = paymentStatus;
    data['orderStatus'] = orderStatus;
    data['deliveryAddress'] = deliveryAddress;
    data['isActive'] = isActive;
    data['orderIds'] = orderIds;
    data['acceptedAt'] = acceptedAt;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['currentStatus'] = currentStatus;
    return data;
  }
}

class Items {
  String? menuId;
  String? itemName;
  List<Size>? size;
  int? quantity;
  int? price;
  int? totalPrice;
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
