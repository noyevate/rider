// To parse this JSON data, do
//
//     final loginInputModel = loginInputModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LoginInputModel loginInputModelFromJson(String str) => LoginInputModel.fromJson(json.decode(str));

String loginInputModelToJson(LoginInputModel data) => json.encode(data.toJson());

class LoginInputModel {
    final String email;
    final String password;

    LoginInputModel({
        required this.email,
        required this.password,
    });

    factory LoginInputModel.fromJson(Map<String, dynamic> json) => LoginInputModel(
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
    };
}
