class LocationModel {
  String? message;
  Data? data;

  LocationModel({this.message, this.data});

  LocationModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? userId;
  String? userName;
  String? socketId;
  num? latitude;
  num? longitude;
  String? address;
  String? city;
  String? country;
  num? pincode;
  num? distance;

  Data({
    this.userId,
    this.userName,
    this.socketId,
    this.latitude,
    this.longitude,
    this.address,
    this.city,
    this.country,
    this.pincode,
    this.distance,
  });

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    socketId = json['socketId'];
    latitude = json['latitude'] != null
        ? num.tryParse(json['latitude'].toString())
        : null;
    longitude = json['longitude'] != null
        ? num.tryParse(json['longitude'].toString())
        : null;
    address = json['address'];
    city = json['city'];
    country = json['country'];
    pincode = json['pincode'] != null
        ? num.tryParse(json['pincode'].toString())
        : null;
    distance = json['distance'] != null
        ? num.tryParse(json['distance'].toString())
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['userName'] = userName;
    data['socketId'] = socketId;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['address'] = address;
    data['city'] = city;
    data['country'] = country;
    data['pincode'] = pincode;
    data['distance'] = distance;
    return data;
  }
}
