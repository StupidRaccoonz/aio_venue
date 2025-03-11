// To parse this JSON data, do
//
//     final sportsVenueListModel = sportsVenueListModelFromJson(jsonString);

import 'dart:convert';

SportsVenueListModel sportsVenueListModelFromJson(String str) => SportsVenueListModel.fromJson(json.decode(str));

String sportsVenueListModelToJson(SportsVenueListModel data) => json.encode(data.toJson());

class SportsVenueListModel {
  final int httpCode;
  final String message;
  final Data? data;
  final int venueCount;

  SportsVenueListModel({
    required this.httpCode,
    required this.message,
    required this.data,
    required this.venueCount,
  });

  factory SportsVenueListModel.fromJson(Map<String, dynamic> json) => SportsVenueListModel(
        httpCode: json["http_code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        venueCount: json["venue_count"],
      );

  Map<String, dynamic> toJson() => {
        "http_code": httpCode,
        "message": message,
        "data": data?.toJson(),
        "venue_count": venueCount,
      };
}

class Data {
  final int currentPage;
  final List<Venue>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Link> links;
  final dynamic nextPageUrl;
  final String? path;
  final int? perPage;
  final String? prevPageUrl;
  final int? to;
  final int? total;

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<Venue>.from(json["data"].map((x) => Venue.fromJson(x))),
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
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
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

class Venue {
  final int id;
  final int userId;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String? latitude;
  final String? longitude;
  final String? profilePicture;
  final int numberOfGrounds;
  final String? openingHour;
  final String? closingHour;
  final List<WorkingDay> workingDays;
  final int longTermBooking;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? ratings;
  final int? wishlist;
  final String? establishedDate;
  final String? deletedAt;
  final String? futureDeletedDate;
  final int distance;
  final double? ratingAvarage;
  final double ratingCount;
  final List<Sport> sports;
  final List<Ground> grounds;
  final String isWishlist;

  Venue({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.profilePicture,
    required this.numberOfGrounds,
    required this.openingHour,
    required this.closingHour,
    required this.workingDays,
    required this.longTermBooking,
    required this.createdAt,
    required this.updatedAt,
    required this.ratings,
    required this.wishlist,
    required this.establishedDate,
    required this.deletedAt,
    required this.futureDeletedDate,
    required this.distance,
    required this.ratingAvarage,
    required this.ratingCount,
    required this.sports,
    required this.grounds,
    required this.isWishlist,
  });

