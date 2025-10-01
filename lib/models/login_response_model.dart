

import 'package:meta/meta.dart';
import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());


class LoginResponse {
  final String id;
    final String firstName;
    final String lastName;
    final String email;
    final String fcm;
    final String pin;
    final bool verification;
    final String phone;
    final bool phoneVerification;
    final String userType;
    final int v;
    final Rider? rider;
    final String userToken;



  LoginResponse({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.fcm,
    required this.pin,
    required this.verification,
    required this.phone,
    required this.phoneVerification,
    required this.userType,
    required this.v,
    required this.userToken,
    this.rider, // ✅ Rider can be null
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        id: json["_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        fcm: json["fcm"],
        pin: json["pin"],
        verification: json["verification"],
        phone: json["phone"],
        phoneVerification: json["phoneVerification"],
        userType: json["userType"],
        v: json["__v"],
        userToken: json["userToken"],
        rider: json["rider"] != null ? Rider.fromJson(json["rider"]) : null, // ✅ Handle null rider
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "fcm": fcm,
        "pin": pin,
        "verification": verification,
        "phone": phone,
        "phoneVerification": phoneVerification,
        "userType": userType,
        "__v": v,
        "userToken": userToken,
        "rider": rider?.toJson(), // ✅ Convert to JSON only if not null
      };
}



class Rider {
    final String id;
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
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;
    final String driverLicenseImageUrl;
    final String particularsImageUrl;

    Rider({
        required this.id,
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
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.driverLicenseImageUrl,
        required this.particularsImageUrl,
    });

    factory Rider.fromJson(Map<String, dynamic> json) => Rider(
        id: json["_id"],
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
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        driverLicenseImageUrl: json["driverLicenseImageUrl"],
        particularsImageUrl: json["particularsImageUrl"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
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
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "driverLicenseImageUrl": driverLicenseImageUrl,
        "particularsImageUrl": particularsImageUrl,
    };
}

class Coords {
    final double latitude;
    final double longitude;
    final double latitudeDelta;
    final double longitudeDelta;
    final int postalCode;
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
