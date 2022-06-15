// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

GetDataFromJson(String str) => GetData.fromJson(jsonDecode(str));

String GetDataToJson(GetData data) => json.encode(data.toJson());

class GetData {
  GetData({
    required this.success,
    required this.message,
    required this.data,
  });

  int success;
  String message;
  Data data;

  factory GetData.fromJson(Map<String, dynamic> json) => GetData(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
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
    required this.googleId,
    required this.facebookId,
    required this.selfie,
    required this.image,
    required this.ktp,
    required this.emailVerifiedAt,
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
  dynamic deviceToken;
  dynamic googleId;
  dynamic facebookId;
  dynamic selfie;
  dynamic image;
  dynamic ktp;
  DateTime emailVerifiedAt;
  dynamic createdAt;
  DateTime updatedAt;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        createdAt: json["created_at"],
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
        "email_verified_at": emailVerifiedAt.toIso8601String(),
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
      };
}
