// To parse this JSON data, do
//
//     final pauseGroundRequestModel = pauseGroundRequestModelFromJson(jsonString);

import 'dart:convert' as js;

PauseGroundRequestModel pauseGroundRequestModelFromJson(String str) =>
    PauseGroundRequestModel.fromJson(js.json.decode(str));

String pauseGroundRequestModelToJson(PauseGroundRequestModel data) => js.json.encode(data.toJson());

class PauseGroundRequestModel {
  String venueId;
  String sportsId;
  String groundId;
  String availabilitiesData;

  PauseGroundRequestModel({
    required this.venueId,
    required this.sportsId,
    required this.groundId,
    required this.availabilitiesData,
  });

  factory PauseGroundRequestModel.fromJson(Map<String, dynamic> json) => PauseGroundRequestModel(
        venueId: json["venue_id"],
        sportsId: json["sports_id"],
        groundId: json["ground_id"],
        availabilitiesData: List<AvailabilitiesData>.from(
            js.jsonDecode(json["availabilities_data"]).map((x) => AvailabilitiesData.fromJson(x))).toString(),
      );

  Map<String, dynamic> toJson() => {
        "venue_id": venueId,
        "sports_id": sportsId,
        "ground_id": groundId,
        "availabilities_data": availabilitiesData,
      };
}

class AvailabilitiesData {
  DateTime date;

  AvailabilitiesData({
    required this.date,
  });

  factory AvailabilitiesData.fromJson(Map<String, dynamic> json) => AvailabilitiesData(
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        // "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "date": date.toString().substring(0, 10),
      };
}
