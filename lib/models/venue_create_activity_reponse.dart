// To parse this JSON data, do
//
//     final venueCreateActivityResponse = venueCreateActivityResponseFromJson(jsonString);

import 'dart:convert' as js;

VenueCreateActivityResponse venueCreateActivityResponseFromJson(String str) => VenueCreateActivityResponse.fromJson(js.json.decode(str));

String venueCreateActivityResponseToJson(VenueCreateActivityResponse data) => js.json.encode(data.toJson());

class VenueCreateActivityResponse {
  final int httpCode;
  final String message;
  final Data? data;

  VenueCreateActivityResponse({
    required this.httpCode,
    required this.message,
    this.data,
  });

  factory VenueCreateActivityResponse.fromJson(Map<String, dynamic> json) => VenueCreateActivityResponse(
        httpCode: json["http_code"] ?? 0,
        message: json["message"] ?? "",
        data: json["data"] != null ? (json["data"] is String ? Data.fromJson(js.json.decode(json["data"])) : Data.fromJson(json["data"])) : null,
      );

  Map<String, dynamic> toJson() => {
        "http_code": httpCode,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  final List<CreateActivityMatch> match;

  Data({required this.match});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      match: json["match"] != null
          ? List<CreateActivityMatch>.from((json["match"] as List<dynamic>).map((x) {
              return CreateActivityMatch.fromJson(x as Map<String, dynamic>);
            }))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        "match": match.map((x) => x.toJson()).toList(),
      };
}

class CreateActivityMatch {
  final int id;
  final DateTime date;
  final String sportId;
  final int venueId;
  final int? groundId;
  final dynamic addOns;
  final String morningAvailability;
  final String eveningAvailability;
  final String matchType;
  final String? teamId;
  final String? tellusAboutTeam;
  final String activityAccess;
  final String? splitCost;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> rules;
  final String winningPrice;
  final String teamRequired;
  final String entryFees;
  final String numberOfPlayers;
  final String type;
  final String createdBy;
  final List<String> bookedSlots;
  final CreateActivitySport sport;
  final Venue venue;
  final List<ActivityTeam> teams;

  CreateActivityMatch({
    required this.id,
    required this.date,
    required this.sportId,
    required this.venueId,
    this.groundId,
    this.addOns,
    required this.morningAvailability,
    required this.eveningAvailability,
    required this.matchType,
    this.teamId,
    this.tellusAboutTeam,
    required this.activityAccess,
    this.splitCost,
    required this.createdAt,
    required this.updatedAt,
    required this.rules,
    required this.winningPrice,
    required this.teamRequired,
    required this.entryFees,
    required this.numberOfPlayers,
    required this.type,
    required this.createdBy,
    required this.bookedSlots,
    required this.sport,
    required this.venue,
    required this.teams,
  });

