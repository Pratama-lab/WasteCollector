// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

UpcomingCollectionFromJson(String str) =>
    UpcomingCollection.fromJson(jsonDecode(str));

String UpcomingCollectionToJson(UpcomingCollection data) =>
    json.encode(data.toJson());

class UpcomingCollection {
  UpcomingCollection({
    required this.success,
    required this.message,
    required this.data,
  });

  int success;
  String message;
  List<Datum> data;

  factory UpcomingCollection.fromJson(Map<String, dynamic> json) =>
      UpcomingCollection(
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
    required this.orderCode,
    required this.userId,
    required this.driverId,
    required this.wasteCollectorId,
    required this.date,
    required this.totalWeight,
    required this.total,
    required this.feeBeever,
    required this.status,
    required this.location1,
    required this.location2,
    required this.tempat,
    required this.notes,
    required this.reason,
    required this.createdAt,
    required this.updatedAt,
    required this.driver,
  });

  int id;
  String orderCode;
  String userId;
  String driverId;
  dynamic wasteCollectorId;
  DateTime date;
  String totalWeight;
  String total;
  String feeBeever;
  String status;
  String location1;
  dynamic location2;
  String tempat;
  dynamic notes;
  dynamic reason;
  dynamic createdAt;
  DateTime updatedAt;
  Driver driver;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        orderCode: json["order_code"],
        userId: json["user_id"],
        driverId: json["driver_id"],
        wasteCollectorId: json["waste_collector_id"],
        date: DateTime.parse(json["date"]),
        totalWeight: json["total_weight"],
        total: json["total"],
        feeBeever: json["fee_beever"],
        status: json["status"],
        location1: json["location1"],
        location2: json["location2"],
        tempat: json["tempat"],
        notes: json["notes"],
        reason: json["reason"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
        driver: Driver.fromJson(json["driver"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_code": orderCode,
        "user_id": userId,
        "driver_id": driverId,
        "waste_collector_id": wasteCollectorId,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "total_weight": totalWeight,
        "total": total,
        "fee_beever": feeBeever,
        "status": status,
        "location1": location1,
        "location2": location2,
        "tempat": tempat,
        "notes": notes,
        "reason": reason,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
        "driver": driver.toJson(),
      };
}

class Driver {
  Driver({
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
  String lat;
  String lng;
  String phone;
  String role;
  String active;
  String verified;
  String balance;
  String deviceToken;
  String googleId;
  dynamic facebookId;
  dynamic selfie;
  dynamic image;
  dynamic ktp;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory Driver.fromRawJson(String str) => Driver.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
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
