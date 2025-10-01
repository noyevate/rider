// To parse this JSON data, do
//
//     final imageUpdate = imageUpdateFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

VehicleImageUrl vehicleImageUrl(String str) => VehicleImageUrl.fromJson(json.decode(str));

String vehicleImageUrlToJson(VehicleImageUrl data) => json.encode(data.toJson());

class VehicleImageUrl {
    final String vehicleImgUrl;

    VehicleImageUrl({
        required this.vehicleImgUrl,
    });

    factory VehicleImageUrl.fromJson(Map<String, dynamic> json) => VehicleImageUrl(
        vehicleImgUrl: json["vehicleImgUrl"],
    );

    Map<String, dynamic> toJson() => {
        "vehicleImgUrl": vehicleImgUrl,
    };
}
