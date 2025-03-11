// To parse this JSON data, do
//
//     final venueCreateActivityRequestModel = venueCreateActivityRequestModelFromJson(jsonString);

import 'dart:convert';

VenueCreateActivityRequestModel venueCreateActivityRequestModelFromJson(String str) => VenueCreateActivityRequestModel.fromJson(json.decode(str));

String venueCreateActivityRequestModelToJson(VenueCreateActivityRequestModel data) => json.encode(data.toJson());

class VenueCreateActivityRequestModel {
  DateTime date;
  int numberOfPlayers;
  int sportId;
  List<String> morningAvailability;
  List<String> eveningAvailability;
  List<String> bookedSlots;
  List<String> rules;
  String entryFees;
  int venueId;
  String teamRequired;
  String winningPrice;
  String createdBy;

  VenueCreateActivityRequestModel({
    required this.date,
    required this.numberOfPlayers,
    required this.sportId,
    required this.morningAvailability,
    required this.eveningAvailability,
    required this.bookedSlots,
    required this.rules,
    required this.entryFees,
    required this.venueId,
    required this.teamRequired,
    required this.winningPrice,
    required this.createdBy,
  });

  factory VenueCreateActivityRequestModel.fromJson(Map<String, dynamic> json) => VenueCreateActivityRequestModel(
        date: DateTime.parse(json["date"]),
        numberOfPlayers: json["number_of_players"],
        sportId: json["sport_id"],
        morningAvailability: List<String>.from(json["morning_availability"].map((x) => x)),
        eveningAvailability: List<String>.from(json["evening_availability"].map((x) => x)),
        bookedSlots: List<String>.from(json["booked_slots"].map((x) => x)),
        rules: List<String>.from(json["rules"].map((x) => x)),
        entryFees: json["entry_fees"],
        venueId: json["venue_id"],
        teamRequired: json["team_required"],
        winningPrice: json["winning_price"],
        createdBy: json["created_by"],
      );

  Map<String, dynamic> toJson() => {
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "number_of_players": numberOfPlayers,
        "sport_id": sportId,
        "morning_availability": List<dynamic>.from(morningAvailability.map((x) => x)),
        "evening_availability": List<dynamic>.from(eveningAvailability.map((x) => x)),
        "booked_slots": List<dynamic>.from(bookedSlots.map((x) => x)),
        "rules": List<dynamic>.from(rules.map((x) => x)),
        "entry_fees": entryFees,
        "venue_id": venueId,
        "team_required": teamRequired,
        "winning_price": winningPrice,
        "created_by": createdBy,
      };
}
