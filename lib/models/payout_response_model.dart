// To parse this JSON data, do
//
//     final payoutResponseModel = payoutResponseModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PayoutResponseModel payoutResponseModelFromJson(String str) => PayoutResponseModel.fromJson(json.decode(str));

String payoutResponseModelToJson(PayoutResponseModel data) => json.encode(data.toJson());

class PayoutResponseModel {
    final String message;
    final Response response;

    PayoutResponseModel({
        required this.message,
        required this.response,
    });

    factory PayoutResponseModel.fromJson(Map<String, dynamic> json) => PayoutResponseModel(
        message: json["message"],
        response: Response.fromJson(json["response"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "response": response.toJson(),
    };
}

class Response {
    final String status;
    final String message;
    final Data data;

    Response({
        required this.status,
        required this.message,
        required this.data,
    });

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    final int id;
    final String accountNumber;
    final String bankCode;
    final String fullName;
    final DateTime createdAt;
    final String currency;
    final String debitCurrency;
    final int amount;
    final double fee;
    final String status;
    final String reference;
    final dynamic meta;
    final String narration;
    final String completeMessage;
    final int requiresApproval;
    final int isApproved;
    final String bankName;

    Data({
        required this.id,
        required this.accountNumber,
        required this.bankCode,
        required this.fullName,
        required this.createdAt,
        required this.currency,
        required this.debitCurrency,
        required this.amount,
        required this.fee,
        required this.status,
        required this.reference,
        required this.meta,
        required this.narration,
        required this.completeMessage,
        required this.requiresApproval,
        required this.isApproved,
        required this.bankName,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        accountNumber: json["account_number"],
        bankCode: json["bank_code"],
        fullName: json["full_name"],
        createdAt: DateTime.parse(json["created_at"]),
        currency: json["currency"],
        debitCurrency: json["debit_currency"],
        amount: json["amount"],
        fee: json["fee"]?.toDouble(),
        status: json["status"],
        reference: json["reference"],
        meta: json["meta"],
        narration: json["narration"],
        completeMessage: json["complete_message"],
        requiresApproval: json["requires_approval"],
        isApproved: json["is_approved"],
        bankName: json["bank_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "account_number": accountNumber,
        "bank_code": bankCode,
        "full_name": fullName,
        "created_at": createdAt.toIso8601String(),
        "currency": currency,
        "debit_currency": debitCurrency,
        "amount": amount,
        "fee": fee,
        "status": status,
        "reference": reference,
        "meta": meta,
        "narration": narration,
        "complete_message": completeMessage,
        "requires_approval": requiresApproval,
        "is_approved": isApproved,
        "bank_name": bankName,
    };
}
