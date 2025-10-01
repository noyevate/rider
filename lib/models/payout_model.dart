// To parse this JSON data, do
//
//     final payoutModel = payoutModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PayoutModel payoutModelFromJson(String str) => PayoutModel.fromJson(json.decode(str));

String payoutModelToJson(PayoutModel data) => json.encode(data.toJson());

class PayoutModel {
    final int amount;
    final String accountBank;
    final String accountNumber;
    final String narration;
    final String full_name;

    PayoutModel({
        required this.amount,
        required this.accountBank,
        required this.accountNumber,
        required this.narration,
        required this.full_name,
    });

    factory PayoutModel.fromJson(Map<String, dynamic> json) => PayoutModel(
        amount: json["amount"],
        accountBank: json["account_bank"],
        accountNumber: json["account_number"],
        narration: json["narration"],
        full_name: json["full_name"],
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "account_bank": accountBank,
        "account_number": accountNumber,
        "narration": narration,
        "full_name": full_name,
    };
}
