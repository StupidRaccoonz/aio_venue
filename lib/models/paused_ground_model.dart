// To parse this JSON data, do
//
//     final pausedGroundModel = pausedGroundModelFromJson(jsonString);
import 'dart:convert';

PausedGroundModel pausedGroundModelFromJson(String str) => PausedGroundModel.fromJson(json.decode(str));

String pausedGroundModelToJson(PausedGroundModel data) => json.encode(data.toJson());

class PausedGroundModel {
  int httpCode;
  String message;
  Data data;

  PausedGroundModel({
    required this.httpCode,
    required this.message,
    required this.data,
  });

  factory PausedGroundModel.fromJson(Map<String, dynamic> json) => PausedGroundModel(
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
  List<PausedGround> grounds;

  Data({
    required this.grounds,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        grounds: json["grounds"] == null ? [] : List<PausedGround>.from(json["grounds"].map((x) => PausedGround.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "grounds": List<dynamic>.from(grounds.map((x) => x.toJson())),
      };
}

class PausedGround {
  int id;
  int venueId;
  int sportsId;
  String? groundType;
  String? name;
  String? groundSize;
  String? unit;
  String? hourlyRent;
  dynamic addedBy;
  List<String> morningAvailability;
  List<String> eveningAvailability;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  dynamic futureDeletedDate;
  Sports sports;

  PausedGround({
    required this.id,
    required this.venueId,
    required this.sportsId,
    required this.groundType,
    required this.name,
    required this.groundSize,
    required this.unit,
    required this.hourlyRent,
    required this.addedBy,
    required this.morningAvailability,
    required this.eveningAvailability,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.futureDeletedDate,
    required this.sports,
  });

  factory PausedGround.fromJson(Map<String, dynamic> json) => PausedGround(
        id: json["id"],
        venueId: json["venue_id"],
        sportsId: json["sports_id"],
        groundType: json["ground_type"],
        name: json["name"],
        groundSize: json["ground_size"],
        unit: json["unit"],
        hourlyRent: json["hourly_rent"],
        addedBy: json["added_by"],
        morningAvailability: List<String>.from(json["morning_availability"].map((x) => x)),
        eveningAvailability: List<String>.from(json["evening_availability"].map((x) => x)),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        futureDeletedDate: json["future_deleted_date"],
        sports: Sports.fromJson(json["sports"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "venue_id": venueId,
        "sports_id": sportsId,
        "ground_type": groundType,
        "name": name,
        "ground_size": groundSize,
        "unit": unit,
        "hourly_rent": hourlyRent,
        "added_by": addedBy,
        "morning_availability": List<dynamic>.from(morningAvailability.map((x) => x)),
        "evening_availability": List<dynamic>.from(eveningAvailability.map((x) => x)),
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "future_deleted_date": futureDeletedDate,
        "sports": sports.toJson(),
      };
}

class Sports {
  int id;
  String name;
  String image;
  int teamPlayers;
  dynamic description;
  DateTime createdAt;
  DateTime updatedAt;

  Sports({
    required this.id,
    required this.name,
    required this.image,
    required this.teamPlayers,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Sports.fromJson(Map<String, dynamic> json) => Sports(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        teamPlayers: json["team_players"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "team_players": teamPlayers,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
