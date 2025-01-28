class FavoritesModel {
  bool? success;
  int? statusCode;
  String? message;
  List<FavoriteItem>? data;

  FavoritesModel({this.success, this.statusCode, this.message, this.data});

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FavoriteItem>[];
      json['data'].forEach((v) {
        data!.add(FavoriteItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FavoriteItem {
  String? sId;
  MenuDetails? menuDetails;

  FavoriteItem({this.sId, this.menuDetails});

  FavoriteItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    menuDetails = json['menuDetails'] != null
        ? MenuDetails.fromJson(json['menuDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (menuDetails != null) {
      data['menuDetails'] = menuDetails!.toJson();
    }
    return data;
  }
}

class MenuDetails {
  String? sId;
  String? itemName;
  String? images;
  List<Size>? size;

  MenuDetails({this.sId, this.itemName, this.images, this.size});

  MenuDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    itemName = json['itemName'];
    images = json['images'];
    if (json['size'] != null) {
      size = <Size>[];
      json['size'].forEach((v) {
        size!.add(Size.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['itemName'] = itemName;
    data['images'] = images;
    if (size != null) {
      data['size'] = size!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Size {
  String? sizeId;
  String? volume;
  int? sizePrice;
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
