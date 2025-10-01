// To parse this JSON data, do
//
//     final imageUpdate = imageUpdateFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DriverLicienceUpdateUrl driverLicienceUpdateUrlFromJson(String str) => DriverLicienceUpdateUrl.fromJson(json.decode(str));

String driverLicienceUpdateUrlToJson(DriverLicienceUpdateUrl data) => json.encode(data.toJson());

class DriverLicienceUpdateUrl {
    final String driverLicenseImageUrl;

    DriverLicienceUpdateUrl({
        required this.driverLicenseImageUrl,
    });

    factory DriverLicienceUpdateUrl.fromJson(Map<String, dynamic> json) => DriverLicienceUpdateUrl(
        driverLicenseImageUrl: json["driverLicenseImageUrl"],
    );

    Map<String, dynamic> toJson() => {
        "driverLicenseImageUrl": driverLicenseImageUrl,
    };
}
