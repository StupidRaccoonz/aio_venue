import 'dart:convert' as js;

import 'package:objectbox/objectbox.dart';

VenueBookingsResponseModelObj venueBookingsResponseModelFromJson(String str) => VenueBookingsResponseModelObj.fromJson(js.json.decode(str));

String venueBookingsResponseModelToJson(VenueBookingsResponseModelObj data) => js.json.encode(data.toJson());

@Entity()
class VenueBookingsResponseModelObj {
  @Id(assignable: true)
  int id = 3;
  int httpCode;
  String message;
  String? data;

  VenueBookingsResponseModelObj({
    required this.httpCode,
    required this.message,
    required this.data,
  });

  factory VenueBookingsResponseModelObj.fromJson(Map<String, dynamic> json) => VenueBookingsResponseModelObj(
        httpCode: json["http_code"],
        message: json["message"],
        data: json["data"] != null ? js.json.encode(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "http_code": httpCode,
        "message": message,
        "data": data,
      };
}
