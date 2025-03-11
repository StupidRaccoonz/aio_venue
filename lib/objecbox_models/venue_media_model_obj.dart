// To parse this JSON data, do
//
//     final venueMediaModel = venueMediaModelFromJson(jsonString);

import 'dart:convert' as js;

import 'package:objectbox/objectbox.dart';

VenueMediaModelObj venueMediaModelObjFromJson(String str) => VenueMediaModelObj.fromJson(js.json.decode(str));

String venueMediaModelObjToJson(VenueMediaModelObj data) => js.json.encode(data.toJson());

@Entity()
class VenueMediaModelObj {
  @Id(assignable: true)
  int id = 6;
  final int httpCode;
  final String message;
  final String? data;

  VenueMediaModelObj({
    required this.httpCode,
    required this.message,
    required this.data,
  });

  factory VenueMediaModelObj.fromJson(Map<String, dynamic> json) => VenueMediaModelObj(
        httpCode: json["http_code"],
        message: json["message"],
        data: json["http_code"] == 200 ? js.json.encode(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "http_code": httpCode,
        "message": message,
        "data": data,
      };
}
