// To parse this JSON data, do
//
//     final updateGroundRequestModel = updateGroundRequestModelFromJson(jsonString);

import 'dart:convert';

UpdateGroundRequestModel updateGroundRequestModelFromJson(String str) => UpdateGroundRequestModel.fromJson(json.decode(str));

String updateGroundRequestModelToJson(UpdateGroundRequestModel data) => json.encode(data.toJson());

class UpdateGroundRequestModel {
  Ground ground;

  UpdateGroundRequestModel({
    required this.ground,
  });

  factory UpdateGroundRequestModel.fromJson(Map<String, dynamic> json) => UpdateGroundRequestModel(
        ground: Ground.fromJson(json["ground"]),
      );

  Map<String, dynamic> toJson() => {"ground": ground.toJson()};
}

class Ground {
  int venueId;
  int groundId;
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
    required this.venueId,
    required this.groundId,
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
        venueId: json["venue_id"],
        groundId: json["ground_id"],
        sportsId: json["sports_id"],
        groundType: json["ground_type"],
        name: json["name"],
        groundSize: json["ground_size"],
        unit: json["unit"],
        hourlyRent: json["hourly_rent"]?.toDouble(),
        morningAvailability: List<String>.from(json["morning_availability"].map((x) => x)),
        eveningAvailability: List<String>.from(json["evening_availability"].map((x) => x)),
        addOns: List<AddOn>.from(json["add_ons"].map((x) => AddOn.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "venue_id": venueId,
        "ground_id": groundId,
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
