// To parse this JSON data, do
//
//     final venueReviewDataModel = venueReviewDataModelFromJson(jsonString);
import 'dart:convert';

VenueReviewDataModel venueReviewDataModelFromJson(String str) => VenueReviewDataModel.fromJson(json.decode(str));

String venueReviewDataModelToJson(VenueReviewDataModel data) => json.encode(data.toJson());

class VenueReviewDataModel {
  int httpCode;
  String message;
  Data data;

  VenueReviewDataModel({
    required this.httpCode,
    required this.message,
    required this.data,
  });

  factory VenueReviewDataModel.fromJson(Map<String, dynamic> json) => VenueReviewDataModel(
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
  Review review;

  Data({
    required this.review,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        review: Review.fromJson(json["review"]),
      );

  Map<String, dynamic> toJson() => {
        "review": review.toJson(),
      };
}

class Review {
  int currentPage;
  List<ReviewItem> data;
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
        data: List<ReviewItem>.from(json["data"].map((x) => ReviewItem.fromJson(x))),
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

class ReviewItem {
  int reviewedBy;
  int id;
  String reviewedByRole;
  int reviewedFor;
  String reviewedForRole;
  int rating;
  String comment;
  String status;
  DateTime date;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String profilePicture;

  ReviewItem({
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

  factory ReviewItem.fromJson(Map<String, dynamic> json) => ReviewItem(
        reviewedBy: json["reviewed_by"],
        id: json["id"],
        reviewedByRole: json["reviewed_by_role"],
        reviewedFor: json["reviewed_for"],
        reviewedForRole: json["reviewed_for_role"],
        rating: json["rating"],
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
  String url;
  String label;
  bool active;

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
