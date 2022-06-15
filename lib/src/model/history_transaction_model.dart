// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

HistoryTransactionFromJson(String str) =>
    HistoryTransaction.fromJson(jsonDecode(str));

String HistoryTransactionToJson(HistoryTransaction data) =>
    json.encode(data.toJson());

class HistoryTransaction {
  HistoryTransaction({
    required this.success,
    required this.message,
    required this.data,
  });

  int success;
  String message;
  List<Datum> data;

  factory HistoryTransaction.fromJson(Map<String, dynamic> json) =>
      HistoryTransaction(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.idOrder,
    required this.idTransaction,
    required this.userId,
    required this.type,
    required this.to,
    required this.number,
    required this.amount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  int id;
  String idOrder;
  String idTransaction;
  String userId;
  String type;
  String to;
  String number;
  String amount;
  String status;
  dynamic createdAt;
  DateTime updatedAt;
  User user;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        idOrder: json["id_order"],
        idTransaction: json["id_transaction"],
        userId: json["user_id"],
        type: json["type"],
        to: json["to"],
        number: json["number"],
        amount: json["amount"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_order": idOrder,
        "id_transaction": idTransaction,
        "user_id": userId,
        "type": type,
        "to": to,
        "number": number,
        "amount": amount,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toJson(),
      };
}

class User {
  User({
    required this.id,
    required this.email,
    required this.fullName,
    required this.address,
    required this.lat,
    required this.lng,
    required this.phone,
    required this.role,
    required this.active,
    required this.verified,
    required this.balance,
    required this.deviceToken,
    this.googleId,
    this.facebookId,
    this.selfie,
    this.image,
    this.ktp,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String email;
  String fullName;
  String address;
  dynamic lat;
  dynamic lng;
  String phone;
  String role;
  String active;
  String verified;
  String balance;
  String deviceToken;
  dynamic googleId;
  dynamic facebookId;
  dynamic selfie;
  dynamic image;
  dynamic ktp;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        fullName: json["full_name"],
        address: json["address"],
        lat: json["lat"],
        lng: json["lng"],
        phone: json["phone"],
        role: json["role"],
        active: json["active"],
        verified: json["verified"],
        balance: json["balance"],
        deviceToken: json["device_token"],
        googleId: json["google_id"],
        facebookId: json["facebook_id"],
        selfie: json["selfie"],
        image: json["image"],
        ktp: json["ktp"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "full_name": fullName,
        "address": address,
        "lat": lat,
        "lng": lng,
        "phone": phone,
        "role": role,
        "active": active,
        "verified": verified,
        "balance": balance,
        "device_token": deviceToken,
        "google_id": googleId,
        "facebook_id": facebookId,
        "selfie": selfie,
        "image": image,
        "ktp": ktp,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