  factory CreateActivityMatch.fromJson(Map<String, dynamic> json) => CreateActivityMatch(
        id: json["id"] ?? 0,
        date: DateTime.tryParse(json["date"] ?? "") ?? DateTime.now(),
        sportId: json["sport_id"] ?? "",
        venueId: json["venue_id"] ?? 0,
        groundId: json["ground_id"],
        addOns: json["add_ons"],
        morningAvailability: json["morning_availability"] is List ? js.jsonEncode(json["morning_availability"]) : json["morning_availability"] ?? "",
        eveningAvailability: json["evening_availability"] is List ? js.jsonEncode(json["evening_availability"]) : json["evening_availability"] ?? "",
        matchType: json["match_type"] ?? "",
        teamId: json["team_id"],
        tellusAboutTeam: json["tellus_about_team"],
        activityAccess: json["activity_access"] ?? "",
        splitCost: json["split_cost"],
        createdAt: DateTime.tryParse(json["created_at"] ?? "") ?? DateTime.now(),
        updatedAt: DateTime.tryParse(json["updated_at"] ?? "") ?? DateTime.now(),
        rules: List<String>.from(json["rules"] ?? []),
        winningPrice: json["winning_price"] ?? "",
        teamRequired: json["team_required"] ?? "",
        entryFees: json["entry_fees"] ?? "",
        numberOfPlayers: json["number_of_players"] ?? "",
        type: json["type"] ?? "",
        createdBy: json["created_by"] ?? "",
        bookedSlots: List<String>.from(json["booked_slots"] ?? []),
        sport: CreateActivitySport.fromJson(json["sport"] ?? {}),
        venue: Venue.fromJson(json["venue"] ?? {}),
        teams: json["teams"] != null ? List<ActivityTeam>.from(json["teams"].map((x) => ActivityTeam.fromJson(x))) : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "sport_id": sportId,
        "venue_id": venueId,
        "ground_id": groundId,
        "add_ons": addOns,
        "morning_availability": morningAvailability,
        "evening_availability": eveningAvailability,
        "match_type": matchType,
        "team_id": teamId,
        "tellus_about_team": tellusAboutTeam,
        "activity_access": activityAccess,
        "split_cost": splitCost,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "rules": rules,
        "winning_price": winningPrice,
        "team_required": teamRequired,
        "entry_fees": entryFees,
        "number_of_players": numberOfPlayers,
        "type": type,
        "created_by": createdBy,
        "booked_slots": bookedSlots,
        "sport": sport.toJson(),
        "venue": venue.toJson(),
        "teams": teams.map((x) => x.toJson()).toList(),
      };
}

class ActivityTeam {
  int id;
  String? name;
  String? logo;
  int? teamLeader;
  String sportId;
  DateTime createdAt;
  DateTime updatedAt;
  List<Invited> players;
  List<dynamic> joinRequests;
  List<Invited> invited;
  int? pendingPlayers;

  ActivityTeam({
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

  factory ActivityTeam.fromJson(Map<String, dynamic> json) => ActivityTeam(
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
  int playerId;
  String playerName;
  String playerPicture;
  String playerType;
  String playerPoints;

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

class CreateActivitySport {
  int id;
  String name;
  String image;
  int teamPlayers;
  dynamic description;
  DateTime createdAt;
  DateTime updatedAt;

  CreateActivitySport({
    required this.id,
    required this.name,
    required this.image,
    required this.teamPlayers,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CreateActivitySport.fromJson(Map<String, dynamic> json) => CreateActivitySport(
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

class Venue {
  int id;
  int userId;
  String role;
  String name;
  String email;
  String phone;
  String address;
  dynamic latitude;
  dynamic longitude;
  String? profilePicture;
  int? numberOfGrounds;
  String openingHour;
  String closingHour;
  String workingDays;
  int longTermBooking;
  DateTime createdAt;
  DateTime updatedAt;
  String? ratings;
  int? wishlist;
  String? establishedDate;
  String? deletedAt;
  String? futureDeletedDate;
  int dayBeforeCalcelation;
  dynamic umpires;
  dynamic commentators;
  dynamic tax;
  dynamic otherCharges;

  Venue({
    required this.id,
    required this.userId,
    required this.role,
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
    required this.dayBeforeCalcelation,
    required this.umpires,
    required this.commentators,
    required this.tax,
    required this.otherCharges,
  });

  factory Venue.fromJson(Map<String, dynamic> json) => Venue(
        id: json["id"],
        userId: json["user_id"],
        role: json["role"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        profilePicture: json["profile_picture"],
        numberOfGrounds: json["number_of_grounds"],
        openingHour: json["opening_hour"],
        closingHour: json["closing_hour"],
        workingDays: json["working_days"],
        longTermBooking: json["long_term_booking"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        ratings: json["ratings"],
        wishlist: json["wishlist"],
        establishedDate: json["established_date"],
        deletedAt: json["deleted_at"],
        futureDeletedDate: json["future_deleted_date"],
        dayBeforeCalcelation: json["day_before_calcelation"] ?? 5,
        umpires: json["umpires"],
        commentators: json["commentators"],
        tax: json["tax"],
        otherCharges: json["other_charges"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "role": role,
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
        "day_before_calcelation": dayBeforeCalcelation,
        "umpires": umpires,
        "commentators": commentators,
        "tax": tax,
        "other_charges": otherCharges,
      };
}
