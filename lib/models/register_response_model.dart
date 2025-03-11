// To parse this JSON data, do
//
//     final registerResponseModel = registerResponseModelFromJson(jsonString);

import 'dart:convert';

RegisterResponseModel registerResponseModelFromJson(String str) => RegisterResponseModel.fromJson(json.decode(str));

String registerResponseModelToJson(RegisterResponseModel data) => json.encode(data.toJson());

class RegisterResponseModel {
  int httpCode;
  String message;
  UserData data;

  RegisterResponseModel({
    required this.httpCode,
    required this.message,
    required this.data,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) => RegisterResponseModel(
        httpCode: json["http_code"],
        message: json["message"],
        data: UserData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "http_code": httpCode,
        "message": message,
        "data": data.toJson(),
      };
}

class UserData {
  User? user;

  UserData({
    required this.user,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
      };
}

class User {
  String phone;
  String email;
  String? deviceToken;
  DateTime updatedAt;
  DateTime createdAt;
  int id;
  String userType;
  String token;
  List<Role> roles;

  User({
    required this.phone,
    required this.email,
    required this.deviceToken,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.userType,
    required this.token,
    required this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        phone: json["phone"],
        email: json["email"],
        deviceToken: json["device_token"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        userType: json["user_type"],
        token: json["token"],
        roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "email": email,
        "device_token": deviceToken,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
        "user_type": userType,
        "token": token,
        "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
      };
}

class Role {
  int id;
  int userId;
  String name;
  String slug;
  DateTime createdAt;
  DateTime updatedAt;
  Pivot pivot;

  Role({
    required this.id,
    required this.userId,
    required this.name,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        slug: json["slug"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "slug": slug,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pivot": pivot.toJson(),
      };
}

class Pivot {
  int userId;
  int roleId;

  Pivot({
    required this.userId,
    required this.roleId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        userId: json["user_id"],
        roleId: json["role_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "role_id": roleId,
      };
}
