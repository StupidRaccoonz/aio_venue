// To parse this JSON data, do
//
//     final coachesListModel = coachesListModelFromJson(jsonString);

import 'dart:convert';

CoachesListModel coachesListModelFromJson(String str) => CoachesListModel.fromJson(json.decode(str));

String coachesListModelToJson(CoachesListModel data) => json.encode(data.toJson());

class CoachesListModel {
  final int httpCode;
  final String message;
  final Data data;

  CoachesListModel({
    required this.httpCode,
    required this.message,
    required this.data,
  });

  factory CoachesListModel.fromJson(Map<String, dynamic> json) => CoachesListModel(
        httpCode: json["http_code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "http_code": httpCode,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  final List<Coach> coaches;

  Data({
    required this.coaches,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        coaches: List<Coach>.from(json["coaches"].map((x) => Coach.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "coaches": List<dynamic>.from(coaches.map((x) => x.toJson())),
      };
}

class Coach {
  final int id;
  final String name;
  final String? profilePicture;
  final String? hourlyRate;
  final String haveVenue;
  final int coachrating;
  final int ratingCount;
  final String isInWishlist;
  final int distance;

  Coach({
    required this.id,
    required this.name,
    required this.profilePicture,
    required this.hourlyRate,
    required this.haveVenue,
    required this.coachrating,
    required this.ratingCount,
    required this.isInWishlist,
    required this.distance,
  });

  factory Coach.fromJson(Map<String, dynamic> json) => Coach(
        id: json["id"],
        name: json["name"],
        profilePicture: json["profile_picture"],
        hourlyRate: json["hourly_rate"],
        haveVenue: json["have_venue"],
        coachrating: json["coachrating"],
        ratingCount: json["rating_count"],
        isInWishlist: json["is_in_wishlist"],
        distance: json["distance"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "profile_picture": profilePicture,
        "hourly_rate": hourlyRate,
        "have_venue": haveVenue,
        "coachrating": coachrating,
        "rating_count": ratingCount,
        "is_in_wishlist": isInWishlist,
        "distance": distance,
      };
}
