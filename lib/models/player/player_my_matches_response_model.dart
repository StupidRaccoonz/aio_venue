// To parse this JSON data, do
//
//     final playerMyMatchesResponseModel = playerMyMatchesResponseModelFromJson(jsonString);

// ignore_for_file: constant_identifier_names
import 'dart:convert';

PlayerMyMatchesResponseModel playerMyMatchesResponseModelFromJson(String str) => PlayerMyMatchesResponseModel.fromJson(json.decode(str));

String playerMyMatchesResponseModelToJson(PlayerMyMatchesResponseModel data) => json.encode(data.toJson());

class PlayerMyMatchesResponseModel {
  final int httpCode;
  final String message;
  final Data data;

  PlayerMyMatchesResponseModel({
    required this.httpCode,
    required this.message,
    required this.data,
  });

  factory PlayerMyMatchesResponseModel.fromJson(Map<String, dynamic> json) => PlayerMyMatchesResponseModel(
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
  final List<Match> match;

  Data({
    required this.match,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        match: json.isEmpty ? <Match>[] : List<Match>.from(json["match"].map((x) => Match.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "match": List<dynamic>.from(match.map((x) => x.toJson())),
      };
}

class Match {
  final int id;
  final DateTime date;
  final String sportId;
  final int venueId;
  final int groundId;
  final List<AddOn> addOns;
  final List<String> morningAvailability;
  final List<String> eveningAvailability;
  final String matchType;
  final String teamId;
  final dynamic tellusAboutTeam;
  final String activityAccess;
  final String bookingStatus;
  final String? splitCost;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Sport sport;
  final Venue venue;
  final String? entryFees;
  final String? winningPrice;
  final String? teamRequired;
  final List<Team> teams;

  Match({
    required this.id,
    required this.date,
    required this.sportId,
    required this.venueId,
    required this.groundId,
    required this.addOns,
    required this.morningAvailability,
    required this.eveningAvailability,
    required this.matchType,
    required this.teamId,
    required this.tellusAboutTeam,
    required this.activityAccess,
    required this.bookingStatus,
    required this.splitCost,
    required this.createdAt,
    required this.updatedAt,
    required this.sport,
    required this.venue,
    required this.entryFees,
    required this.winningPrice,
    required this.teamRequired,
    required this.teams,
  });

  factory Match.fromJson(Map<String, dynamic> json) => Match(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        sportId: json["sport_id"],
        venueId: json["venue_id"],
        groundId: json["ground_id"],
        addOns: List<AddOn>.from(json["add_ons"].map((x) => AddOn.fromJson(x))),
        morningAvailability: List<String>.from(json["morning_availability"].map((x) => x)),
        eveningAvailability: List<String>.from(json["evening_availability"].map((x) => x)),
        matchType: json["match_type"],
        teamId: json["team_id"],
        tellusAboutTeam: json["tellus_about_team"],
        activityAccess: json["activity_access"],
        bookingStatus: json["booking_status"],
        splitCost: json["split_cost"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        sport: Sport.fromJson(json["sport"]),
        venue: Venue.fromJson(json["venue"]),
        entryFees: json["entry_fees"],
        winningPrice: json["winning_price"],
        teamRequired: json["team_required"],
        teams: json["teams"] == null ? <Team>[] : List<Team>.from(json["teams"].map((x) => Team.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "sport_id": sportId,
        "venue_id": venueId,
        "ground_id": groundId,
        "add_ons": List<dynamic>.from(addOns.map((x) => x.toJson())),
        "morning_availability": List<dynamic>.from(morningAvailability.map((x) => x)),
        "evening_availability": List<dynamic>.from(eveningAvailability.map((x) => x)),
        "match_type": matchType,
        "team_id": teamId,
        "tellus_about_team": tellusAboutTeam,
        "activity_access": activityAccess,
        "booking_status": bookingStatus,
        "split_cost": splitCost,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "sport": sport.toJson(),
        "venue": venue.toJson(),
        "entry_fees": entryFees,
        "winning_price": winningPrice,
        "team_required": teamRequired,
        "teams": List<dynamic>.from(teams.map((x) => x.toJson())),
      };
}

class AddOn {
  final String? price;
  final String? itemName;
  final String? quality;
  final String? itemId;

  AddOn({
    required this.price,
    required this.itemName,
    required this.quality,
    required this.itemId,
  });

  factory AddOn.fromJson(Map<String, dynamic> json) => AddOn(
        price: json["price"],
        itemName: json["item_name"],
        quality: json["quality"],
        itemId: json["item_id"],
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "item_name": itemName,
        "quality": quality,
        "item_id": itemId,
      };
}

enum BookingStatus { PENDING }

class Sport {
  final int id;
  final String name;
  final String image;
  final int teamPlayers;
  final String? description;
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
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Invited> players;
  final List<Invited> joinRequests;
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
        joinRequests: List<Invited>.from(json["join_requests"].map((x) => Invited.fromJson(x))),
        invited: List<Invited>.from(json["invited"].map((x) => Invited.fromJson(x))),
        pendingPlayers: json["pending_players"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
        "team_leader": teamLeader,
        "sport_id": sportId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "players": List<dynamic>.from(players.map((x) => x.toJson())),
        "join_requests": List<dynamic>.from(joinRequests.map((x) => x.toJson())),
        "invited": List<dynamic>.from(invited.map((x) => x.toJson())),
        "pending_players": pendingPlayers,
      };
}

class Invited {
  final int playerId;
  final String playerName;
  final String? playerPicture;
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

class Venue {
  final int id;
  final int userId;
  final String role;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String? latitude;
  final String? longitude;
  final String? profilePicture;
  final int numberOfGrounds;
  final String openingHour;
  final String closingHour;
  final List<WorkingDay> workingDays;
  final int longTermBooking;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? ratings;
  final int? wishlist;
  final DateTime? establishedDate;
  final DateTime? deletedAt;
  final DateTime? futureDeletedDate;
  final int dayBeforeCalcelation;
  final dynamic umpires;
  final dynamic commentators;
  final dynamic tax;
  final String? otherCharges;
  final String profileComplete;

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
    required this.profileComplete,
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
        workingDays: List<WorkingDay>.from(json["working_days"].map((x) => WorkingDay.fromJson(x))),
        longTermBooking: json["long_term_booking"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        ratings: json["ratings"],
        wishlist: json["wishlist"],
        establishedDate: json["established_date"] == null
            ? null
            : json["established_date"].contains("null")
                ? null
                : DateTime.parse(json["established_date"]),
        deletedAt: json["deleted_at"],
        futureDeletedDate: json["future_deleted_date"],
        dayBeforeCalcelation: json["day_before_calcelation"],
        umpires: json["umpires"],
        commentators: json["commentators"],
        tax: json["tax"],
        otherCharges: json["other_charges"],
        profileComplete: json["profile_complete"],
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
        "working_days": List<dynamic>.from(workingDays.map((x) => x.toJson())),
        "long_term_booking": longTermBooking,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "ratings": ratings,
        "wishlist": wishlist,
        "established_date":
            "${establishedDate?.year.toString().padLeft(4, '0')}-${establishedDate?.month.toString().padLeft(2, '0')}-${establishedDate?.day.toString().padLeft(2, '0')}",
        "deleted_at": deletedAt,
        "future_deleted_date": futureDeletedDate,
        "day_before_calcelation": dayBeforeCalcelation,
        "umpires": umpires,
        "commentators": commentators,
        "tax": tax,
        "other_charges": otherCharges,
        "profile_complete": profileComplete,
      };
}

class WorkingDay {
  final String status;
  final String day;

  WorkingDay({
    required this.status,
    required this.day,
  });

  factory WorkingDay.fromJson(Map<String, dynamic> json) => WorkingDay(
        status: json["status"],
        day: json["day"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "day": day,
      };
}
