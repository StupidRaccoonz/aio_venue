// To parse this JSON data, do
//
//     final playerTeamResponseModel = playerTeamResponseModelFromJson(jsonString);

import 'dart:convert';

PlayerTeamResponseModel playerTeamResponseModelFromJson(String str) => PlayerTeamResponseModel.fromJson(json.decode(str));

String playerTeamResponseModelToJson(PlayerTeamResponseModel data) => json.encode(data.toJson());

class PlayerTeamResponseModel {
  int httpCode;
  String message;
  Data? data;

  PlayerTeamResponseModel({
    required this.httpCode,
    required this.message,
    required this.data,
  });

  factory PlayerTeamResponseModel.fromJson(Map<String, dynamic> json) => PlayerTeamResponseModel(
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
  List<MyTeam> myTeams;
  List<dynamic> joinedTeams;

  Data({
    required this.myTeams,
    required this.joinedTeams,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        myTeams: json["my_teams"] == null ? <MyTeam>[] : List<MyTeam>.from(json["my_teams"].map((x) => MyTeam.fromJson(x))),
        joinedTeams: List<dynamic>.from(json["joined_teams"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "my_teams": List<dynamic>.from(myTeams.map((x) => x.toJson())),
        "joined_teams": List<dynamic>.from(joinedTeams.map((x) => x)),
      };
}

class MyTeam {
  int id;
  String name;
  String? logo;
  String sportId;
  DateTime createdAt;
  DateTime updatedAt;
  String isDiscoverable;
  String isSoloPlayer;
  int teamPlayersCount;
  Sport sport;

  MyTeam({
    required this.id,
    required this.name,
    required this.logo,
    required this.sportId,
    required this.createdAt,
    required this.updatedAt,
    required this.isDiscoverable,
    required this.isSoloPlayer,
    required this.teamPlayersCount,
    required this.sport,
  });

  factory MyTeam.fromJson(Map<String, dynamic> json) => MyTeam(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
        sportId: json["sport_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isDiscoverable: json["is_discoverable"],
        isSoloPlayer: json["is_solo_player"],
        teamPlayersCount: json["team_players_count"],
        sport: Sport.fromJson(json["sport"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
        "sport_id": sportId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "is_discoverable": isDiscoverable,
        "is_solo_player": isSoloPlayer,
        "team_players_count": teamPlayersCount,
        "sport": sport.toJson(),
      };
}

class Sport {
  int id;
  String name;
  String image;
  int teamPlayers;
  String? description;
  DateTime createdAt;
  DateTime updatedAt;

  Sport({
    required this.id,
    required this.name,
    required this.image,
    required this.teamPlayers,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Sport.fromJson(Map<String, dynamic> json) => Sport(
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
