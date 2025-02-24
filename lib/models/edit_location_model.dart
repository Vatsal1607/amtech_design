class EditLocationModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  EditLocationModel({this.success, this.statusCode, this.message, this.data});

  EditLocationModel.fromJson(Map<String, dynamic> json) {
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
  String? sId;
  String? userId;
  String? location;
  String? company;
  num? distance;
  List<Addresses>? addresses;
  String? createdAt;
  String? updatedAt;
  int? iV;
  num? curLat;
  num? curLon;
  int? role;
  String? address;

  Data(
      {this.sId,
      this.userId,
      this.location,
      this.company,
      this.distance,
      this.addresses,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.curLat,
      this.curLon,
      this.role,
      this.address});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    location = json['location'];
    company = json['company'];

    // Handle distance safely
    distance = json['distance'] is num
        ? json['distance']
        : num.tryParse(json['distance'].toString());

    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(Addresses.fromJson(v));
      });
    }

    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];

    // Handle curLat and curLon safely
    curLat = json['curLat'] is num
        ? json['curLat']
        : num.tryParse(json['curLat'].toString());
    curLon = json['curLon'] is num
        ? json['curLon']
        : num.tryParse(json['curLon'].toString());

    role = json['role'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['location'] = location;
    data['company'] = company;
    data['distance'] = distance;
    if (addresses != null) {
      data['addresses'] = addresses!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['curLat'] = curLat;
    data['curLon'] = curLon;
    data['role'] = role;
    data['address'] = address;
    return data;
  }
}

class Addresses {
  String? propertyNumber;
  String? residentialAddress;
  String? nearLandmark;
  String? addressType;
  String? sId;

  Addresses(
      {this.propertyNumber,
      this.residentialAddress,
      this.nearLandmark,
      this.addressType,
      this.sId});

  Addresses.fromJson(Map<String, dynamic> json) {
    propertyNumber = json['propertyNumber'];
    residentialAddress = json['residentialAddress'];
    nearLandmark = json['nearLandmark'];
    addressType = json['addressType'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['propertyNumber'] = propertyNumber;
    data['residentialAddress'] = residentialAddress;
    data['nearLandmark'] = nearLandmark;
    data['addressType'] = addressType;
    data['_id'] = sId;
    return data;
  }
}