  factory Venue.fromJson(Map<String, dynamic> json) => Venue(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        profilePicture: json["profile_picture"],
        numberOfGrounds: json["number_of_grounds"],
        openingHour: json["opening_hour"],
        closingHour: json["closing_hour"],
        workingDays: List<WorkingDay>.from(json["working_days"].map((x) => WorkingDay.fromJson(x))),
        longTermBooking: json["long_term_booking"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        ratings: json["ratings"],
        wishlist: json["wishlist"],
        establishedDate: json["established_date"],
        deletedAt: json["deleted_at"],
        futureDeletedDate: json["future_deleted_date"],
        distance: json["distance"],
        ratingAvarage: json["rating_avarage"] + 0.0,
        ratingCount: json["rating_count"] + 0.0,
        sports: List<Sport>.from(json["sports"].map((x) => Sport.fromJson(x))),
        grounds: json["grounds"] != null ? List<Ground>.from(json["grounds"].map((x) => Ground.fromJson(x))) : <Ground>[],
        isWishlist: json["is_wishlist"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "profile_picture": profilePicture,
        "number_of_grounds": numberOfGrounds,
        "opening_hour": openingHour,
        "closing_hour": closingHour,
        "working_days": List<dynamic>.from(workingDays.map((x) => x.toJson())),
        "long_term_booking": longTermBooking,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "ratings": ratings,
        "wishlist": wishlist,
        "established_date": establishedDate,
        "deleted_at": deletedAt,
        "future_deleted_date": futureDeletedDate,
        "distance": distance,
        "rating_avarage": ratingAvarage,
        "rating_count": ratingCount,
        "sports": List<dynamic>.from(sports.map((x) => x.toJson())),
        "grounds": List<dynamic>.from(grounds.map((x) => x.toJson())),
        "is_wishlist": isWishlist,
      };
}

class Ground {
  final int id;
  final int venueId;
  final int sportsId;
  final String? groundType;
  final String? name;
  final String? groundSize;
  final dynamic unit;
  final String? hourlyRent;
  final dynamic addedBy;
  final List<String> morningAvailability;
  final List<String> eveningAvailability;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? deletedAt;
  final String? futureDeletedDate;
  final List<Grounditem> grounditems;

  Ground({
    required this.id,
    required this.venueId,
    required this.sportsId,
    required this.groundType,
    required this.name,
    required this.groundSize,
    required this.unit,
    required this.hourlyRent,
    required this.addedBy,
    required this.morningAvailability,
    required this.eveningAvailability,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.futureDeletedDate,
    required this.grounditems,
  });

  factory Ground.fromJson(Map<String, dynamic> json) => Ground(
        id: json["id"],
        venueId: json["venue_id"],
        sportsId: json["sports_id"],
        groundType: json["ground_type"],
        name: json["name"],
        groundSize: json["ground_size"],
        unit: json["unit"],
        hourlyRent: json["hourly_rent"],
        addedBy: json["added_by"],
        morningAvailability: List<String>.from(json["morning_availability"].map((x) => x)),
        eveningAvailability: List<String>.from(json["evening_availability"].map((x) => x)),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        futureDeletedDate: json["future_deleted_date"],
        grounditems: List<Grounditem>.from(json["grounditems"].map((x) => Grounditem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "venue_id": venueId,
        "sports_id": sportsId,
        "ground_type": groundType,
        "name": name,
        "ground_size": groundSize,
        "unit": unit,
        "hourly_rent": hourlyRent,
        "added_by": addedBy,
        "morning_availability": List<dynamic>.from(morningAvailability.map((x) => x)),
        "evening_availability": List<dynamic>.from(eveningAvailability.map((x) => x)),
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "future_deleted_date": futureDeletedDate,
        "grounditems": List<dynamic>.from(grounditems.map((x) => x.toJson())),
      };
}

class Grounditem {
  final int id;
  final int venueId;
  final String? itemName;
  final String? rentPrice;
  final int? quality;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int groundId;

  Grounditem({
    required this.id,
    required this.venueId,
    required this.itemName,
    required this.rentPrice,
    required this.quality,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.groundId,
  });

  factory Grounditem.fromJson(Map<String, dynamic> json) => Grounditem(
        id: json["id"],
        venueId: json["venue_id"],
        itemName: json["item_name"],
        rentPrice: json["rent_price"],
        quality: json["quality"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        groundId: json["ground_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "venue_id": venueId,
        "item_name": itemName,
        "rent_price": rentPrice,
        "quality": quality,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "ground_id": groundId,
      };
}

class Sport {
  final int id;
  final String? name;
  final String? image;
  final int teamPlayers;
  final dynamic description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Pivot pivot;

  Sport({
    required this.id,
    required this.name,
    required this.image,
    required this.teamPlayers,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  factory Sport.fromJson(Map<String, dynamic> json) => Sport(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        teamPlayers: json["team_players"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "team_players": teamPlayers,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pivot": pivot.toJson(),
      };
}

class Pivot {
  final int? venueId;
  final int sportsId;

  Pivot({
    required this.venueId,
    required this.sportsId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        venueId: json["venue_id"],
        sportsId: json["sports_id"],
      );

  Map<String, dynamic> toJson() => {
        "venue_id": venueId,
        "sports_id": sportsId,
      };
}

class WorkingDay {
  final String status;
  final String day;

  WorkingDay({
    required this.status,
    required this.day,
  });

  factory WorkingDay.fromJson(Map<String, dynamic> json) => WorkingDay(
        status: json["status"],
        day: json["day"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "day": day,
      };
}

class Link {
  final String? url;
  final String label;
  final bool active;

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
