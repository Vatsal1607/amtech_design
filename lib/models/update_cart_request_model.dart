class UpdateCartRequestModel {
  String? userId;
  String? menuId;
  List<RequestSizes>? sizes;
  int? quantity;

  UpdateCartRequestModel({this.userId, this.menuId, this.sizes, this.quantity});

  UpdateCartRequestModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    menuId = json['menuId'];
    if (json['sizes'] != null) {
      sizes = <RequestSizes>[];
      json['sizes'].forEach((v) {
        sizes!.add(RequestSizes.fromJson(v));
      });
    }
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['menuId'] = menuId;
    if (sizes != null) {
      data['sizes'] = sizes!.map((v) => v.toJson()).toList();
    }
    data['quantity'] = quantity;
    return data;
  }
}

class RequestSizes {
  String? sizeId;
  String? volume;
  double? sizePrice;

  RequestSizes({this.sizeId, this.volume, this.sizePrice});

  RequestSizes.fromJson(Map<String, dynamic> json) {
    sizeId = json['sizeId'];
    volume = json['volume'];
    sizePrice = json['sizePrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sizeId'] = sizeId;
    data['volume'] = volume;
    data['sizePrice'] = sizePrice;
    return data;
  }
}
