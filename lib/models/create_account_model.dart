// To parse this JSON data, do
//
//     final registrationModel = registrationModelFromJson(jsonString);

import 'dart:convert';

CreateAccountModel createAccountModelFromJson(String str) => CreateAccountModel.fromJson(json.decode(str));

String createAccountModelToJson(CreateAccountModel data) => json.encode(data.toJson());

class CreateAccountModel {
    final String firstName;
    final String lastName;
    final String phone;
    final String email;
    final String password;


    CreateAccountModel({
        required this.firstName,
        required this.lastName,
        required this.phone,
        required this.email,
        required this.password
    });

    factory CreateAccountModel.fromJson(Map<String, dynamic> json) => CreateAccountModel(
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        email: json["email"],
        password: json["password"]
    );

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "email": email,
        "password": password
    };
}
