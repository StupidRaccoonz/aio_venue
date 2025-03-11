// To parse this JSON data, do
//
//     final venueReviewsModel = venueReviewsModelFromJson(jsonString);

import 'dart:convert';

VenueReviewsModel venueReviewsModelFromJson(String str) => VenueReviewsModel.fromJson(json.decode(str));

String venueReviewsModelToJson(VenueReviewsModel data) => json.encode(data.toJson());

class VenueReviewsModel {
  int httpCode;
  String message;
  Data? data;

  VenueReviewsModel({
    required this.httpCode,
    required this.message,
    required this.data,
  });

  factory VenueReviewsModel.fromJson(Map<String, dynamic> json) => VenueReviewsModel(
        httpCode: json["http_code"],
        message: json["message"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "http_code": httpCode,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Review? review;

  Data({
    required this.review,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        review: json.isEmpty ? null : Review.fromJson(json["review"]),
      );

  Map<String, dynamic> toJson() => {
        "review": review?.toJson(),
      };
}

class Review {
  int currentPage;
  List<ReviewData> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  Review({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        currentPage: json["current_page"],
        data: List<ReviewData>.from(json["data"].map((x) => ReviewData.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class ReviewData {
  int reviewedBy;
  int id;
  String reviewedByRole;
  int reviewedFor;
  String reviewedForRole;
  double rating;
  String comment;
  String status;
  DateTime date;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String profilePicture;

  ReviewData({
    required this.reviewedBy,
    required this.id,
    required this.reviewedByRole,
    required this.reviewedFor,
    required this.reviewedForRole,
    required this.rating,
    required this.comment,
    required this.status,
    required this.date,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.profilePicture,
  });

  factory ReviewData.fromJson(Map<String, dynamic> json) => ReviewData(
        reviewedBy: json["reviewed_by"],
        id: json["id"],
        reviewedByRole: json["reviewed_by_role"],
        reviewedFor: json["reviewed_for"],
        reviewedForRole: json["reviewed_for_role"],
        rating: double.parse(json["rating"].toString()),
        comment: json["comment"],
        status: json["status"],
        date: DateTime.parse(json["date"]),
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        profilePicture: json["profile_picture"],
      );

  Map<String, dynamic> toJson() => {
        "reviewed_by": reviewedBy,
        "id": id,
        "reviewed_by_role": reviewedByRole,
        "reviewed_for": reviewedFor,
        "reviewed_for_role": reviewedForRole,
        "rating": rating,
        "comment": comment,
        "status": status,
        "date": date.toIso8601String(),
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "name": name,
        "profile_picture": profilePicture,
      };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
