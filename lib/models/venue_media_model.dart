// To parse this JSON data, do
//
//     final venueMediaModel = venueMediaModelFromJson(jsonString);

import 'dart:convert' as js;

VenueMediaModel venueMediaModelFromJson(String str) => VenueMediaModel.fromJson(js.json.decode(str));

String venueMediaModelToJson(VenueMediaModel data) => js.json.encode(data.toJson());

class VenueMediaModel {
  final int httpCode;
  final String message;
  final Data? data;

  VenueMediaModel({
    required this.httpCode,
    required this.message,
    required this.data,
  });

  factory VenueMediaModel.fromJson(Map<String, dynamic> json) => VenueMediaModel(
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
  final List<String> photos;
  final List<String> videos;

  Data({
    required this.photos,
    required this.videos,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        photos: List<String>.from(json["photos"].map((x) => x)),
        videos: json["videos"] == null ? [] : List<String>.from(json["videos"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "photos": List<dynamic>.from(photos.map((x) => x)),
        "videos": List<dynamic>.from(videos.map((x) => x)),
      };
}
