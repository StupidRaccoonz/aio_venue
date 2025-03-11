// To parse this JSON data, do
//
//     final successResponseModel = successResponseModelFromJson(jsonString);

import 'dart:convert';

SuccessResponseModel successResponseModelFromJson(String str) => SuccessResponseModel.fromJson(json.decode(str));

String successResponseModelToJson(SuccessResponseModel data) => json.encode(data.toJson());

class SuccessResponseModel {
  int httpCode;
  String message;

  SuccessResponseModel({
    required this.httpCode,
    required this.message,
  });

  factory SuccessResponseModel.fromJson(Map<String, dynamic> json) => SuccessResponseModel(
        httpCode: json["http_code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "http_code": httpCode,
        "message": message,
      };
}
