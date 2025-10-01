// To parse this JSON data, do
//
//     final riderRatingModel = riderRatingModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<RiderRatingModel> riderRatingModelFromJson(String str) => List<RiderRatingModel>.from(json.decode(str).map((x) => RiderRatingModel.fromJson(x)));

String riderRatingModelToJson(List<RiderRatingModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RiderRatingModel {
    final String id;
    final String riderId;
    final String userId;
    final String orderId;
    final int rating;
    final String name;
    final String comment;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    RiderRatingModel({
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

    factory RiderRatingModel.fromJson(Map<String, dynamic> json) => RiderRatingModel(
        id: json["_id"],
        riderId: json["riderId"],
        userId: json["userId"],
        orderId: json["orderId"],
        rating: json["rating"],
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
