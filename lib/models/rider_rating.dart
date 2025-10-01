// To parse this JSON data, do
//
//     final rating = ratingFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Rating ratingFromJson(String str) => Rating.fromJson(json.decode(str));

String ratingToJson(Rating data) => json.encode(data.toJson());

class Rating {
    final String id;
    final String riderId;
    final String userId;
    final String orderId;
    final double rating;
    final String name;
    final String comment;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    Rating({
        required this.id,
        required this.riderId,
        required this.userId,
        required this.orderId,
        required this.rating,
        required this.name,
        required this.comment,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        id: json["_id"],
        riderId: json["riderId"],
        userId: json["userId"],
        orderId: json["orderId"],
        rating: json["rating"]?.toDouble(),
        name: json["name"],
        comment: json["comment"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "riderId": riderId,
        "userId": userId,
        "orderId": orderId,
        "rating": rating,
        "name": name,
        "comment": comment,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
