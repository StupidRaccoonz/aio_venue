// To parse this JSON data, do
//
//     final venueCreateActivityResponse = venueCreateActivityResponseFromJson(jsonString);

import 'dart:convert' as js;

import 'package:objectbox/objectbox.dart';

VenueActivitiesObj venueCreateActivityResponseFromJson(String str) => VenueActivitiesObj.fromJson(js.json.decode(str));

String venueCreateActivityResponseToJson(VenueActivitiesObj data) => js.json.encode(data.toJson());

@Entity()
class VenueActivitiesObj {
  @Id(assignable: true)
  int id = 4;
  int httpCode;
  String message;
  String? data;

  VenueActivitiesObj({
    required this.httpCode,
    required this.message,
    required this.data,
  });

  factory VenueActivitiesObj.fromJson(Map<String, dynamic> json) => VenueActivitiesObj(
        httpCode: json["http_code"],
        message: json["message"],
        data: json["data"] == null ? "{}" : js.json.encode(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "http_code": httpCode,
        "message": message,
        "data": data,
      };
}

class VenueAnalyticsData {
  VenueAnalyticsData({
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

  final int? createdActivity;
  final int? hostedActivity;
  final int? challanges;
  final int? totalBooking;
  final double? shortTermPercentage;
  final double? longTermPercentage;
  final List<TermBooking> longTermBooking;
  final List<TermBooking> shortTermBooking;
  final List<Gettotalgroundbooking> gettotalgroundbookings;
  final int? totalEarning;

  VenueAnalyticsData copyWith({
    int? createdActivity,
    int? hostedActivity,
    int? challanges,
    int? totalBooking,
    double? shortTermPercentage,
    double? longTermPercentage,
    List<TermBooking>? longTermBooking,
    List<TermBooking>? shortTermBooking,
    List<Gettotalgroundbooking>? gettotalgroundbookings,
    int? totalEarning,
  }) {
    return VenueAnalyticsData(
      createdActivity: createdActivity ?? this.createdActivity,
      hostedActivity: hostedActivity ?? this.hostedActivity,
      challanges: challanges ?? this.challanges,
      totalBooking: totalBooking ?? this.totalBooking,
      shortTermPercentage: shortTermPercentage ?? this.shortTermPercentage,
      longTermPercentage: longTermPercentage ?? this.longTermPercentage,
      longTermBooking: longTermBooking ?? this.longTermBooking,
      shortTermBooking: shortTermBooking ?? this.shortTermBooking,
      gettotalgroundbookings: gettotalgroundbookings ?? this.gettotalgroundbookings,
      totalEarning: totalEarning ?? this.totalEarning,
    );
  }

  factory VenueAnalyticsData.fromJson(Map<String, dynamic> json) {
    return VenueAnalyticsData(
      createdActivity: json["created_activity"],
      hostedActivity: json["hosted_activity"],
      challanges: json["challanges"],
      totalBooking: json["total_booking"],
      shortTermPercentage: json["short_term_percentage"],
      longTermPercentage: json["long_term_percentage"],
      longTermBooking: json["long_term_booking"] == null ? [] : List<TermBooking>.from(json["long_term_booking"]!.map((x) => TermBooking.fromJson(x))),
      shortTermBooking: json["short_term_booking"] == null ? [] : List<TermBooking>.from(json["short_term_booking"]!.map((x) => TermBooking.fromJson(x))),
      gettotalgroundbookings: json["gettotalgroundbookings"] == null ? [] : List<Gettotalgroundbooking>.from(json["gettotalgroundbookings"]!.map((x) => Gettotalgroundbooking.fromJson(x))),
      totalEarning: json["total_earning"],
    );
  }
}

class Gettotalgroundbooking {
  Gettotalgroundbooking({
    required this.sportsName,
    required this.grounds,
  });

  final String? sportsName;
  final List<VenueAnalyticsGround> grounds;

  Gettotalgroundbooking copyWith({
    String? sportsName,
    List<VenueAnalyticsGround>? grounds,
  }) {
    return Gettotalgroundbooking(
      sportsName: sportsName ?? this.sportsName,
      grounds: grounds ?? this.grounds,
    );
  }

  factory Gettotalgroundbooking.fromJson(Map<String, dynamic> json) {
    return Gettotalgroundbooking(
      sportsName: json["sports_name"],
      grounds: json["grounds"] == null ? [] : List<VenueAnalyticsGround>.from(json["grounds"]!.map((x) => VenueAnalyticsGround.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "sports_name": sportsName,
        "grounds": grounds.map((x) => x?.toJson()).toList(),
      };
}

class VenueAnalyticsGround {
  VenueAnalyticsGround({
    required this.groundName,
    required this.pitchBookingCount,
  });

  final String? groundName;
  final int? pitchBookingCount;

  VenueAnalyticsGround copyWith({
    String? groundName,
    int? pitchBookingCount,
  }) {
    return VenueAnalyticsGround(
      groundName: groundName ?? this.groundName,
      pitchBookingCount: pitchBookingCount ?? this.pitchBookingCount,
    );
  }

  factory VenueAnalyticsGround.fromJson(Map<String, dynamic> json) {
    return VenueAnalyticsGround(
      groundName: json["ground_name"],
      pitchBookingCount: json["pitch_booking_count"],
    );
  }

  Map<String, dynamic> toJson() => {
        "ground_name": groundName,
        "pitch_booking_count": pitchBookingCount,
      };
}

class TermBooking {
  TermBooking({
    required this.bookingDate,
    required this.bookingCount,
  });

  final DateTime? bookingDate;
  final int? bookingCount;

  TermBooking copyWith({
    DateTime? bookingDate,
    int? bookingCount,
  }) {
    return TermBooking(
      bookingDate: bookingDate ?? this.bookingDate,
      bookingCount: bookingCount ?? this.bookingCount,
    );
  }

  factory TermBooking.fromJson(Map<String, dynamic> json) {
    return TermBooking(
      bookingDate: DateTime.tryParse(json["booking_date"] ?? ""),
      bookingCount: json["booking_count"],
    );
  }
}
