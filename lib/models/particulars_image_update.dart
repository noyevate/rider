// To parse this JSON data, do
//
//     final imageUpdate = imageUpdateFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ParticularImageUpdate particularImageUpdateFromJson(String str) => ParticularImageUpdate.fromJson(json.decode(str));

String particularImageUpdateToJson(ParticularImageUpdate data) => json.encode(data.toJson());

class ParticularImageUpdate {
    final String particularsImageUrl;

    ParticularImageUpdate({
        required this.particularsImageUrl,
    });

    factory ParticularImageUpdate.fromJson(Map<String, dynamic> json) => ParticularImageUpdate(
        particularsImageUrl: json["particularsImageUrl"],
    );

    Map<String, dynamic> toJson() => {
        "particularsImageUrl": particularsImageUrl,
    };
}
