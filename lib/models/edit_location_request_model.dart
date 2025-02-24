class EditLocationRequestModel {
  List<Addresses>? addresses;
  int? role;

  EditLocationRequestModel({this.addresses, this.role});

  EditLocationRequestModel.fromJson(Map<String, dynamic> json) {
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(Addresses.fromJson(v));
      });
    }
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (addresses != null) {
      data['addresses'] = addresses!.map((v) => v.toJson()).toList();
    }
    data['role'] = role;
    return data;
  }
}

class Addresses {
  String? propertyNumber;
  String? residentialAddress;
  String? nearLandmark;
  String? addressType;
  double? lat;
  double? long;

  Addresses({
    this.propertyNumber,
    this.residentialAddress,
    this.nearLandmark,
    this.addressType,
    this.lat,
    this.long,
  });

  Addresses.fromJson(Map<String, dynamic> json) {
    propertyNumber = json['propertyNumber'];
    residentialAddress = json['residentialAddress'];
    nearLandmark = json['nearLandmark'];
    addressType = json['addressType'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['propertyNumber'] = propertyNumber;
    data['residentialAddress'] = residentialAddress;
    data['nearLandmark'] = nearLandmark;
    data['addressType'] = addressType;
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }
}

// OLD
// class EditLocationRequestModel {
//   List<Addresses>? addresses;
//   int? role;

//   EditLocationRequestModel({this.addresses, this.role});

//   EditLocationRequestModel.fromJson(Map<String, dynamic> json) {
//     if (json['addresses'] != null) {
//       addresses = <Addresses>[];
//       json['addresses'].forEach((v) {
//         addresses!.add(Addresses.fromJson(v));
//       });
//     }
//     role = json['role'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (addresses != null) {
//       data['addresses'] = addresses!.map((v) => v.toJson()).toList();
//     }
//     data['role'] = role;
//     return data;
//   }
// }

// class Addresses {
//   String? propertyNumber;
//   String? residentialAddress;
//   String? nearLandmark;
//   String? addressType;

//   Addresses(
//       {this.propertyNumber,
//       this.residentialAddress,
//       this.nearLandmark,
//       this.addressType});

//   Addresses.fromJson(Map<String, dynamic> json) {
//     propertyNumber = json['propertyNumber'];
//     residentialAddress = json['residentialAddress'];
//     nearLandmark = json['nearLandmark'];
//     addressType = json['addressType'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['propertyNumber'] = propertyNumber;
//     data['residentialAddress'] = residentialAddress;
//     data['nearLandmark'] = nearLandmark;
//     data['addressType'] = addressType;
//     return data;
//   }
// }
