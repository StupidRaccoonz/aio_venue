// To parse this JSON data, do
//
//     final playerNearbyMatchesResponseModel = playerNearbyMatchesResponseModelFromJson(jsonString);

import 'dart:convert';

PlayerNearbyMatchesResponseModel playerNearbyMatchesResponseModelFromJson(String str) => PlayerNearbyMatchesResponseModel.fromJson(json.decode(str));

String playerNearbyMatchesResponseModelToJson(PlayerNearbyMatchesResponseModel data) => json.encode(data.toJson());

class PlayerNearbyMatchesResponseModel {
  final int httpCode;
  final String message;
  final Data? data;

  PlayerNearbyMatchesResponseModel({
    required this.httpCode,
    required this.message,
    required this.data,
  });

  factory PlayerNearbyMatchesResponseModel.fromJson(Map<String, dynamic> json) => PlayerNearbyMatchesResponseModel(
        httpCode: json["http_code"],
        message: json["message"],
        data: json["data"] == {} ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "http_code": httpCode,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  final List<Match> matches;
  final List<TeamLeader> teamLeader;

  Data({
    required this.matches,
    required this.teamLeader,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        matches: List<Match>.from(json["matches"].map((x) => Match.fromJson(x))),
        teamLeader: List<TeamLeader>.from(json["team_leader"].map((x) => TeamLeader.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "matches": List<dynamic>.from(matches.map((x) => x.toJson())),
        "team_leader": List<dynamic>.from(teamLeader.map((x) => x.toJson())),
      };
}

class Match {
  final int id;
  final DateTime date;
  final String matchType;
  final String stadiumName;
  final String? winningPrice;
  final String? entryFees;
  final String? splitCost;
  final List<String> bookedSlots;
  final String bookingStatus;
  final String activityAccess;
  final String? teamRequired;
  final String? numberOfPlayers;
  final String? createdBy;
  final int? createdById;
  final int requestSent;
  final List<Team> teams;
  final Sport sport;

  Match({
    required this.id,
    required this.date,
    required this.matchType,
    required this.stadiumName,
    required this.winningPrice,
    required this.entryFees,
    required this.splitCost,
    required this.bookedSlots,
    required this.bookingStatus,
    required this.activityAccess,
    required this.teamRequired,
    required this.numberOfPlayers,
    required this.createdBy,
    required this.createdById,
    required this.requestSent,
    required this.teams,
    required this.sport,
  });

  factory Match.fromJson(Map<String, dynamic> json) => Match(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        matchType: json["match_type"],
        stadiumName: json["stadium_name"],
        winningPrice: json["winning_price"],
        entryFees: json["entry_fees"],
        splitCost: json["split_cost"],
        bookedSlots: List<String>.from(json["booked_slots"].map((x) => x)),
        bookingStatus: json["booking_status"],
        activityAccess: json["activity_access"],
        teamRequired: json["team_required"],
        numberOfPlayers: json["number_of_players"],
        createdBy: json["created_by"],
        createdById: json["created_by_id"],
        requestSent: json["request_sent"],
        teams: List<Team>.from(json["teams"].map((x) => Team.fromJson(x))),
        sport: Sport.fromJson(json["sport"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "match_type": matchType,
        "stadium_name": stadiumName,
        "winning_price": winningPrice,
        "entry_fees": entryFees,
        "split_cost": splitCost,
        "booked_slots": List<dynamic>.from(bookedSlots.map((x) => x)),
        "booking_status": bookingStatus,
        "activity_access": activityAccess,
        "team_required": teamRequired,
        "number_of_players": numberOfPlayers,
        "created_by": createdBy,
        "created_by_id": createdById,
        "request_sent": requestSent,
        "teams": List<dynamic>.from(teams.map((x) => x.toJson())),
        "sport": sport.toJson(),
      };
}

class Sport {
  final int id;
  final String name;
  final String image;
  final int teamPlayers;
  final dynamic description;
  final DateTime createdAt;
  final DateTime updatedAt;

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

class Team {
  final int id;
  final String? name;
  final String? logo;
  final int? teamLeader;
  final String sportId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Invited> players;
  final List<dynamic> joinRequests;
  final List<Invited> invited;
  final int pendingPlayers;

  Team({
    required this.id,
    required this.name,
    required this.logo,
    required this.teamLeader,
    required this.sportId,
    required this.createdAt,
    required this.updatedAt,
    required this.players,
    required this.joinRequests,
    required this.invited,
    required this.pendingPlayers,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
        teamLeader: json["team_leader"],
        sportId: json["sport_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        players: List<Invited>.from(json["players"].map((x) => Invited.fromJson(x))),
        joinRequests: List<dynamic>.from(json["join_requests"].map((x) => x)),
        invited: List<Invited>.from(json["invited"].map((x) => Invited.fromJson(x))),
        pendingPlayers: json["pending_players"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
        "team_leader": teamLeader,
        "sport_id": sportId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "players": List<dynamic>.from(players.map((x) => x.toJson())),
        "join_requests": List<dynamic>.from(joinRequests.map((x) => x)),
        "invited": List<dynamic>.from(invited.map((x) => x.toJson())),
        "pending_players": pendingPlayers,
      };
}

class Invited {
  final int playerId;
  final String playerName;
  final String playerPicture;
  final String playerType;
  final String playerPoints;

  Invited({
    required this.playerId,
    required this.playerName,
    required this.playerPicture,
    required this.playerType,
    required this.playerPoints,
  });

  factory Invited.fromJson(Map<String, dynamic> json) => Invited(
        playerId: json["player_id"],
        playerName: json["player_name"],
        playerPicture: json["player_picture"],
        playerType: json["player_type"],
        playerPoints: json["player_points"],
      );

  Map<String, dynamic> toJson() => {
        "player_id": playerId,
        "player_name": playerName,
        "player_picture": playerPicture,
        "player_type": playerType,
        "player_points": playerPoints,
      };
}

class TeamLeader {
  final int playerId;
  final String playerType;
  final String sportId;
  final int teamId;

  TeamLeader({
    required this.playerId,
    required this.playerType,
    required this.sportId,
    required this.teamId,
  });

  factory TeamLeader.fromJson(Map<String, dynamic> json) => TeamLeader(
        playerId: json["player_id"],
        playerType: json["player_type"],
        sportId: json["sport_id"],
        teamId: json["team_id"],
      );

  Map<String, dynamic> toJson() => {
        "player_id": playerId,
        "player_type": playerType,
        "sport_id": sportId,
        "team_id": teamId,
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
