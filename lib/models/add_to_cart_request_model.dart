class AddToCartRequestModel {
  String? userId;
  List<RequestItems>? items;

  AddToCartRequestModel({this.userId, this.items});

  AddToCartRequestModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    if (json['items'] != null) {
      items = <RequestItems>[];
      json['items'].forEach((v) {
        items!.add(RequestItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RequestItems {
  String? menuId;
  int? quantity;
  List<RequestSize>? size;

  RequestItems({this.menuId, this.quantity, this.size});

  RequestItems.fromJson(Map<String, dynamic> json) {
    menuId = json['menuId'];
    quantity = json['quantity'];
    if (json['size'] != null) {
      size = <RequestSize>[];
      json['size'].forEach((v) {
        size!.add(RequestSize.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menuId'] = menuId;
    data['quantity'] = quantity;
    if (size != null) {
      data['size'] = size!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RequestSize {
  String? sizeId;

  RequestSize({this.sizeId});

  RequestSize.fromJson(Map<String, dynamic> json) {
    sizeId = json['sizeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sizeId'] = sizeId;
    return data;
  }
}
