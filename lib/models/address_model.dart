// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AddressModel addressModelFromJson(String str) => AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
    final bool status;
    final Address address;

    AddressModel({
        required this.status,
        required this.address,
    });

    factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        status: json["status"],
        address: Address.fromJson(json["address"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "address": address.toJson(),
    };
}

class Address {
    final String id;
    final String userId;
    final String addressLine1;
    final String postalCode;
    final bool addressDefault;
    final String deliveryInstructions;
    final double latitude;
    final double longitude;
    final DateTime createdAt;
    final DateTime updatedAt;

    Address({
        required this.id,
        required this.userId,
        required this.addressLine1,
        required this.postalCode,
        required this.addressDefault,
        required this.deliveryInstructions,
        required this.latitude,
        required this.longitude,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["_id"],
        userId: json["userId"],
        addressLine1: json["addressLine1"],
        postalCode: json["postalCode"],
        addressDefault: json["default"],
        deliveryInstructions: json["deliveryInstructions"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "addressLine1": addressLine1,
        "postalCode": postalCode,
        "default": addressDefault,
        "deliveryInstructions": deliveryInstructions,
        "latitude": latitude,
        "longitude": longitude,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
