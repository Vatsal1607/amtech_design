class NearByAddressModel {
  String? message;
  List<NearByAddressList>? data;

  NearByAddressModel({this.message, this.data});

  NearByAddressModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <NearByAddressList>[];
      json['data'].forEach((v) {
        data!.add(NearByAddressList.fromJson(v));
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

class NearByAddressList {
  String? name;
  String? address;
  double? lat;
  double? lng;
  String? distance;

  NearByAddressList(
      {this.name, this.address, this.lat, this.lng, this.distance});

  NearByAddressList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['address'] = address;
    data['lat'] = lat;
    data['lng'] = lng;
    data['distance'] = distance;
    return data;
  }
}
