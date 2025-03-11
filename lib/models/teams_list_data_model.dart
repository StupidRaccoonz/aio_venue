// To parse this JSON data, do
//
//     final teamsListDataModel = teamsListDataModelFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert' as js;

TeamsListDataModel teamsListDataModelFromJson(String str) => TeamsListDataModel.fromJson(js.json.decode(str));

String teamsListDataModelToJson(TeamsListDataModel data) => js.json.encode(data.toJson());

class TeamsListDataModel {
  int httpCode;
  String message;
  Data data;

  TeamsListDataModel({
    required this.httpCode,
    required this.message,
    required this.data,
  });

  factory TeamsListDataModel.fromJson(Map<String, dynamic> json) => TeamsListDataModel(
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
  List<Team> team;
  List<TeamPlayersLeft> teamPlayersLeft;

  Data({
    required this.team,
    required this.teamPlayersLeft,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        team: List<Team>.from(json["team"].map((x) => Team.fromJson(x))),
        teamPlayersLeft: List<TeamPlayersLeft>.from(json["team_players_left"].map((x) => TeamPlayersLeft.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "team": List<dynamic>.from(team.map((x) => x.toJson())),
        "team_players_left": List<dynamic>.from(teamPlayersLeft.map((x) => x.toJson())),
      };
}

class Team {
  int id;
  String name;
  String logo;
  String sportId;
  DateTime createdAt;
  DateTime updatedAt;
  String isDiscoverable;
  List<Teamplayer> teamplayers;

  Team({
    required this.id,
    required this.name,
    required this.logo,
    required this.sportId,
    required this.createdAt,
    required this.updatedAt,
    required this.isDiscoverable,
    required this.teamplayers,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
        sportId: json["sport_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isDiscoverable: json["is_discoverable"],
        teamplayers: List<Teamplayer>.from(json["teamplayers"].map((x) => Teamplayer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
        "sport_id": sportId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "is_discoverable": isDiscoverable,
        "teamplayers": List<dynamic>.from(teamplayers.map((x) => x.toJson())),
      };
}

class Teamplayer {
  int id;
  int teamId;
  int playerId;
  DateTime createdAt;
  DateTime updatedAt;
  PlayerType playerType;
  int createdBy;

  Teamplayer({
    required this.id,
    required this.teamId,
    required this.playerId,
    required this.createdAt,
    required this.updatedAt,
    required this.playerType,
    required this.createdBy,
  });

  factory Teamplayer.fromJson(Map<String, dynamic> json) => Teamplayer(
        id: json["id"],
        teamId: json["team_id"],
        playerId: json["player_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        playerType: playerTypeValues.map[json["player_type"]]!,
        createdBy: json["created_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "team_id": teamId,
        "player_id": playerId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "player_type": playerTypeValues.reverse[playerType],
        "created_by": createdBy,
      };
}

enum PlayerType { TEAM_LEADER, PLAYER }

final playerTypeValues = EnumValues({"player": PlayerType.PLAYER, "team_leader": PlayerType.TEAM_LEADER});

class TeamPlayersLeft {
  int teamId;
  String sportId;
  String sportName;
  int teamAdded;
  int totalTeamPlayers;
  int leftTeamPlayers;

  TeamPlayersLeft({
    required this.teamId,
    required this.sportId,
    required this.sportName,
    required this.teamAdded,
    required this.totalTeamPlayers,
    required this.leftTeamPlayers,
  });

  factory TeamPlayersLeft.fromJson(Map<String, dynamic> json) => TeamPlayersLeft(
        teamId: json["team_id"],
        sportId: json["sport_id"],
        sportName: json["sport_name"],
        teamAdded: json["team_added"],
        totalTeamPlayers: json["total_team_players"],
        leftTeamPlayers: json["left_team_players"],
      );

  Map<String, dynamic> toJson() => {
        "team_id": teamId,
        "sport_id": sportId,
        "sport_name": sportName,
        "team_added": teamAdded,
        "total_team_players": totalTeamPlayers,
        "left_team_players": leftTeamPlayers,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
