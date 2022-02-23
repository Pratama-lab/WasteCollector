import 'dart:convert';

CollectorHomeData CollectorHomeDataFromJson(String str) =>
    CollectorHomeData.fromJson(jsonDecode(str));

String CollectorHomeDataToJson(CollectorHomeData data) => json.encode(data.toJson());

class CollectorHomeData {
  final int? success;
  final String? message;
  final Data? data;

  CollectorHomeData({
    this.success,
    this.message,
    this.data,
  });

  factory CollectorHomeData.fromJson(Map<String, dynamic> json) => CollectorHomeData(
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
  final String? balance;
  final dynamic googleId;
  final dynamic facebookId;
  final dynamic image;
  final dynamic emailVerifiedAt;

  Data({
    this.email,
    this.fullName,
    this.phone,
    this.balance,
    this.googleId,
    this.facebookId,
    this.image,
    this.emailVerifiedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    email: json["email"],
    fullName: json["full_name"],
    phone: json["phone"],
    balance: json["balance"],
    googleId: json["google_id"],
    facebookId: json["facebook_id"],
    image: json["image"],
    emailVerifiedAt: json["email_verified_at"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "full_name": fullName,
    "phone": phone,
    "balance": balance,
    "google_id": googleId,
    "facebook_id": facebookId,
    "image": image,
    "email_verified_at": emailVerifiedAt,
  };
}
