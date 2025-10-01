// To parse this JSON data, do
//
//     final tripHistoryModel = tripHistoryModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<TripHistoryModel> tripHistoryModelFromJson(String str) => List<TripHistoryModel>.from(json.decode(str).map((x) => TripHistoryModel.fromJson(x)));

String tripHistoryModelToJson(List<TripHistoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TripHistoryModel {
    final String id;
    final String userId;
    final List<OrderItem> orderItems;
    final int orderTotal;
    final int orderSubId;
    final int deliveryFee;
    final int grandTotal;
    final String deliveryAddress;
    final String restaurantAddress;
    final String paymentMethod;
    final String paymentStatus;
    final String orderStatus;
    final String restaurantId;
    final List<double> restaurantCoords;
    final List<double> recipientCoords;
    final String driverId;
    final int rating;
    final String feedback;
    final String promoCode;
    final String customerName;
    final String customerPhone;
    final int discountAmount;
    final String notes;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;
    final List<dynamic> rejectedBy;
    final bool riderAssigned;
    final String riderStatus;
    final RiderRating? riderRating;

    TripHistoryModel({
        required this.id,
        required this.userId,
        required this.orderItems,
        required this.orderTotal,
        required this.orderSubId,
        required this.deliveryFee,
        required this.grandTotal,
        required this.deliveryAddress,
        required this.restaurantAddress,
        required this.paymentMethod,
        required this.paymentStatus,
        required this.orderStatus,
        required this.restaurantId,
        required this.restaurantCoords,
        required this.recipientCoords,
        required this.driverId,
        required this.rating,
        required this.feedback,
        required this.promoCode,
        required this.customerName,
        required this.customerPhone,
        required this.discountAmount,
        required this.notes,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.rejectedBy,
        required this.riderAssigned,
        required this.riderStatus,
        this.riderRating,
    });

    factory TripHistoryModel.fromJson(Map<String, dynamic> json) => TripHistoryModel(
        id: json["_id"],
        userId: json["userId"],
        orderItems: List<OrderItem>.from(json["orderItems"].map((x) => OrderItem.fromJson(x))),
        orderTotal: json["orderTotal"],
        orderSubId: json["orderSubId"],
        deliveryFee: json["deliveryFee"],
        grandTotal: json["grandTotal"],
        deliveryAddress: json["deliveryAddress"],
        restaurantAddress: json["restaurantAddress"],
        paymentMethod: json["paymentMethod"],
        paymentStatus: json["paymentStatus"],
        orderStatus: json["orderStatus"],
        restaurantId: json["restaurantId"],
        restaurantCoords: List<double>.from(json["restaurantCoords"].map((x) => x?.toDouble())),
        recipientCoords: List<double>.from(json["recipientCoords"].map((x) => x?.toDouble())),
        driverId: json["driverId"],
        rating: json["rating"],
        feedback: json["feedback"],
        promoCode: json["PromoCode"],
        customerName: json["customerName"],
        customerPhone: json["customerPhone"],
        discountAmount: json["discountAmount"],
        notes: json["notes"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        rejectedBy: List<dynamic>.from(json["rejectedBy"].map((x) => x)),
        riderAssigned: json["riderAssigned"],
        riderStatus: json["riderStatus"],
        riderRating: json["riderRating"] != null ? RiderRating.fromJson(json["riderRating"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "orderItems": List<dynamic>.from(orderItems.map((x) => x.toJson())),
        "orderTotal": orderTotal,
        "orderSubId": orderSubId,
        "deliveryFee": deliveryFee,
        "grandTotal": grandTotal,
        "deliveryAddress": deliveryAddress,
        "restaurantAddress": restaurantAddress,
        "paymentMethod": paymentMethod,
        "paymentStatus": paymentStatus,
        "orderStatus": orderStatus,
        "restaurantId": restaurantId,
        "restaurantCoords": List<dynamic>.from(restaurantCoords.map((x) => x)),
        "recipientCoords": List<dynamic>.from(recipientCoords.map((x) => x)),
        "driverId": driverId,
        "rating": rating,
        "feedback": feedback,
        "PromoCode": promoCode,
        "customerName": customerName,
        "customerPhone": customerPhone,
        "discountAmount": discountAmount,
        "notes": notes,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "rejectedBy": List<dynamic>.from(rejectedBy.map((x) => x)),
        "riderAssigned": riderAssigned,
        "riderStatus": riderStatus,
        "riderRating": riderRating?.toJson(),
    };
}

class OrderItem {
    final String foodId;
    final List<Additive> additives;
    final String instruction;
    final int numberOfPack;
    final String id;
    final DateTime createdAt;
    final DateTime updatedAt;

    OrderItem({
        required this.foodId,
        required this.additives,
        required this.instruction,
        required this.numberOfPack,
        required this.id,
        required this.createdAt,
        required this.updatedAt,
    });

    factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        foodId: json["foodId"],
        additives: List<Additive>.from(json["additives"].map((x) => Additive.fromJson(x))),
        instruction: json["instruction"],
        numberOfPack: json["numberOfPack"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "foodId": foodId,
        "additives": List<dynamic>.from(additives.map((x) => x.toJson())),
        "instruction": instruction,
        "numberOfPack": numberOfPack,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}

class Additive {
    final String foodTitle;
    final int foodPrice;
    final int foodCount;
    final String name;
    final int price;
    final int quantity;
    final int packCount;

    Additive({
        required this.foodTitle,
        required this.foodPrice,
        required this.foodCount,
        required this.name,
        required this.price,
        required this.quantity,
        required this.packCount,
    });

    factory Additive.fromJson(Map<String, dynamic> json) => Additive(
        foodTitle: json["foodTitle"],
        foodPrice: json["foodPrice"],
        foodCount: json["foodCount"],
        name: json["name"],
        price: json["price"],
        quantity: json["quantity"],
        packCount: json["packCount"],
    );

    Map<String, dynamic> toJson() => {
        "foodTitle": foodTitle,
        "foodPrice": foodPrice,
        "foodCount": foodCount,
        "name": name,
        "price": price,
        "quantity": quantity,
        "packCount": packCount,
    };
}

class RiderRating {
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

    RiderRating({
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

    factory RiderRating.fromJson(Map<String, dynamic> json) => RiderRating(
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
