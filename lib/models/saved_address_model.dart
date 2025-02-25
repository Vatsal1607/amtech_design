class SavedAddressModel {
  String? message;
  List<Data>? data;

  SavedAddressModel({this.message, this.data});

  SavedAddressModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? propertyNumber;
  String? residentialAddress;
  String? nearLandmark;
  String? addressType;
  String? lat;
  String? long;
  String? sId;
  String? distance;

  Data(
      {this.propertyNumber,
      this.residentialAddress,
      this.nearLandmark,
      this.addressType,
      this.lat,
      this.long,
      this.sId,
      this.distance});

  Data.fromJson(Map<String, dynamic> json) {
    propertyNumber = json['propertyNumber'];
    residentialAddress = json['residentialAddress'];
    nearLandmark = json['nearLandmark'];
    addressType = json['addressType'];
    lat = json['lat'];
    long = json['long'];
    sId = json['_id'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['propertyNumber'] = propertyNumber;
    data['residentialAddress'] = residentialAddress;
    data['nearLandmark'] = nearLandmark;
    data['addressType'] = addressType;
    data['lat'] = lat;
    data['long'] = long;
    data['_id'] = sId;
    data['distance'] = distance;
    return data;
  }
}
