import 'dart:convert' as js;

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(js.json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => js.json.encode(data.toJson());

LoginDetails loginDetailsFromJson(String str) => LoginDetails.fromJson(js.json.decode(str));

String productToJson(LoginDetails data) => data.toJson().toString();

User userFromJson(String str) => User.fromJson(js.json.decode(str));

String userToJson(User data) => js.json.encode(data);

List<Role> roleFromJson(String str) => js.json.decode(str);

String roleToJson(List<Role> data) => js.json.encode(data);

Pivot pivotFromJson(String str) => js.json.decode(str);

String pivotToJson(Pivot data) => js.json.encode(data);

class LoginResponseModel {
  int httpCode;
  String message;
  LoginDetails? data;

  LoginResponseModel({
    required this.httpCode,
    required this.message,
    required this.data,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        httpCode: json["http_code"],
        message: json["message"],
        data: json["http_code"] == 200 ? LoginDetails.fromJson(json["data"] is String ? js.json.decode(json["data"]) : json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "http_code": httpCode,
        "message": message,
        "data": data?.toJson(),
      };
}

class LoginDetails {
  User user;
  int venueId;
  int coachId;
  int playerId;

  LoginDetails({
    required this.user,
    required this.venueId,
    required this.coachId,
    required this.playerId,
  });

  factory LoginDetails.fromJson(Map<String, dynamic> json) => LoginDetails(
        user: User.fromJson(json["user"]),
        venueId: json["venue_id"],
        coachId: json["coach_id"],
        playerId: json["player_id"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "venue_id": venueId,
        "coach_id": coachId,
        "player_id": playerId,
      };
}

class User {
  int iD;
  String? name;
  String email;
  String? emailVerifiedAt;
  String? phone;
  DateTime createdAt;
  DateTime updatedAt;
  String detail;
  String media;
  String facilities;
  String ground;
  String? otp;
  String? otpExpired;
  String? deletedReason;
  String? deletedAt;
  String token;
  List<Role> roles;

  User({
    required this.iD,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
    required this.detail,
    required this.media,
    required this.facilities,
    required this.ground,
    required this.otp,
    required this.otpExpired,
    required this.deletedReason,
    required this.deletedAt,
    required this.token,
    required this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        iD: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        phone: json["phone"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        detail: json["detail"],
        media: json["media"],
        facilities: json["facilities"],
        ground: json["ground"],
        otp: json["otp"],
        otpExpired: json["otp_expired"],
        deletedReason: json["deleted_reason"],
        deletedAt: json["deleted_at"],
        token: json["token"],
        roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": iD,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "phone": phone,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "detail": detail,
        "media": media,
        "facilities": facilities,
        "ground": ground,
        "otp": otp,
        "otp_expired": otpExpired,
        "deleted_reason": deletedReason,
        "deleted_at": deletedAt,
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
