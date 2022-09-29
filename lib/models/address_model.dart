class AddressModel {
  late int? id;
  late String addressType;
  late String? contactPersonName;
  late String? contactPersonNumber;
  late String address;
  late String latitude;
  late String longitude;

  AddressModel({
    id,
    required addressType,
    contactPersonName,
    contactPersonNumber,
    address,
    latitude,
    longitude,
  }) {
    id = id;
    addressType = addressType;
    contactPersonName = contactPersonName;
    contactPersonNumber = contactPersonNumber;
    address = address;
    longitude = longitude;
    latitude = latitude;
  }

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressType = json['addressType'];
    contactPersonName = json['contactPersonName'] ?? '';
    contactPersonNumber = json['contactPersonNumber'] ?? '';
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
  }
}
