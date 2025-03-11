// To parse this JSON data, do
//
//     final playerCreateMatcheRequestModel = playerCreateMatcheRequestModelFromJson(jsonString);

import 'dart:convert';

PlayerCreateMatcheRequestModel playerCreateMatcheRequestModelFromJson(String str) => PlayerCreateMatcheRequestModel.fromJson(json.decode(str));

String playerCreateMatcheRequestModelToJson(PlayerCreateMatcheRequestModel data) => json.encode(data.toJson());

class PlayerCreateMatcheRequestModel {
  final int playerId;
  final List<String> bookedSlots;
  final int venueId;
  final String activityAccess;
  final int groundId;
  final List<String> morningAvailability;
  final String splitCost;
  final String createdBy;
  final DateTime date;
  final String matchType;
  final List<AddOn> addOns;
  final List<String> eveningAvailability;
  final int teamId;
  final String tellusAboutTeam;
  final int sportId;

  PlayerCreateMatcheRequestModel({
    required this.playerId,
    required this.bookedSlots,
    required this.venueId,
    required this.activityAccess,
    required this.groundId,
    required this.morningAvailability,
    required this.splitCost,
    required this.createdBy,
    required this.date,
    required this.matchType,
    required this.addOns,
    required this.eveningAvailability,
    required this.teamId,
    required this.tellusAboutTeam,
    required this.sportId,
  });

  factory PlayerCreateMatcheRequestModel.fromJson(Map<String, dynamic> json) => PlayerCreateMatcheRequestModel(
        playerId: json["player_id"],
        bookedSlots: List<String>.from(json["booked_slots"].map((x) => x)),
        venueId: json["venue_id"],
        activityAccess: json["activity_access"],
        groundId: json["ground_id"],
        morningAvailability: List<String>.from(json["morning_availability"].map((x) => x)),
        splitCost: json["split_cost"],
        createdBy: json["created_by"],
        date: DateTime.parse(json["date"]),
        matchType: json["match_type"],
        addOns: List<AddOn>.from(json["add_ons"].map((x) => AddOn.fromJson(x))),
        eveningAvailability: List<String>.from(json["evening_availability"].map((x) => x)),
        teamId: json["team_id"],
        tellusAboutTeam: json["tellus_about_team"],
        sportId: json["sport_id"],
      );

  Map<String, dynamic> toJson() => {
        "player_id": playerId,
        "booked_slots": List<dynamic>.from(bookedSlots.map((x) => x)),
        "venue_id": venueId,
        "activity_access": activityAccess,
        "ground_id": groundId,
        "morning_availability": List<dynamic>.from(morningAvailability.map((x) => x)),
        "split_cost": splitCost,
        "created_by": createdBy,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "match_type": matchType,
        "add_ons": List<dynamic>.from(addOns.map((x) => x.toJson())),
        "evening_availability": List<dynamic>.from(eveningAvailability.map((x) => x)),
        "team_id": teamId,
        "tellus_about_team": tellusAboutTeam,
        "sport_id": sportId,
      };
}

class AddOn {
  final String itemId;
  final String quality;

  AddOn({
    required this.itemId,
    required this.quality,
  });

  factory AddOn.fromJson(Map<String, dynamic> json) => AddOn(
        itemId: json["item_id"],
        quality: json["quality"],
      );

  Map<String, dynamic> toJson() => {
        "item_id": itemId,
        "quality": quality,
      };
}
