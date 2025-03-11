// To parse this JSON data, do
//
//     final addGroundRequestModel = addGroundRequestModelFromJson(jsonString);

import 'dart:convert';

AddGroundRequestModel addGroundRequestModelFromJson(String str) => AddGroundRequestModel.fromJson(json.decode(str));

String addGroundRequestModelToJson(AddGroundRequestModel data) => json.encode(data.toJson());

class AddGroundRequestModel {
  int venueId;
  List<Ground> grounds;

  AddGroundRequestModel({
    required this.venueId,
    required this.grounds,
  });

  factory AddGroundRequestModel.fromJson(Map<String, dynamic> json) => AddGroundRequestModel(
        venueId: json["venue_id"],
        grounds: List<Ground>.from(json["grounds"].map((x) => Ground.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "venue_id": venueId,
        "grounds": List<dynamic>.from(grounds.map((x) => x.toJson())),
      };
}

class Ground {
  int sportsId;
  String groundType;
  String name;
  String groundSize;
  String unit;
  double hourlyRent;
  List<String> morningAvailability;
  List<String> eveningAvailability;
  List<AddOn> addOns;

  Ground({
    required this.sportsId,
    required this.groundType,
    required this.name,
    required this.groundSize,
    required this.unit,
    required this.hourlyRent,
    required this.morningAvailability,
    required this.eveningAvailability,
    required this.addOns,
  });

  factory Ground.fromJson(Map<String, dynamic> json) => Ground(
        sportsId: json["sports_id"],
        groundType: json["ground_type"],
        name: json["name"],
        groundSize: json["ground_size"],
        unit: json["unit"],
        hourlyRent: json["hourly_rent"] != "" ? double.parse(json["hourly_rent"]) : 0,
        morningAvailability: List<String>.from(json["morning_availability"].map((x) => x)),
        eveningAvailability: List<String>.from(json["evening_availability"].map((x) => x)),
        addOns: json["add_ons"] == null ? [] : List<AddOn>.from(json["add_ons"].map((x) => AddOn.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sports_id": sportsId,
        "ground_type": groundType,
        "name": name,
        "ground_size": groundSize,
        "unit": unit,
        "hourly_rent": hourlyRent,
        "morning_availability": List<dynamic>.from(morningAvailability.map((x) => x)),
        "evening_availability": List<dynamic>.from(eveningAvailability.map((x) => x)),
        "add_ons": List<dynamic>.from(addOns.map((x) => x.toJson())),
      };
}

class AddOn {
  String quality;
  String itemName;
  String rentPrice;

  AddOn({
    required this.quality,
    required this.itemName,
    required this.rentPrice,
  });

  factory AddOn.fromJson(Map<String, dynamic> json) => AddOn(
        quality: json["quality"],
        itemName: json["item_name"],
        rentPrice: json["rent_price"],
      );

  Map<String, dynamic> toJson() => {
        "quality": quality,
        "item_name": itemName,
        "rent_price": rentPrice,
      };
}
