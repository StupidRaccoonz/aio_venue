import 'dart:convert' as js;
import 'package:objectbox/objectbox.dart';

VenueDetailsModelObj venueDetailsModelObjFromJson(String str) => VenueDetailsModelObj.fromJson(js.json.decode(str));

String venueDetailsModelObjToJson(VenueDetailsModelObj data) => js.json.encode(data.toJson());

@Entity()
class VenueDetailsModelObj {
  @Id(assignable: true)
  int id = 2;
  int httpCode;
  String message;
  String? data;

  VenueDetailsModelObj({
    required this.httpCode,
    required this.message,
    required this.data,
  });

  factory VenueDetailsModelObj.fromJson(Map<String, dynamic> json) => VenueDetailsModelObj(
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
