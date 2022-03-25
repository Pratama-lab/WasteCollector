// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

ProfileData ProfileDataFromJson(String str) =>
    ProfileData.fromJson(jsonDecode(str));

String ProfileDataToJson(ProfileData data) => json.encode(data.toJson());

class ProfileData {
  final int? success;
  final String? message;
  final Data? data;

  ProfileData({
    this.success,
    this.message,
    this.data,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
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
  final String? email;
  final String? fullName;
  final String? phone;
  final dynamic googleId;
  final dynamic facebookId;
  final dynamic image;
  final dynamic emailVerifiedAt;

  Data({
    this.email,
    this.fullName,
    this.phone,
    this.googleId,
    this.facebookId,
    this.image,
    this.emailVerifiedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    email: json["email"],
    fullName: json["full_name"],
    phone: json["phone"],
    googleId: json["google_id"],
    facebookId: json["facebook_id"],
    image: json["image"],
    emailVerifiedAt: json["email_verified_at"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "full_name": fullName,
    "phone": phone,
    "google_id": googleId,
    "facebook_id": facebookId,
    "image": image,
    "email_verified_at": emailVerifiedAt,
  };
}
