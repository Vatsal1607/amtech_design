class BusinessListModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  BusinessListModel({this.success, this.statusCode, this.message, this.data});

  BusinessListModel.fromJson(Map<String, dynamic> json) {
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
  List<BusinessList>? businessList;
  int? totalRecords;

  Data({this.businessList, this.totalRecords});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['businessList'] != null) {
      businessList = <BusinessList>[];
      json['businessList'].forEach((v) {
        businessList!.add(BusinessList.fromJson(v));
      });
    }
    totalRecords = json['totalRecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (businessList != null) {
      data['businessList'] = businessList!.map((v) => v.toJson()).toList();
    }
    data['totalRecords'] = totalRecords;
    return data;
  }
}

class BusinessList {
  String? sId;
  String? businessName;
  String? ownerName;
  int? contact;
  String? address;
  String? role;
  bool? isActive;
  bool? isDelete;
  String? createdAt;
  String? updatedAt;
  List<SecondaryAccess>? secondaryAccess;
  String? ocupant;

  BusinessList(
      {this.sId,
      this.businessName,
      this.ownerName,
      this.contact,
      this.address,
      this.role,
      this.isActive,
      this.isDelete,
      this.createdAt,
      this.updatedAt,
      this.secondaryAccess,
      this.ocupant});

  BusinessList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    businessName = json['businessName'];
    ownerName = json['ownerName'];
    contact = json['contact'];
    address = json['address'];
    role = json['role'];
    isActive = json['isActive'];
    isDelete = json['isDelete'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['secondaryAccess'] != null) {
      secondaryAccess = <SecondaryAccess>[];
      json['secondaryAccess'].forEach((v) {
        secondaryAccess!.add(SecondaryAccess.fromJson(v));
      });
    }
    ocupant = json['ocupant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['businessName'] = businessName;
    data['ownerName'] = ownerName;
    data['contact'] = contact;
    data['address'] = address;
    data['role'] = role;
    data['isActive'] = isActive;
    data['isDelete'] = isDelete;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (secondaryAccess != null) {
      data['secondaryAccess'] =
          secondaryAccess!.map((v) => v.toJson()).toList();
    }
    data['ocupant'] = ocupant;
    return data;
  }
}

class SecondaryAccess {
  String? sId;
  String? name;
  int? contact;

  SecondaryAccess({this.sId, this.name, this.contact});

  SecondaryAccess.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    contact = json['contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['contact'] = contact;
    return data;
  }
}


/// Old model
// class BusinessListModel {
//   bool? success;
//   int? statusCode;
//   String? message;
//   Data? data;

//   BusinessListModel({this.success, this.statusCode, this.message, this.data});

//   BusinessListModel.fromJson(Map<String, dynamic> json) {
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
//   List<BusinessList>? businessList;
//   int? totalRecords;

//   Data({this.businessList, this.totalRecords});

//   Data.fromJson(Map<String, dynamic> json) {
//     if (json['businessList'] != null) {
//       businessList = <BusinessList>[];
//       json['businessList'].forEach((v) {
//         businessList!.add(BusinessList.fromJson(v));
//       });
//     }
//     totalRecords = json['totalRecords'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (businessList != null) {
//       data['businessList'] = businessList!.map((v) => v.toJson()).toList();
//     }
//     data['totalRecords'] = totalRecords;
//     return data;
//   }
// }

// class BusinessList {
//   String? sId;
//   String? businessName;
//   String? ownerName;
//   String? ocupant;
//   List<String>? images;
//   int? contact;
//   String? address;
//   String? buninessType;
//   String? role;
//   bool? isActive;
//   bool? isDelete;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;

//   BusinessList(
//       {this.sId,
//       this.businessName,
//       this.ownerName,
//       this.ocupant,
//       this.images,
//       this.contact,
//       this.address,
//       this.buninessType,
//       this.role,
//       this.isActive,
//       this.isDelete,
//       this.createdAt,
//       this.updatedAt,
//       this.iV});

//   BusinessList.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     businessName = json['businessName'];
//     ownerName = json['ownerName'];
//     ocupant = json['ocupant'];
//     if (json['images'] != null) {
//       images =
//           List<String>.from(json['images']); // Directly cast to List<String>
//     }
//     contact = json['contact'];
//     address = json['address'];
//     buninessType = json['buninessType'];
//     role = json['role'];
//     isActive = json['isActive'];
//     isDelete = json['isDelete'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['businessName'] = businessName;
//     data['ownerName'] = ownerName;
//     data['ocupant'] = ocupant;
//     if (images != null) {
//       data['images'] =
//           images; // No need to map to .toJson() as they are strings now
//     }
//     data['contact'] = contact;
//     data['address'] = address;
//     data['buninessType'] = buninessType;
//     data['role'] = role;
//     data['isActive'] = isActive;
//     data['isDelete'] = isDelete;
//     data['createdAt'] = createdAt;
//     data['updatedAt'] = updatedAt;
//     data['__v'] = iV;
//     return data;
//   }
// }
