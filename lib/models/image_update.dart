// To parse this JSON data, do
//
//     final imageUpdate = imageUpdateFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ImageUpdate imageUpdateFromJson(String str) => ImageUpdate.fromJson(json.decode(str));

String imageUpdateToJson(ImageUpdate data) => json.encode(data.toJson());

class ImageUpdate {
    final String userImageUrl;

    ImageUpdate({
        required this.userImageUrl,
    });

    factory ImageUpdate.fromJson(Map<String, dynamic> json) => ImageUpdate(
        userImageUrl: json["userImageUrl"],
    );

    Map<String, dynamic> toJson() => {
        "userImageUrl": userImageUrl,
    };
}
