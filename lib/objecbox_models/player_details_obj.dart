// To parse this JSON data, do
//
//     final playerDetailsModel = playerDetailsModelFromJson(jsonString);

import 'dart:convert' as js;
import 'package:objectbox/objectbox.dart';

PlayerDetailsModelObj playerDetailsModelObjFromJson(String str) => PlayerDetailsModelObj.fromJson(js.json.decode(str));

String playerDetailsModelObjToJson(PlayerDetailsModelObj data) => js.json.encode(data.toJson());

@Entity()
class PlayerDetailsModelObj {
  @Id(assignable: true)
  int id = 7;
  int httpCode;
  String message;
  String? data;

  PlayerDetailsModelObj({
    required this.httpCode,
    required this.message,
    required this.data,
  });

  factory PlayerDetailsModelObj.fromJson(Map<String, dynamic> json) => PlayerDetailsModelObj(
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
