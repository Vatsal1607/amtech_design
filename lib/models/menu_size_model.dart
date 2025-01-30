class MenuSizeModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  MenuSizeModel({this.success, this.statusCode, this.message, this.data});

  MenuSizeModel.fromJson(Map<String, dynamic> json) {
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
  String? menuId;
  String? itemName;
  List<SizeDetails>? sizeDetails;
  List<SizeDetails>? personalSizeDetails;

  Data(
      {this.menuId, this.itemName, this.sizeDetails, this.personalSizeDetails});

  Data.fromJson(Map<String, dynamic> json) {
    menuId = json['menuId'];
    itemName = json['itemName'];
    if (json['sizeDetails'] != null) {
      sizeDetails = <SizeDetails>[];
      json['sizeDetails'].forEach((v) {
        sizeDetails!.add(SizeDetails.fromJson(v));
      });
    }
    if (json['personalSizeDetails'] != null) {
      personalSizeDetails = <SizeDetails>[];
      json['personalSizeDetails'].forEach((v) {
        personalSizeDetails!.add(SizeDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menuId'] = menuId;
    data['itemName'] = itemName;
    if (sizeDetails != null) {
      data['sizeDetails'] = sizeDetails!.map((v) => v.toJson()).toList();
    }
    if (personalSizeDetails != null) {
      data['personalSizeDetails'] =
          personalSizeDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SizeDetails {
  String? sizeId;
  String? sizeName;
  String? volume;
  int? price;

  SizeDetails({this.sizeId, this.sizeName, this.volume, this.price});

  SizeDetails.fromJson(Map<String, dynamic> json) {
    sizeId = json['sizeId'];
    sizeName = json['sizeName'];
    volume = json['volume'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sizeId'] = sizeId;
    data['sizeName'] = sizeName;
    data['volume'] = volume;
    data['price'] = price;
    return data;
  }
}


// OLD
// class MenuSizeModel {
//   bool? success;
//   int? statusCode;
//   String? message;
//   Data? data;

//   MenuSizeModel({this.success, this.statusCode, this.message, this.data});

//   MenuSizeModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     statusCode = json['statusCode'];
//     message = json['message'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['success'] = success;
//     data['statusCode'] = statusCode;
//     data['message'] = message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

// class Data {
//   String? menuId;
//   String? itemName;
//   List<SizeDetails>? sizeDetails;

//   Data({this.menuId, this.itemName, this.sizeDetails});

//   Data.fromJson(Map<String, dynamic> json) {
//     menuId = json['menuId'];
//     itemName = json['itemName'];
//     if (json['sizeDetails'] != null) {
//       sizeDetails = <SizeDetails>[];
//       json['sizeDetails'].forEach((v) {
//         sizeDetails!.add(SizeDetails.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['menuId'] = menuId;
//     data['itemName'] = itemName;
//     if (sizeDetails != null) {
//       data['sizeDetails'] = sizeDetails!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class SizeDetails {
//   String? sizeId;
//   String? sizeName;
//   String? volume;
//   num? price; // Changed from double? to num?

//   SizeDetails({this.sizeId, this.sizeName, this.volume, this.price});

//   SizeDetails.fromJson(Map<String, dynamic> json) {
//     sizeId = json['sizeId'];
//     sizeName = json['sizeName'];
//     volume = json['volume'];
//     price =
//         json['price']; // No change needed as num accepts both int and double
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['sizeId'] = sizeId;
//     data['sizeName'] = sizeName;
//     data['volume'] = volume;
//     data['price'] = price; // No change needed here either
//     return data;
//   }
// }
