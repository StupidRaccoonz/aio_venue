// To parse this JSON data, do
//
//     final playerDetailsModel = playerDetailsModelFromJson(jsonString);

import 'dart:convert';

PlayerDetailsModel playerDetailsModelFromJson(String str) => PlayerDetailsModel.fromJson(json.decode(str));

String playerDetailsModelToJson(PlayerDetailsModel data) => json.encode(data.toJson());

class PlayerDetailsModel {
  int httpCode;
  String message;
  Data data;

  PlayerDetailsModel({
    required this.httpCode,
    required this.message,
    required this.data,
  });

  factory PlayerDetailsModel.fromJson(Map<String, dynamic> json) => PlayerDetailsModel(
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
  int id;
  int userId;
  String name;
  String email;
  String? phone;
  String? profilePicture;
  String? address;
  DateTime birthDate;
  String? aboutMe;
  DateTime? createdAt;
  DateTime? updatedAt;
  String isDiscoverable;
  dynamic latitude;
  dynamic longitude;
  String isTeamDiscoverable;
  String? totalPoints;
  List<Sport>? sports;

  Data({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.profilePicture,
    required this.address,
    required this.birthDate,
    required this.aboutMe,
    required this.createdAt,
    required this.updatedAt,
    required this.isDiscoverable,
    required this.latitude,
    required this.longitude,
    required this.isTeamDiscoverable,
    required this.totalPoints,
    required this.sports,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        profilePicture: json["profile_picture"],
        address: json["address"],
        birthDate: DateTime.parse(json["birth_date"]),
        aboutMe: json["about_me"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isDiscoverable: json["is_discoverable"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        isTeamDiscoverable: json["is_team_discoverable"],
        totalPoints: json["total_points"],
        sports: List<Sport>.from(json["sports"].map((x) => Sport.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "email": email,
        "phone": phone,
        "profile_picture": profilePicture,
        "address": address,
        "birth_date": "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
        "about_me": aboutMe,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "is_discoverable": isDiscoverable,
        "latitude": latitude,
        "longitude": longitude,
        "is_team_discoverable": isTeamDiscoverable,
        "total_points": totalPoints,
        "sports": sports == null ? null : List<dynamic>.from(sports!.map((x) => x.toJson())),
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
  int playerId;
  int sportsId;

  Pivot({
    required this.playerId,
    required this.sportsId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        playerId: json["player_id"],
        sportsId: json["sports_id"],
      );

  Map<String, dynamic> toJson() => {
        "player_id": playerId,
        "sports_id": sportsId,
      };
}
