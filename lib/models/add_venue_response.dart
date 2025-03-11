// To parse this JSON data, do
//
//     final addVenueResponseModel = addVenueResponseModelFromJson(jsonString);
import 'dart:convert';

AddVenueResponseModel addVenueResponseModelFromJson(String str) => AddVenueResponseModel.fromJson(json.decode(str));

String addVenueResponseModelToJson(AddVenueResponseModel data) => json.encode(data.toJson());

class AddVenueResponseModel {
  int httpCode;
  String message;
  Data? data;

  AddVenueResponseModel({
    required this.httpCode,
    required this.message,
    required this.data,
  });

  factory AddVenueResponseModel.fromJson(Map<String, dynamic> json) => AddVenueResponseModel(
        httpCode: json["http_code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "http_code": httpCode,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Venue venue;

  Data({
    required this.venue,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        venue: Venue.fromJson(json["venue"]),
      );

  Map<String, dynamic> toJson() => {
        "venue": venue.toJson(),
      };
}

class Venue {
  String name;
  String address;
  String openingHour;
  String closingHour;
  List<WorkingDay> workingDays;
  String longTermBooking;
  String numberOfGrounds;
  String ratings;
  String wishlist;
  String profilePicture;
  int userId;
  String email;
  String phone;
  String role;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  Venue({
    required this.name,
    required this.address,
    required this.openingHour,
    required this.closingHour,
    required this.workingDays,
    required this.longTermBooking,
    required this.numberOfGrounds,
    required this.ratings,
    required this.wishlist,
    required this.profilePicture,
    required this.userId,
    required this.email,
    required this.phone,
    required this.role,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Venue.fromJson(Map<String, dynamic> json) => Venue(
        name: json["name"],
        address: json["address"],
        openingHour: json["opening_hour"],
        closingHour: json["closing_hour"],
        workingDays: List<WorkingDay>.from(json["working_days"].map((x) => WorkingDay.fromJson(x))),
        longTermBooking: json["long_term_booking"],
        numberOfGrounds: json["number_of_grounds"],
        ratings: json["ratings"],
        wishlist: json["wishlist"],
        profilePicture: json["profile_picture"],
        userId: json["user_id"],
        email: json["email"],
        phone: json["phone"],
        role: json["role"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "opening_hour": openingHour,
        "closing_hour": closingHour,
        "working_days": List<dynamic>.from(workingDays.map((x) => x.toJson())),
        "long_term_booking": longTermBooking,
        "number_of_grounds": numberOfGrounds,
        "ratings": ratings,
        "wishlist": wishlist,
        "profile_picture": profilePicture,
        "user_id": userId,
        "email": email,
        "phone": phone,
        "role": role,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}

class WorkingDay {
  String day;
  String status;

  WorkingDay({
    required this.day,
    required this.status,
  });

  factory WorkingDay.fromJson(Map<String, dynamic> json) => WorkingDay(
        day: json["day"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "status": status,
      };
}
