// To parse this JSON data, do
//
//     final getFacilitiesModel = getFacilitiesModelFromJson(jsonString);
import 'dart:convert';

GetFacilitiesModel getFacilitiesModelFromJson(String str) => GetFacilitiesModel.fromJson(json.decode(str));

String getFacilitiesModelToJson(GetFacilitiesModel data) => json.encode(data.toJson());

class GetFacilitiesModel {
  int httpCode;
  String message;
  Data data;

  GetFacilitiesModel({
    required this.httpCode,
    required this.message,
    required this.data,
  });

  factory GetFacilitiesModel.fromJson(Map<String, dynamic> json) => GetFacilitiesModel(
        httpCode: json["http_code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "http_code": httpCode,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  List<Facility> facilities;

  Data({
    required this.facilities,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        facilities: List<Facility>.from(json["facilities"].map((x) => Facility.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "facilities": List<dynamic>.from(facilities.map((x) => x.toJson())),
      };
}

class Facility {
  int id;
  int? sportId;
  String name;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  Facility({
    required this.id,
    required this.sportId,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Facility.fromJson(Map<String, dynamic> json) => Facility(
        id: json["id"],
        sportId: json["sport_id"],
        name: json["name"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sport_id": sportId,
        "name": name,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
