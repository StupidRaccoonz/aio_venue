// To parse this JSON data, do
//
//     final editPauseGroundResponseModel = editPauseGroundResponseModelFromJson(jsonString);

import 'dart:convert';

EditPauseGroundResponseModel editPauseGroundResponseModelFromJson(String str) =>
    EditPauseGroundResponseModel.fromJson(json.decode(str));

String editPauseGroundResponseModelToJson(EditPauseGroundResponseModel data) => json.encode(data.toJson());

class EditPauseGroundResponseModel {
  int httpCode;
  String message;
  Data data;

  EditPauseGroundResponseModel({
    required this.httpCode,
    required this.message,
    required this.data,
  });

  EditPauseGroundResponseModel copyWith({
    int? httpCode,
    String? message,
    Data? data,
  }) =>
      EditPauseGroundResponseModel(
        httpCode: httpCode ?? this.httpCode,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory EditPauseGroundResponseModel.fromJson(Map<String, dynamic> json) => EditPauseGroundResponseModel(
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
  List<dynamic> bookedmatch;
  List<Pausedbooking> pausedbooking;

  Data({
    required this.bookedmatch,
    required this.pausedbooking,
  });

  Data copyWith({
    List<dynamic>? bookedmatch,
    List<Pausedbooking>? pausedbooking,
  }) =>
      Data(
        bookedmatch: bookedmatch ?? this.bookedmatch,
        pausedbooking: pausedbooking ?? this.pausedbooking,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bookedmatch: List<dynamic>.from(json["bookedmatch"].map((x) => x)),
        pausedbooking: List<Pausedbooking>.from(json["pausedbooking"].map((x) => Pausedbooking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bookedmatch": List<dynamic>.from(bookedmatch.map((x) => x)),
        "pausedbooking": List<dynamic>.from(pausedbooking.map((x) => x.toJson())),
      };
}

class Pausedbooking {
  DateTime date;

  Pausedbooking({
    required this.date,
  });

  Pausedbooking copyWith({
    DateTime? date,
  }) =>
      Pausedbooking(
        date: date ?? this.date,
      );

  factory Pausedbooking.fromJson(Map<String, dynamic> json) => Pausedbooking(
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      };
}
