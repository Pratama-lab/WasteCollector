// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

DetailCollectionFromJson(String str) =>
    DetailCollection.fromJson(jsonDecode(str));

String DetailCollectionToJson(DetailCollection data) =>
    json.encode(data.toJson());

class DetailCollection {
  DetailCollection({
    required this.success,
    required this.message,
    required this.data,
  });

  int success;
  String message;
  List<Datum> data;

  factory DetailCollection.fromJson(Map<String, dynamic> json) =>
      DetailCollection(
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
    this.createdAt,
    required this.updatedAt,
    required this.url,
    required this.driver,
    required this.images,
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
  String url;
  Driver driver;
  List<Image> images;

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
        url: json["url"],
        driver: Driver.fromJson(json["driver"]),
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
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
        "url": url,
        "driver": driver.toJson(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
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
    this.createdAt,
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
  dynamic createdAt;
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
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Image {
  Image({
    required this.id,
    required this.orderCode,
    required this.userId,
    required this.wasteType,
    required this.directory,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String orderCode;
  String userId;
  String wasteType;
  String directory;
  DateTime createdAt;
  DateTime updatedAt;

  factory Image.fromRawJson(String str) => Image.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        orderCode: json["order_code"],
        userId: json["user_id"],
        wasteType: json["waste_type"],
        directory: json["directory"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_code": orderCode,
        "user_id": userId,
        "waste_type": wasteType,
        "directory": directory,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
