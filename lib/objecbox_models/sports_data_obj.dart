import 'dart:convert' as js;

import 'package:objectbox/objectbox.dart';

SportsDatamodelObj sportsDatamodelFromJson(String str) => SportsDatamodelObj.fromJson(js.json.decode(str));

String sportsDatamodelToJson(SportsDatamodelObj data) => js.json.encode(data.toJson());

@Entity()
class SportsDatamodelObj {
  @Id(assignable: true)
  int id = 5;
  int httpCode;
  String message;
  String? data;

  SportsDatamodelObj({
    required this.httpCode,
    required this.message,
    required this.data,
  });

  factory SportsDatamodelObj.fromJson(Map<String, dynamic> json) => SportsDatamodelObj(
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
