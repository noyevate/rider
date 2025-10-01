// To parse this JSON data, do
//
//     final createRiderModel = createRiderModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CreateRiderModel createRiderModelFromJson(String str) => CreateRiderModel.fromJson(json.decode(str));

String createRiderModelToJson(CreateRiderModel data) => json.encode(data.toJson());

class CreateRiderModel {
    final String userId;
    final String vehicleImgUrl;
    final String vehicleType;
    final String vehicleBrand;
    final String plateNumber;
    final List<Guarantor> guarantors;
    final String bankName;
    final String bankAccount;
    final String bankAccountName;
    final WorkDays workDays;
    final String userImageUrl;
    final double rating;
    final int ratingCount;
    final String verification;
    final String verificationMessage;
    final Coords coords;

    CreateRiderModel({
        required this.userId,
        required this.vehicleImgUrl,
        required this.vehicleType,
        required this.vehicleBrand,
        required this.plateNumber,
        required this.guarantors,
        required this.bankName,
        required this.bankAccount,
        required this.bankAccountName,
        required this.workDays,
        required this.userImageUrl,
        required this.rating,
        required this.ratingCount,
        required this.verification,
        required this.verificationMessage,
        required this.coords,
    });

    factory CreateRiderModel.fromJson(Map<String, dynamic> json) => CreateRiderModel(
        userId: json["userId"],
        vehicleImgUrl: json["vehicleImgUrl"],
        vehicleType: json["vehicleType"],
        vehicleBrand: json["vehicleBrand"],
        plateNumber: json["plateNumber"],
        guarantors: List<Guarantor>.from(json["guarantors"].map((x) => Guarantor.fromJson(x))),
        bankName: json["bankName"],
        bankAccount: json["bankAccount"],
        bankAccountName: json["bankAccountName"],
        workDays: WorkDays.fromJson(json["workDays"]),
        userImageUrl: json["userImageUrl"],
        rating: json["rating"]?.toDouble(),
        ratingCount: json["ratingCount"],
        verification: json["verification"],
        verificationMessage: json["verificationMessage"],
        coords: Coords.fromJson(json["coords"]),
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "vehicleImgUrl": vehicleImgUrl,
        "vehicleType": vehicleType,
        "vehicleBrand": vehicleBrand,
        "plateNumber": plateNumber,
        "guarantors": List<dynamic>.from(guarantors.map((x) => x.toJson())),
        "bankName": bankName,
        "bankAccount": bankAccount,
        "bankAccountName": bankAccountName,
        "workDays": workDays.toJson(),
        "userImageUrl": userImageUrl,
        "rating": rating,
        "ratingCount": ratingCount,
        "verification": verification,
        "verificationMessage": verificationMessage,
        "coords": coords.toJson(),
    };
}

class Coords {
    final double latitude;
    final double longitude;
    final double latitudeDelta;
    final double longitudeDelta;
    final String postalCode;
    final String title;

    Coords({
        required this.latitude,
        required this.longitude,
        required this.latitudeDelta,
        required this.longitudeDelta,
        required this.postalCode,
        required this.title,
    });

    factory Coords.fromJson(Map<String, dynamic> json) => Coords(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        latitudeDelta: json["latitudeDelta"]?.toDouble(),
        longitudeDelta: json["longitudeDelta"]?.toDouble(),
        postalCode: json["postalCode"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "latitudeDelta": latitudeDelta,
        "longitudeDelta": longitudeDelta,
        "postalCode": postalCode,
        "title": title,
    };
}

class Guarantor {
    final String name;
    final String phone;
    final String relationship;

    Guarantor({
        required this.name,
        required this.phone,
        required this.relationship,
    });

    factory Guarantor.fromJson(Map<String, dynamic> json) => Guarantor(
        name: json["name"],
        phone: json["phone"],
        relationship: json["relationship"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "relationship": relationship,
    };
}

class WorkDays {
    final List<String> morningShifts;
    final List<String> afternoonShift;

    WorkDays({
        required this.morningShifts,
        required this.afternoonShift,
    });

    factory WorkDays.fromJson(Map<String, dynamic> json) => WorkDays(
        morningShifts: List<String>.from(json["morningShifts"].map((x) => x)),
        afternoonShift: List<String>.from(json["afternoonShift"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "morningShifts": List<dynamic>.from(morningShifts.map((x) => x)),
        "afternoonShift": List<dynamic>.from(afternoonShift.map((x) => x)),
    };
}
