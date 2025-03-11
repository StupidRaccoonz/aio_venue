// To parse this JSON data, do
//
//     final submitReportResponse = submitReportResponseFromJson(jsonString);

import 'dart:convert';

SubmitReportResponse submitReportResponseFromJson(String str) => SubmitReportResponse.fromJson(json.decode(str));

String submitReportResponseToJson(SubmitReportResponse data) => json.encode(data.toJson());

class SubmitReportResponse {
  int httpCode;
  String message;
  Data data;

  SubmitReportResponse({
    required this.httpCode,
    required this.message,
    required this.data,
  });

  SubmitReportResponse copyWith({
    int? httpCode,
    String? message,
    Data? data,
  }) =>
      SubmitReportResponse(
        httpCode: httpCode ?? this.httpCode,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory SubmitReportResponse.fromJson(Map<String, dynamic> json) => SubmitReportResponse(
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
  int userId;
  String userRole;
  int categoryId;
  String issue;
  DateTime date;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  Data({
    required this.userId,
    required this.userRole,
    required this.categoryId,
    required this.issue,
    required this.date,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  Data copyWith({
    int? userId,
    String? userRole,
    int? categoryId,
    String? issue,
    DateTime? date,
    DateTime? updatedAt,
    DateTime? createdAt,
    int? id,
  }) =>
      Data(
        userId: userId ?? this.userId,
        userRole: userRole ?? this.userRole,
        categoryId: categoryId ?? this.categoryId,
        issue: issue ?? this.issue,
        date: date ?? this.date,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        userRole: json["user_role"],
        categoryId: json["category_id"],
        issue: json["issue"],
        date: DateTime.parse(json["date"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_role": userRole,
        "category_id": categoryId,
        "issue": issue,
        "date": date.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
