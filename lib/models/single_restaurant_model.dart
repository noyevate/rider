// To parse this JSON data, do
//
//     final singleRestaurantModel = singleRestaurantModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SingleRestaurantModel singleRestaurantModelFromJson(String str) => SingleRestaurantModel.fromJson(json.decode(str));

String singleRestaurantModelToJson(SingleRestaurantModel data) => json.encode(data.toJson());

class SingleRestaurantModel {
    final Coords coords;
    final String id;
    final String title;
    final List<Time> time;
    final String imageUrl;
    final List<String> foods;
    final bool pickup;
    final String restaurantMail;
    final bool delivery;
    final bool isAvailabe;
    final String phone;
    final String code;
    final String logoUrl;
    final String userId;
    final double rating;
    final String ratingCount;
    final String verification;
    final String verificationMessage;
    final List<RestaurantCategory> restaurantCategories;
    final DateTime createdAt;
    final DateTime updatedAt;
    final String restaurantFcm;
    final String accountName;
    final String accountNumber;
    final String bank;

    SingleRestaurantModel({
        required this.coords,
        required this.id,
        required this.title,
        required this.time,
        required this.imageUrl,
        required this.foods,
        required this.pickup,
        required this.restaurantMail,
        required this.delivery,
        required this.isAvailabe,
        required this.phone,
        required this.code,
        required this.logoUrl,
        required this.userId,
        required this.rating,
        required this.ratingCount,
        required this.verification,
        required this.verificationMessage,
        required this.restaurantCategories,
        required this.createdAt,
        required this.updatedAt,
        required this.restaurantFcm,
        required this.accountName,
        required this.accountNumber,
        required this.bank,
    });

    factory SingleRestaurantModel.fromJson(Map<String, dynamic> json) => SingleRestaurantModel(
        coords: Coords.fromJson(json["coords"]),
        id: json["_id"],
        title: json["title"],
        time: List<Time>.from(json["time"].map((x) => Time.fromJson(x))),
        imageUrl: json["imageUrl"],
        foods: List<String>.from(json["foods"].map((x) => x)),
        pickup: json["pickup"],
        restaurantMail: json["restaurantMail"],
        delivery: json["delivery"],
        isAvailabe: json["isAvailabe"],
        phone: json["phone"],
        code: json["code"],
        logoUrl: json["logoUrl"],
        userId: json["userId"],
        rating: json["rating"]?.toDouble(),
        ratingCount: json["ratingCount"],
        verification: json["verification"],
        verificationMessage: json["verificationMessage"],
        restaurantCategories: List<RestaurantCategory>.from(json["restaurant_categories"].map((x) => RestaurantCategory.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        restaurantFcm: json["restaurantFcm"],
        accountName: json["accountName"],
        accountNumber: json["accountNumber"],
        bank: json["bank"],
    );

    Map<String, dynamic> toJson() => {
        "coords": coords.toJson(),
        "_id": id,
        "title": title,
        "time": List<dynamic>.from(time.map((x) => x.toJson())),
        "imageUrl": imageUrl,
        "foods": List<dynamic>.from(foods.map((x) => x)),
        "pickup": pickup,
        "restaurantMail": restaurantMail,
        "delivery": delivery,
        "isAvailabe": isAvailabe,
        "phone": phone,
        "code": code,
        "logoUrl": logoUrl,
        "userId": userId,
        "rating": rating,
        "ratingCount": ratingCount,
        "verification": verification,
        "verificationMessage": verificationMessage,
        "restaurant_categories": List<dynamic>.from(restaurantCategories.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "restaurantFcm": restaurantFcm,
        "accountName": accountName,
        "accountNumber": accountNumber,
        "bank": bank,
    };
}

class Coords {
    final String id;
    final double latitude;
    final double longitude;
    final String address;
    final String title;
    final double latitudeDelta;
    final double longitudeDelta;

    Coords({
        required this.id,
        required this.latitude,
        required this.longitude,
        required this.address,
        required this.title,
        required this.latitudeDelta,
        required this.longitudeDelta,
    });

    factory Coords.fromJson(Map<String, dynamic> json) => Coords(
        id: json["id"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        address: json["address"],
        title: json["title"],
        latitudeDelta: json["latitudeDelta"]?.toDouble(),
        longitudeDelta: json["longitudeDelta"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "title": title,
        "latitudeDelta": latitudeDelta,
        "longitudeDelta": longitudeDelta,
    };
}

class RestaurantCategory {
    final String name;
    final List<Additive> additives;
    final String id;

    RestaurantCategory({
        required this.name,
        required this.additives,
        required this.id,
    });

    factory RestaurantCategory.fromJson(Map<String, dynamic> json) => RestaurantCategory(
        name: json["name"],
        additives: List<Additive>.from(json["additives"].map((x) => Additive.fromJson(x))),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "additives": List<dynamic>.from(additives.map((x) => x.toJson())),
        "_id": id,
    };
}

class Additive {
    final String additiveId;
    final String restaurantId;
    final String additiveTitle;
    final List<Option> options;
    final int max;
    final int min;
    final bool isAvailable;

    Additive({
        required this.additiveId,
        required this.restaurantId,
        required this.additiveTitle,
        required this.options,
        required this.max,
        required this.min,
        required this.isAvailable,
    });

    factory Additive.fromJson(Map<String, dynamic> json) => Additive(
        additiveId: json["additiveId"],
        restaurantId: json["restaurantId"],
        additiveTitle: json["additiveTitle"],
        options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
        max: json["max"],
        min: json["min"],
        isAvailable: json["isAvailable"],
    );

    Map<String, dynamic> toJson() => {
        "additiveId": additiveId,
        "restaurantId": restaurantId,
        "additiveTitle": additiveTitle,
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
        "max": max,
        "min": min,
        "isAvailable": isAvailable,
    };
}

class Option {
    final String id;
    final String additiveName;
    final int price;
    final bool isAvailable;

    Option({
        required this.id,
        required this.additiveName,
        required this.price,
        required this.isAvailable,
    });

    factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"],
        additiveName: json["additiveName"],
        price: json["price"],
        isAvailable: json["isAvailable"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "additiveName": additiveName,
        "price": price,
        "isAvailable": isAvailable,
    };
}

class Time {
    final String orderType;
    final String day;
    final String open;
    final String close;
    final dynamic orderCutOffTime;
    final dynamic menuReadyTime;

    Time({
        required this.orderType,
        required this.day,
        required this.open,
        required this.close,
        required this.orderCutOffTime,
        required this.menuReadyTime,
    });

    factory Time.fromJson(Map<String, dynamic> json) => Time(
        orderType: json["orderType"],
        day: json["day"],
        open: json["open"],
        close: json["close"],
        orderCutOffTime: json["orderCutOffTime"],
        menuReadyTime: json["menuReadyTime"],
    );

    Map<String, dynamic> toJson() => {
        "orderType": orderType,
        "day": day,
        "open": open,
        "close": close,
        "orderCutOffTime": orderCutOffTime,
        "menuReadyTime": menuReadyTime,
    };
}
