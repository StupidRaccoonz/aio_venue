// To parse this JSON data, do
//
//     final myVenuesResponseModel = myVenuesResponseModelFromJson(jsonString);

import 'dart:convert';

import 'venue_details_model.dart';

MyVenuesResponseModel myVenuesResponseModelFromJson(String str) => MyVenuesResponseModel.fromJson(json.decode(str));

String myVenuesResponseModelToJson(MyVenuesResponseModel data) => json.encode(data.toJson());

class MyVenuesResponseModel {
  int httpCode;
  String message;
  Data? data;

  MyVenuesResponseModel({
    required this.httpCode,
    required this.message,
    required this.data,
  });

  factory MyVenuesResponseModel.fromJson(Map<String, dynamic> json) => MyVenuesResponseModel(
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
  List<Venue> venue;

  Data({
    required this.venue,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        venue: json["venue"] == null ? [] : List<Venue>.from(json["venue"].map((x) => Venue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "venue": List<dynamic>.from(venue.map((x) => x.toJson())),
      };
}

class Venue {
  int id;
  int userId;
  String name;
  String email;
  String? phone;
  String address;
  String? latitude;
  String? longitude;
  String? profilePicture;
  int? numberOfGrounds;
  String openingHour;
  String closingHour;
  List<WorkingDay>? workingDays;
  int longTermBooking;
  DateTime createdAt;
  DateTime updatedAt;
  String? ratings;
  int? wishlist;
  DateTime? establishedDate;
  DateTime? deletedAt;
  DateTime? futureDeletedDate;
  DateTime? lastBookingDatetime;
  List<Sport> sports;
  List<Ground> grounds;

  Venue({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.profilePicture,
    required this.numberOfGrounds,
    required this.openingHour,
    required this.closingHour,
    required this.workingDays,
    required this.longTermBooking,
    required this.createdAt,
    required this.updatedAt,
    required this.ratings,
    required this.wishlist,
    required this.establishedDate,
    required this.deletedAt,
    required this.futureDeletedDate,
    required this.lastBookingDatetime,
    required this.sports,
    required this.grounds,
  });

  factory Venue.fromJson(Map<String, dynamic> json) => Venue(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        profilePicture: json["profile_picture"] ?? "",
        numberOfGrounds: json["number_of_grounds"],
        openingHour: json["opening_hour"],
        closingHour: json["closing_hour"],
        workingDays: json["working_days"] == null ? <WorkingDay>[] : List<WorkingDay>.from(json["working_days"].map((e) => WorkingDay.fromJson(e))),
        longTermBooking: json["long_term_booking"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        ratings: json["ratings"] ?? "0",
        wishlist: json["wishlist"] != null
            ? json["wishlist"] is int
                ? json["wishlist"]
                : int.parse(json["wishlist"])
            : 0,
        establishedDate: json["established_date"],
        deletedAt: json["deleted_at"],
        futureDeletedDate: json["future_deleted_date"],
        lastBookingDatetime: json["last_booking_datetime"] != null ? DateTime.parse(json["last_booking_datetime"]) : null,
        sports: List<Sport>.from(json["sports"].map((x) => Sport.fromJson(x))),
        grounds: List<Ground>.from(json["grounds"].map((x) => Ground.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "profile_picture": profilePicture,
        "number_of_grounds": numberOfGrounds,
        "opening_hour": openingHour,
        "closing_hour": closingHour,
        "working_days": workingDays,
        "long_term_booking": longTermBooking,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "ratings": ratings,
        "wishlist": wishlist,
        "established_date": establishedDate,
        "deleted_at": deletedAt,
        "future_deleted_date": futureDeletedDate,
        "last_booking_datetime": lastBookingDatetime,
        "sports": List<dynamic>.from(sports.map((x) => x.toJson())),
        "grounds": List<dynamic>.from(grounds.map((x) => x)),
      };
}

class Sport {
  int id;
  String name;
  String image;
  int teamPlayers;
  dynamic description;
  DateTime createdAt;
  DateTime updatedAt;
  Pivot pivot;

  Sport({
    required this.id,
    required this.name,
    required this.image,
    required this.teamPlayers,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  factory Sport.fromJson(Map<String, dynamic> json) => Sport(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        teamPlayers: json["team_players"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "team_players": teamPlayers,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pivot": pivot.toJson(),
      };
}

class Pivot {
  int venueId;
  int sportsId;

  Pivot({
    required this.venueId,
    required this.sportsId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        venueId: json["venue_id"],
        sportsId: json["sports_id"],
      );

  Map<String, dynamic> toJson() => {
        "venue_id": venueId,
        "sports_id": sportsId,
      };
}
