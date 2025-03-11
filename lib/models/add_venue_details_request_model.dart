// To parse this JSON data, do
//
//     final addVenueDetailsRequestModel = addVenueDetailsRequestModelFromJson(jsonString);
import 'dart:convert';

AddVenueDetailsRequestModel addVenueDetailsRequestModelFromJson(String str) => AddVenueDetailsRequestModel.fromJson(json.decode(str));

String addVenueDetailsRequestModelToJson(AddVenueDetailsRequestModel data) => json.encode(data.toJson());

class AddVenueDetailsRequestModel {
  String name;
  String address;
  String openingHour;
  String closingHour;
  String workingDays;
  String sports;
  String longTermBooking;
  String numberOfGrounds;
  String ratings;
  String wishlist;

  AddVenueDetailsRequestModel({
    required this.name,
    required this.address,
    required this.openingHour,
    required this.closingHour,
    required this.workingDays,
    required this.sports,
    required this.longTermBooking,
    required this.numberOfGrounds,
    required this.ratings,
    required this.wishlist,
  });

  factory AddVenueDetailsRequestModel.fromJson(Map<String, dynamic> json) => AddVenueDetailsRequestModel(
        name: json["name"],
        address: json["address"],
        openingHour: json["opening_hour"],
        closingHour: json["closing_hour"],
        workingDays: json["working_days"],
        sports: json["sports"],
        longTermBooking: json["long_term_booking"],
        numberOfGrounds: json["number_of_grounds"],
        ratings: json["ratings"],
        wishlist: json["wishlist"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "opening_hour": openingHour.split(" ").first,
        "closing_hour": closingHour.split(" ").first,
        "working_days": workingDays,
        "sports": sports,
        "long_term_booking": longTermBooking,
        "number_of_grounds": numberOfGrounds,
        "ratings": ratings,
        "wishlist": wishlist,
      };
}

class WorkingDay {
  String day;
  String status;

  WorkingDay({
    required this.day,
    required this.status,
  });

  factory WorkingDay.fromJson(Map<String, dynamic> json) => WorkingDay(
        day: json["day"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "status": status,
      };
}
