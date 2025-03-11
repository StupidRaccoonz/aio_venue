// To parse this JSON data, do
//
//     final sportsDatamodel = sportsDatamodelFromJson(jsonString);
import 'dart:convert' as js;

SportsDatamodel sportsDatamodelFromJson(String str) => SportsDatamodel.fromJson(js.json.decode(str));

String sportsDatamodelToJson(SportsDatamodel data) => js.json.encode(data.toJson());

class SportsDatamodel {
  int httpCode;
  String message;
  Data? data;

  SportsDatamodel({
    required this.httpCode,
    required this.message,
    required this.data,
  });

  factory SportsDatamodel.fromJson(Map<String, dynamic> json) => SportsDatamodel(
        httpCode: json["http_code"],
        message: json["message"],
        data: json["http_code"] == 200 ? Data.fromJson(json["data"] is String ? js.json.decode(json["data"]) : json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "http_code": httpCode,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  List<Sport> sports;

  Data({
    required this.sports,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        sports: json["sports"] != null ? List<Sport>.from(json["sports"].map((x) => Sport.fromJson(x))) : [],
      );

  Map<String, dynamic> toJson() => {
        "sports": List<dynamic>.from(sports.map((x) => x.toJson())),
      };
}

class Sport {
  int id;
  String name;
  String image;
  int teamPlayers;
  String? description;
  DateTime createdAt;
  DateTime updatedAt;
  List<Sportsize> sportsizes;

  Sport({
    required this.id,
    required this.name,
    required this.image,
    required this.teamPlayers,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.sportsizes,
  });

  factory Sport.fromJson(Map<String, dynamic> json) => Sport(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        teamPlayers: json["team_players"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        sportsizes: json["sportsizes"] == null ? [] : List<Sportsize>.from(json["sportsizes"].map((x) => Sportsize.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "team_players": teamPlayers,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "sportsizes": List<dynamic>.from(sportsizes.map((x) => x.toJson())),
      };
}

class Sportsize {
  int id;
  int sportsId;
  String size;
  DateTime createdAt;
  DateTime updatedAt;

  Sportsize({
    required this.id,
    required this.sportsId,
    required this.size,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Sportsize.fromJson(Map<String, dynamic> json) => Sportsize(
        id: json["id"],
        sportsId: json["sports_id"],
        size: json["size"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sports_id": sportsId,
        "size": size,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
