


// // To parse this JSON data, do
// //
// //     final orderModel = orderModelFromJson(jsonString);

// import 'package:meta/meta.dart';
// import 'dart:convert';

// List<OrderModel> orderModelFromJson(String str) => List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

// String orderModelToJson(List<OrderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class OrderModel {
//     final String id;
//     final String userId;
//     final List<OrderItem> orderItems;
//     final int orderTotal;
//     final int orderSubId;
//     final int deliveryFee;
//     final int grandTotal;
//     final String deliveryAddress;
//     final String restaurantAddress;
//     final String paymentMethod;
//     final String paymentStatus;
//     final String orderStatus;
//     final String restaurantId;
//     final List<double> restaurantCoords;
//     final List<double> recipientCoords;
//     final String driverId;
//     final int rating;
//     final String feedback;
//     final String promoCode;
//     final String customerName;
//     final String customerPhone;
//     final int discountAmount;
//     final String notes;
//     final DateTime createdAt;
//     final DateTime updatedAt;
//     final List<String> rejectedBy;
//     final bool riderAssigned;
//     final String riderStatus;

//     OrderModel({
//         required this.id,
//         required this.userId,
//         required this.orderItems,
//         required this.orderTotal,
//         required this.orderSubId,
//         required this.deliveryFee,
//         required this.grandTotal,
//         required this.deliveryAddress,
//         required this.restaurantAddress,
//         required this.paymentMethod,
//         required this.paymentStatus,
//         required this.orderStatus,
//         required this.restaurantId,
//         required this.restaurantCoords,
//         required this.recipientCoords,
//         required this.driverId,
//         required this.rating,
//         required this.feedback,
//         required this.promoCode,
//         required this.customerName,
//         required this.customerPhone,
//         required this.discountAmount,
//         required this.notes,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.rejectedBy,
//         required this.riderAssigned,
//         required this.riderStatus,
//     });

//     factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
//         id: json["_id"],
//         userId: json["userId"],
//         orderItems: List<OrderItem>.from(json["orderItems"].map((x) => OrderItem.fromJson(x))),
//         orderTotal: json["orderTotal"],
//         orderSubId: json["orderSubId"],
//         deliveryFee: json["deliveryFee"],
//         grandTotal: json["grandTotal"],
//         deliveryAddress: json["deliveryAddress"],
//         restaurantAddress: json["restaurantAddress"],
//         paymentMethod: json["paymentMethod"],
//         paymentStatus: json["paymentStatus"],
//         orderStatus: json["orderStatus"],
//         restaurantId: json["restaurantId"],
//         restaurantCoords: List<double>.from(json["restaurantCoords"].map((x) => x?.toDouble())),
//         recipientCoords: List<double>.from(json["recipientCoords"].map((x) => x?.toDouble())),
//         driverId: json["driverId"],
//         rating: json["rating"],
//         feedback: json["feedback"],
//         promoCode: json["PromoCode"],
//         customerName: json["customerName"],
//         customerPhone: json["customerPhone"],
//         discountAmount: json["discountAmount"],
//         notes: json["notes"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         rejectedBy: List<String>.from(json["rejectedBy"].map((x) => x)),
//         riderAssigned: json["riderAssigned"],
//         riderStatus: json["riderStatus"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "userId": userId,
//         "orderItems": List<dynamic>.from(orderItems.map((x) => x.toJson())),
//         "orderTotal": orderTotal,
//         "orderSubId": orderSubId,
//         "deliveryFee": deliveryFee,
//         "grandTotal": grandTotal,
//         "deliveryAddress": deliveryAddress,
//         "restaurantAddress": restaurantAddress,
//         "paymentMethod": paymentMethod,
//         "paymentStatus": paymentStatus,
//         "orderStatus": orderStatus,
//         "restaurantId": restaurantId,
//         "restaurantCoords": List<dynamic>.from(restaurantCoords.map((x) => x)),
//         "recipientCoords": List<dynamic>.from(recipientCoords.map((x) => x)),
//         "driverId": driverId,
//         "rating": rating,
//         "feedback": feedback,
//         "PromoCode": promoCode,
//         "customerName": customerName,
//         "customerPhone": customerPhone,
//         "discountAmount": discountAmount,
//         "notes": notes,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "rejectedBy": List<dynamic>.from(rejectedBy.map((x) => x)),
//         "riderAssigned": riderAssigned,
//         "riderStatus": riderStatus,
//     };
// }

