// To parse this JSON data, do
//
//     final venueAnalyticsModel = venueAnalyticsModelFromJson(jsonString);
import 'dart:convert';

VenueAnalyticsModel venueAnalyticsModelFromJson(String str) => VenueAnalyticsModel.fromJson(json.decode(str));

String venueAnalyticsModelToJson(VenueAnalyticsModel data) => json.encode(data.toJson());

class VenueAnalyticsModel {
  int httpCode;
  String message;
  Data data;

  VenueAnalyticsModel({
    required this.httpCode,
    required this.message,
    required this.data,
  });

  factory VenueAnalyticsModel.fromJson(Map<String, dynamic> json) => VenueAnalyticsModel(
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
  int getTotalBookingsToday() {
    DateTime today = DateTime.now();

    // Get today's short-term bookings
    int shortTermToday = shortTermBooking.where((b) => b.bookingDate?.year == today.year && b.bookingDate?.month == today.month && b.bookingDate?.day == today.day).fold(0, (sum, b) => sum + b.bookingCount);

    // Get today's long-term bookings
    int longTermToday = longTermBooking.where((b) => b.bookingDate?.year == today.year && b.bookingDate?.month == today.month && b.bookingDate?.day == today.day).fold(0, (sum, b) => sum + b.bookingCount);

    return shortTermToday + longTermToday;
  }

  int createdActivity;
  int hostedActivity;
  int challanges;
  int totalBooking;
  double shortTermPercentage;
  double longTermPercentage;
  List<ShortTermBooking> longTermBooking;
  List<ShortTermBooking> shortTermBooking;
  List<Gettotalgroundbooking> gettotalgroundbookings;
  int totalEarning;

  Data({
    required this.createdActivity,
    required this.hostedActivity,
    required this.challanges,
    required this.totalBooking,
    required this.shortTermPercentage,
    required this.longTermPercentage,
    required this.longTermBooking,
    required this.shortTermBooking,
    required this.gettotalgroundbookings,
    required this.totalEarning,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        createdActivity: json["created_activity"],
        hostedActivity: json["hosted_activity"],
        challanges: json["challanges"],
        totalBooking: json["total_booking"],
        shortTermPercentage: json["short_term_percentage"] + 0.0,
        longTermPercentage: json["long_term_percentage"] + 0.0,
        longTermBooking: json["long_term_booking"] == null ? [] : List<ShortTermBooking>.from(json["long_term_booking"].map((x) => ShortTermBooking.fromJson(x))),
        shortTermBooking: json["short_term_booking"] == null ? [] : List<ShortTermBooking>.from(json["short_term_booking"].map((x) => ShortTermBooking.fromJson(x))),
        gettotalgroundbookings: List<Gettotalgroundbooking>.from(json["gettotalgroundbookings"].map((x) => Gettotalgroundbooking.fromJson(x))),
        totalEarning: json["total_earning"],
      );

  Map<String, dynamic> toJson() => {
        "created_activity": createdActivity,
        "hosted_activity": hostedActivity,
        "challanges": challanges,
        "total_booking": totalBooking,
        "short_term_percentage": shortTermPercentage,
        "long_term_percentage": longTermPercentage,
        "long_term_booking": List<dynamic>.from(longTermBooking.map((x) => x)),
        "short_term_booking": List<dynamic>.from(shortTermBooking.map((x) => x.toJson())),
        "gettotalgroundbookings": List<dynamic>.from(gettotalgroundbookings.map((x) => x.toJson())),
        "total_earning": totalEarning,
      };
}

class Gettotalgroundbooking {
  String sportsName;
  List<Ground> grounds;

  Gettotalgroundbooking({
    required this.sportsName,
    required this.grounds,
  });

  factory Gettotalgroundbooking.fromJson(Map<String, dynamic> json) => Gettotalgroundbooking(
        sportsName: json["sports_name"],
        grounds: List<Ground>.from(json["grounds"].map((x) => Ground.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sports_name": sportsName,
        "grounds": List<dynamic>.from(grounds.map((x) => x.toJson())),
      };
}

class Ground {
  String groundName;
  int pitchBookingCount;

  Ground({
    required this.groundName,
    required this.pitchBookingCount,
  });

  factory Ground.fromJson(Map<String, dynamic> json) => Ground(
        groundName: json["ground_name"],
        pitchBookingCount: json["pitch_booking_count"],
      );

  Map<String, dynamic> toJson() => {
        "ground_name": groundName,
        "pitch_booking_count": pitchBookingCount,
      };
}

class ShortTermBooking {
  DateTime? bookingDate;
  int bookingCount;

  ShortTermBooking({
    required this.bookingDate,
    required this.bookingCount,
  });

  factory ShortTermBooking.fromJson(Map<String, dynamic> json) => ShortTermBooking(
        bookingDate: json['booking_date'] == null ? null : DateTime.parse(json["booking_date"]),
        bookingCount: json["booking_count"],
      );

  Map<String, dynamic> toJson() => {
        "booking_date": "${bookingDate?.year.toString().padLeft(4, '0')}-${bookingDate?.month.toString().padLeft(2, '0')}-${bookingDate?.day.toString().padLeft(2, '0')}",
        "booking_count": bookingCount,
      };
}
