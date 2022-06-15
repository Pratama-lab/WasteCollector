// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

CollectionReceivedFromJson(String str) =>
    CollectionReceived.fromJson(jsonDecode(str));

String CollectionReceivedToJson(CollectionReceived data) =>
    json.encode(data.toJson());

class CollectionReceived {
  CollectionReceived({
    required this.success,
    required this.message,
    required this.data,
  });

  int success;
  String message;
  List<Datum> data;

  factory CollectionReceived.fromJson(Map<String, dynamic> json) =>
      CollectionReceived(
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
    this.wasteCollectorId,
    required this.date,
    required this.totalWeight,
    required this.total,
    required this.feeBeever,
    required this.status,
    required this.location1,
    this.location2,
    required this.tempat,
    this.notes,
    this.reason,
    required this.createdAt,
    required this.updatedAt,
    required this.driver,
    required this.user,
    required this.detail,
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
  DateTime createdAt;
  DateTime updatedAt;
  Driver driver;
  Driver user;
  List<Detail> detail;

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
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        driver: Driver.fromJson(json["driver"]),
        user: Driver.fromJson(json["user"]),
        detail:
            List<Detail>.from(json["detail"].map((x) => Detail.fromJson(x))),
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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "driver": driver.toJson(),
        "user": user.toJson(),
        "detail": List<dynamic>.from(detail.map((x) => x.toJson())),
      };
}

class Detail {
  Detail({
    required this.id,
    required this.orderCode,
    required this.wasteType,
    required this.wasteWeight,
    required this.subtotal,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String orderCode;
  String wasteType;
  String wasteWeight;
  String subtotal;
  DateTime createdAt;
  DateTime updatedAt;

  factory Detail.fromRawJson(String str) => Detail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        orderCode: json["order_code"],
        wasteType: json["waste_type"],
        wasteWeight: json["waste_weight"],
        subtotal: json["subtotal"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_code": orderCode,
        "waste_type": wasteType,
        "waste_weight": wasteWeight,
        "subtotal": subtotal,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
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
  String lat;
  String lng;
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