// class OrderItem {
//     final String foodId;
//     final List<Additive> additives;
//     final String instruction;
//     final int numberOfPack;
//     final String id;
//     final DateTime createdAt;
//     final DateTime updatedAt;

//     OrderItem({
//         required this.foodId,
//         required this.additives,
//         required this.instruction,
//         required this.numberOfPack,
//         required this.id,
//         required this.createdAt,
//         required this.updatedAt,
//     });

//     factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
//         foodId: json["foodId"],
//         additives: List<Additive>.from(json["additives"].map((x) => Additive.fromJson(x))),
//         instruction: json["instruction"],
//         numberOfPack: json["numberOfPack"],
//         id: json["_id"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "foodId": foodId,
//         "additives": List<dynamic>.from(additives.map((x) => x.toJson())),
//         "instruction": instruction,
//         "numberOfPack": numberOfPack,
//         "_id": id,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//     };
// }

// class Additive {
//     final String foodTitle;
//     final int foodPrice;
//     final int foodCount;
//     final String name;
//     final int price;
//     final int quantity;
//     final int packCount;

//     Additive({
//         required this.foodTitle,
//         required this.foodPrice,
//         required this.foodCount,
//         required this.name,
//         required this.price,
//         required this.quantity,
//         required this.packCount,
//     });

//     factory Additive.fromJson(Map<String, dynamic> json) => Additive(
//         foodTitle: json["foodTitle"],
//         foodPrice: json["foodPrice"],
//         foodCount: json["foodCount"],
//         name: json["name"],
//         price: json["price"],
//         quantity: json["quantity"],
//         packCount: json["packCount"],
//     );

//     Map<String, dynamic> toJson() => {
//         "foodTitle": foodTitle,
//         "foodPrice": foodPrice,
//         "foodCount": foodCount,
//         "name": name,
//         "price": price,
//         "quantity": quantity,
//         "packCount": packCount,
//     };
// }


// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<OrderModel> orderModelFromJson(String str) => List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String orderModelToJson(List<OrderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel {
    final String riderFcm;
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
    final String riderId;
    final int rating;
    final String feedback;
    final String promoCode;
    final String customerName;
    final String customerPhone;
    final int discountAmount;
    final String notes;
    final DateTime createdAt;
    final DateTime updatedAt;
    final List<dynamic> rejectedBy;
    final bool riderAssigned;
    final String riderStatus;
    final String customerFcm;
    final String restaurantFcm;

    OrderModel({
        required this.riderFcm,
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
        required this.riderId,
        required this.rating,
        required this.feedback,
        required this.promoCode,
        required this.customerName,
        required this.customerPhone,
        required this.discountAmount,
        required this.notes,
        required this.createdAt,
        required this.updatedAt,
        required this.rejectedBy,
        required this.riderAssigned,
        required this.riderStatus,
        required this.customerFcm,
        required this.restaurantFcm,
    });

    factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        riderFcm: json["riderFcm"],
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
        riderId: json["riderId"],
        rating: json["rating"],
        feedback: json["feedback"],
        promoCode: json["PromoCode"],
        customerName: json["customerName"],
        customerPhone: json["customerPhone"],
        discountAmount: json["discountAmount"],
        notes: json["notes"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        rejectedBy: List<dynamic>.from(json["rejectedBy"].map((x) => x)),
        riderAssigned: json["riderAssigned"],
        riderStatus: json["riderStatus"],
        customerFcm: json["customerFcm"],
        restaurantFcm: json["restaurantFcm"],
    );

    Map<String, dynamic> toJson() => {
        "riderFcm": riderFcm,
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
        "riderId": riderId,
        "rating": rating,
        "feedback": feedback,
        "PromoCode": promoCode,
        "customerName": customerName,
        "customerPhone": customerPhone,
        "discountAmount": discountAmount,
        "notes": notes,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "rejectedBy": List<dynamic>.from(rejectedBy.map((x) => x)),
        "riderAssigned": riderAssigned,
        "riderStatus": riderStatus,
        "customerFcm": customerFcm,
        "restaurantFcm": restaurantFcm,
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
