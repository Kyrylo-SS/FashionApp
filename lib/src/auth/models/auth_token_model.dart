import 'dart:convert';

AuthTokenModel authTokenModelFromJson(String str) =>
    AuthTokenModel.fromJson(json.decode(str));

String authTokenModelToJson(AuthTokenModel data) => json.encode(data.toJson());

class AuthTokenModel {
  String authToken;

  AuthTokenModel({required this.authToken});

  factory AuthTokenModel.fromJson(Map<String, dynamic> json) =>
      AuthTokenModel(authToken: json["auth_token"]);

  Map<String, dynamic> toJson() => {"auth_token": authToken};
}
