// To parse this JSON data, do
//
//     final venueDetailsModel = venueDetailsModelFromJson(jsonString);

import 'dart:convert' as js;

VenueDetailsModel venueDetailsModelFromJson(String str) => VenueDetailsModel.fromJson(js.json.decode(str));

String venueDetailsModelToJson(VenueDetailsModel data) => js.json.encode(data.toJson());

class VenueDetailsModel {
  int httpCode;
  String message;
  Data? data;

  VenueDetailsModel({
    required this.httpCode,
    required this.message,
    required this.data,
  });

  factory VenueDetailsModel.fromJson(Map<String, dynamic> json) => VenueDetailsModel(
        httpCode: json["http_code"],
        message: json["message"],
        data: Data.fromJson(json["data"] is String ? js.json.decode(json["data"]) : json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "http_code": httpCode,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Venue venue;

  Data({
    required this.venue,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        venue: json["venue"] is List ? json["venue"].map((x) => Venue.fromJson(x)).toList().first : Venue.fromJson(json['venue']),
      );

  Map<String, dynamic> toJson() => {
        "venue": venue.toJson(),
      };
}

class Venue {
  int id;
  int userId;
  String? role;
  String name;
  String email;
  String? phone;
  String address;
  String? latitude;
  String? longitude;
  String? profilePicture;
  int? numberOfGrounds;
  String openingHour;
  String closingHour;
  List<WorkingDay>? workingDays;
  int longTermBooking;
  DateTime createdAt;
  DateTime updatedAt;
  String? ratings;
  int? wishlist;
  String? establishedDate;
  String? deletedAt;
  String? futureDeletedDate;
  int? dayBeforeCalcelation;
  dynamic umpires;
  dynamic commentators;
  dynamic tax;
  dynamic otherCharges;
  dynamic roles;
  List<Ground> grounds;
  List<Sport>? sports;
  List<FacilitiesVenue> facilitiesVenues;

  Venue({
    required this.id,
    required this.userId,
    required this.role,
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
    required this.dayBeforeCalcelation,
    required this.umpires,
    required this.commentators,
    required this.tax,
    required this.otherCharges,
    required this.roles,
    required this.grounds,
    required this.sports,
    required this.facilitiesVenues,
  });

  factory Venue.fromJson(Map<String, dynamic> json) => Venue(
        id: json["id"],
        userId: json["user_id"],
        role: json["role"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        profilePicture: json["profile_picture"],
        numberOfGrounds: json["number_of_grounds"] is String ? int.parse(json["number_of_grounds"]) : json["number_of_grounds"],
        openingHour: json["opening_hour"],
        closingHour: json["closing_hour"],
        workingDays: json["working_days"] != null
            ? json["working_days"] is List<WorkingDay>
                ? json["working_days"]
                : List<WorkingDay>.from(json["working_days"].map((x) => WorkingDay.fromJson(x)))
            : <WorkingDay>[],
        longTermBooking: json["long_term_booking"] is String ? int.parse(json["long_term_booking"]) : json["long_term_booking"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        ratings: json["ratings"],
        wishlist: json["wishlist"] != null
            ? json["wishlist"] is int
                ? json["wishlist"]
                : int.parse(json["wishlist"])
            : 0,
        establishedDate: json["established_date"],
        deletedAt: json["deleted_at"],
        futureDeletedDate: json["future_deleted_date"],
        dayBeforeCalcelation: json["day_before_calcelation"],
        umpires: json["umpires"],
        commentators: json["commentators"],
        tax: json["tax"],
        otherCharges: json["other_charges"],
        roles: json["roles"],
        grounds: json["grounds"] != null ? List<Ground>.from(json["grounds"].map((x) => x is Ground ? x : Ground.fromJson(x))) : [],
        sports: json["sports"] != null ? List<Sport>.from(json["sports"].map((x) => Sport.fromJson(x))) : [],
        facilitiesVenues:
            json["facilities_venues"] != null ? List<FacilitiesVenue>.from(json["facilities_venues"].map((x) => FacilitiesVenue.fromJson(x))) : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "role": role,
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
        "working_days": workingDays == null ? [] : List<dynamic>.from(workingDays!.map((x) => x.toJson())),
        "long_term_booking": longTermBooking,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "ratings": ratings,
        "wishlist": wishlist,
        "established_date": establishedDate,
        "deleted_at": deletedAt,
        "future_deleted_date": futureDeletedDate,
        "day_before_calcelation": dayBeforeCalcelation,
        "umpires": umpires,
        "commentators": commentators,
        "tax": tax,
        "other_charges": otherCharges,
        "roles": roles,
        "grounds": grounds.isEmpty ? [] : List<dynamic>.from(grounds.map((x) => x.toJson())),
        "sports": sports == null ? null : List<dynamic>.from(sports!.map((x) => x.toJson())),
        "facilities_venues": facilitiesVenues,
      };
}

class FacilitiesVenue {
  int id;
  int? sportId;
  String name;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  FacilitiesVenuePivot? pivot;

  FacilitiesVenue({
    required this.id,
    required this.sportId,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  factory FacilitiesVenue.fromJson(Map<String, dynamic> json) => FacilitiesVenue(
        id: json["id"],
        sportId: json["sport_id"],
        name: json["name"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: json["pivot"] == null ? null : FacilitiesVenuePivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sport_id": sportId,
        "name": name,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pivot": pivot?.toJson(),
      };
}

class FacilitiesVenuePivot {
  int venueId;
  int facilityId;

  FacilitiesVenuePivot({
    required this.venueId,
    required this.facilityId,
  });

  factory FacilitiesVenuePivot.fromJson(Map<String, dynamic> json) => FacilitiesVenuePivot(
        venueId: json["venue_id"],
        facilityId: json["facility_id"],
      );

  Map<String, dynamic> toJson() => {
        "venue_id": venueId,
        "facility_id": facilityId,
      };
}

class Ground {
  int id;
  int venueId;
  int sportsId;
  String? groundType;
  String? name;
  String? groundSize;
  String? unit;
  String? hourlyRent;
  String? addedBy;
  List<String> morningAvailability;
  List<String> eveningAvailability;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;
  String? futureDeletedDate;
  List<Grounditem> grounditems;

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
        morningAvailability: json["morning_availability"] == null ? [] : List<String>.from(json["morning_availability"].map((x) => x)),
        eveningAvailability: json["evening_availability"] == null ? [] : List<String>.from(json["evening_availability"].map((x) => x)),
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
  int id;
  int venueId;
  String? itemName;
  String? rentPrice;
  int quality;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  int groundId;

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
        quality: json["quality"] ?? 1,
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
  int? id;
  String? name;
  String? image;
  int? teamPlayers;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  SportPivot? pivot;

  Sport({
     this.id,
     this.name,
     this.image,
     this.teamPlayers,
     this.description,
     this.createdAt,
     this.updatedAt,
     this.pivot,
  });

  factory Sport.fromJson(Map<String, dynamic> json) => Sport(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        teamPlayers: json["team_players"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: SportPivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "team_players": teamPlayers,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "pivot": pivot?.toJson(),
      };
}

class SportPivot {
  int venueId;
  int sportsId;

  SportPivot({
    required this.venueId,
    required this.sportsId,
  });

  factory SportPivot.fromJson(Map<String, dynamic> json) => SportPivot(
        venueId: json["venue_id"],
        sportsId: json["sports_id"],
      );

  Map<String, dynamic> toJson() => {
        "venue_id": venueId,
        "sports_id": sportsId,
      };
}

class WorkingDay {
  String status;
  String day;

  WorkingDay({
    required this.status,
    required this.day,
  });

  factory WorkingDay.fromJson(Map<String, dynamic> json) => WorkingDay(
        status: json["status"],
        day: json["day"],
      );

  Map<String, dynamic> toJson() => {
        "status": status.toString(),
        "day": day,
      };
}
