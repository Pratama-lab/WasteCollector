// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

CollectorData CollectorDataFromJson(String str) =>
    CollectorData.fromJson(jsonDecode(str));

String CollectorDataToJson(CollectorData data) => json.encode(data.toJson());

class CollectorData {
  final int? success;
  final String? message;
  final Data? data;

  CollectorData({
    this.success,
    this.message,
    this.data,
  });

  factory CollectorData.fromJson(Map<String, dynamic> json) => CollectorData(
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  final String? fullName;
  final String? balance;
  final dynamic image;
  final dynamic emailVerifiedAt;

  Data({
    this.fullName,
    this.balance,
    this.image,
    this.emailVerifiedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    fullName: json["full_name"],
    balance: json["balance"],
    image: json["image"],
    emailVerifiedAt: json["email_verified_at"],
  );

  Map<String, dynamic> toJson() => {
    "full_name": fullName,
    "balance": balance,
    "image": image,
    "email_verified_at": emailVerifiedAt,
  };
}
