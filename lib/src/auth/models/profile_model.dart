// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  String email;
  String username;

  ProfileModel({required this.email, required this.username});

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      ProfileModel(email: json["email"], username: json["username"]);

  Map<String, dynamic> toJson() => {"email": email, "username": username};
}
