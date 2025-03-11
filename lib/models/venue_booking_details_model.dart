// To parse this JSON data, do
//
//     final venueBookingDetailsModel = venueBookingDetailsModelFromJson(jsonString);
import 'dart:convert';

VenueBookingDetailsModel venueBookingDetailsModelFromJson(String str) => VenueBookingDetailsModel.fromJson(json.decode(str));

String venueBookingDetailsModelToJson(VenueBookingDetailsModel data) => json.encode(data.toJson());

class VenueBookingDetailsModel {
  int httpCode;
  String message;
  Data data;

  VenueBookingDetailsModel({
    required this.httpCode,
    required this.message,
    required this.data,
  });

  factory VenueBookingDetailsModel.fromJson(Map<String, dynamic> json) => VenueBookingDetailsModel(
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
  int id;
  int sourceId;
  String sourceRole;
  int venueId;
  DateTime bookingDate;
  List<DateTime> date;
  String bookingType;
  List<Slot> slots;
  dynamic timingType;
  int sportsId;
  int groundId;
  List<GroundData> groundData;
  int bookingConfirmedBy;
  DateTime bookingConfirmedDate;
  String bookingStatus;
  int umpires;
  int commentators;
  String? tax;
  String? otherCharges;
  String? couponDiscount;
  String? couponCode;
  String? taxPercentage;
  String status;
  int totalAmount;
  DateTime? deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String paymentId;
  DateTime paymentDate;
  String? bookingId;
  // String isRescheduled;
  // DateTime? rescheduleDate;
  dynamic refundPayment;
  dynamic refundDate;
  dynamic matchId;
  int longTermBooking;
  double longTermBookingPrice;
  int dayBeforeCalcelation;
  String sportsName;
  String venueName;
  String venueProfilePicture;
  String venueAddress;
  String venueLatitude;
  String venueLongitude;
  int venueLongTermBooking;
  String groundName;
  List<String> groundMorningAvailability;
  List<String> groundEveningAvailability;
  String groundHourlyRent;
  String groundPrice;
  String playerName;
  String playerPicture;
  String playerPhone;
  DateTime? playerBirthDate;
  String playerAddress;

  Data({
    required this.id,
    required this.sourceId,
    required this.sourceRole,
    required this.venueId,
    required this.bookingDate,
    required this.date,
    required this.bookingType,
    required this.slots,
    required this.timingType,
    required this.sportsId,
    required this.groundId,
    required this.groundData,
    required this.bookingConfirmedBy,
    required this.bookingConfirmedDate,
    required this.bookingStatus,
    required this.umpires,
    required this.commentators,
    required this.tax,
    required this.otherCharges,
    required this.couponDiscount,
    required this.couponCode,
    required this.taxPercentage,
    required this.status,
    required this.totalAmount,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.paymentId,
    required this.paymentDate,
    required this.bookingId,
    // required this.isRescheduled,
    // required this.rescheduleDate,
    required this.refundPayment,
    required this.refundDate,
    required this.matchId,
    required this.longTermBooking,
    required this.longTermBookingPrice,
    required this.dayBeforeCalcelation,
    required this.sportsName,
    required this.venueName,
    required this.venueProfilePicture,
    required this.venueAddress,
    required this.venueLatitude,
    required this.venueLongitude,
    required this.venueLongTermBooking,
    required this.groundName,
    required this.groundMorningAvailability,
    required this.groundEveningAvailability,
    required this.groundHourlyRent,
    required this.groundPrice,
    required this.playerName,
    required this.playerPicture,
    required this.playerPhone,
    required this.playerBirthDate,
    required this.playerAddress,
  });

  factory Data.fromJson(Map<String, dynamic> json)  => Data(
        id: json["id"],
        sourceId: json["source_id"],
        sourceRole: json["source_role"],
        venueId: json["venue_id"],
        bookingDate: DateTime.parse(json["booking_date"]),
        date: List<DateTime>.from(json["date"].map((x) => DateTime.parse(x))),
        bookingType: json["booking_type"],
        slots: List<Slot>.from(json["slots"].map((x) => Slot.fromJson(x))),
        timingType: json["timing_type"],
        sportsId: json["sports_id"],
        groundId: json["ground_id"],
        groundData: List<GroundData>.from(json["ground_data"].map((x) => GroundData.fromJson(x))),
        bookingConfirmedBy: json["booking_confirmed_by"],
        bookingConfirmedDate: DateTime.parse(json["booking_confirmed_date"]),
        bookingStatus: json["booking_status"],
        umpires: json["umpires"],
        commentators: json["commentators"],
        tax: json["tax"],
        otherCharges: json["other_charges"],
        couponDiscount: json["coupon_discount"],
        couponCode: json["coupon_code"],
        taxPercentage: json["tax_percentage"],
        status: json["status"],
        totalAmount: json["total_amount"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        paymentId: json["payment_id"],
        paymentDate: DateTime.parse(json["payment_date"]),
        bookingId: json["booking_id"],
        // isRescheduled: json["is_rescheduled"],
        // rescheduleDate: json["reschedule_date"] ?? DateTime.now(),
        refundPayment: json["refund_payment"],
        refundDate: json["refund_date"],
        matchId: json["match_id"],
        longTermBooking: json["long_term_booking"] != null ? (json["long_term_booking"] is String ? 0 : json["long_term_booking"]) : 0,
        longTermBookingPrice:
            json["long_term_booking_price"] != null ? (json["long_term_booking_price"] is String ? 0.0 : json["long_term_booking_price"] + 0.0) : 0.0,
        dayBeforeCalcelation: json["day_before_calcelation"],
        sportsName: json["sports_name"],
        venueName: json["venue_name"],
        venueProfilePicture: json["venue_profile_picture"] ?? '',
        venueAddress: json["venue_address"],
        venueLatitude: json["venue_latitude"],
        venueLongitude: json["venue_longitude"],
        venueLongTermBooking: json["venue_long_term_booking"],
        groundName: json["ground_name"],
        groundMorningAvailability: List<String>.from(json["ground_morning_availability"].map((x) => x)),
        groundEveningAvailability: List<String>.from(json["ground_evening_availability"].map((x) => x)),
        groundHourlyRent: json["ground_hourly_rent"],
        groundPrice: json["ground_price"],
        playerName: json["player_name"],
        playerPicture: json["player_picture"],
        playerPhone: json["player_phone"],
        playerBirthDate: DateTime.parse(json["player_birth_date"]),
        playerAddress: json["player_address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "source_id": sourceId,
        "source_role": sourceRole,
        "venue_id": venueId,
        "booking_date": bookingDate.toIso8601String(),
        "date": List<dynamic>.from(
            date.map((x) => "${x.year.toString().padLeft(4, '0')}-${x.month.toString().padLeft(2, '0')}-${x.day.toString().padLeft(2, '0')}")),
        "booking_type": bookingType,
        "slots": List<dynamic>.from(slots.map((x) => x.toJson())),
        "timing_type": timingType,
        "sports_id": sportsId,
        "ground_id": groundId,
        "ground_data": List<dynamic>.from(groundData.map((x) => x.toJson())),
        "booking_confirmed_by": bookingConfirmedBy,
        "booking_confirmed_date": bookingConfirmedDate.toIso8601String(),
        "booking_status": bookingStatus,
        "umpires": umpires,
        "commentators": commentators,
        "tax": tax,
        "other_charges": otherCharges,
        "coupon_discount": couponDiscount,
        "coupon_code": couponCode,
        "tax_percentage": taxPercentage,
        "status": status,
        "total_amount": totalAmount,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "payment_id": paymentId,
        "payment_date": paymentDate.toIso8601String(),
        "booking_id": bookingId,
        // "is_rescheduled": isRescheduled,
        // "reschedule_date": rescheduleDate,
        "refund_payment": refundPayment,
        "refund_date": refundDate,
        "match_id": matchId,
        "long_term_booking": longTermBooking,
        "long_term_booking_price": longTermBookingPrice,
        "day_before_calcelation": dayBeforeCalcelation,
        "sports_name": sportsName,
        "venue_name": venueName,
        "venue_profile_picture": venueProfilePicture,
        "venue_address": venueAddress,
        "venue_latitude": venueLatitude,
        "venue_longitude": venueLongitude,
        "venue_long_term_booking": venueLongTermBooking,
        "ground_name": groundName,
        "ground_morning_availability": List<dynamic>.from(groundMorningAvailability.map((x) => x)),
        "ground_evening_availability": List<dynamic>.from(groundEveningAvailability.map((x) => x)),
        "ground_hourly_rent": groundHourlyRent,
        "ground_price": groundPrice,
        "player_name": playerName,
        "player_picture": playerPicture,
        "player_phone": playerPhone,
        "player_birth_date":
            "${playerBirthDate?.year.toString().padLeft(4, '0')}-${playerBirthDate?.month.toString().padLeft(2, '0')}-${playerBirthDate?.day.toString().padLeft(2, '0')}",
        "player_address": playerAddress,
      };
}

class GroundData {
  String itemId;
  String itemName;
  String price;
  String quality;

  GroundData({
    required this.itemId,
    required this.itemName,
    required this.price,
    required this.quality,
  });

  factory GroundData.fromJson(Map<String, dynamic> json) => GroundData(
        itemId: json["item_id"],
        itemName: json["item_name"],
        price: json["price"],
        quality: json["quality"],
      );

  Map<String, dynamic> toJson() => {
        "item_id": itemId,
        "item_name": itemName,
        "price": price,
        "quality": quality,
      };
}

class Slot {
  List<String> time;
  DateTime date;

  Slot({
    required this.time,
    required this.date,
  });

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
        time: List<String>.from(json["time"].map((x) => x)),
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "time": List<dynamic>.from(time.map((x) => x)),
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      };
}
