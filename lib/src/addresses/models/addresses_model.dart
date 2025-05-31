import 'dart:convert';

List<AddressModel> addressListFromJson(String str) => List<AddressModel>.from(
  json.decode(str).map((x) => AddressModel.fromJson(x)),
);

AddressModel addressModelFromJson(String str) =>
    AddressModel.fromJson(json.decode(str));

class AddressModel {
  int id;
  double lat;
  double lng;
  bool isDefault;
  String address;
  String phone;
  String addressType;
  int userId;

  AddressModel({
    required this.id,
    required this.lat,
    required this.lng,
    required this.isDefault,
    required this.address,
    required this.phone,
    required this.addressType,
    required this.userId,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    id: json["id"],
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
    isDefault: json["isDefault"],
    address: json["address"],
    phone: json["phone"],
    addressType: json["addressType"],
    userId: json["userId"],
  );
}
