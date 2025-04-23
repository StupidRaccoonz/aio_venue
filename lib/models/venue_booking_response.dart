// To parse this JSON data, do
//
//     final venueBookingsResponseModel = venueBookingsResponseModelFromJson(jsonString);

import 'dart:convert' as js;

VenueBookingsResponseModel venueBookingsResponseModelFromJson(String str) =>
    VenueBookingsResponseModel.fromJson(js.json.decode(str));

String venueBookingsResponseModelToJson(VenueBookingsResponseModel data) =>
    js.json.encode(data.toJson());

class VenueBookingsResponseModel {
  int httpCode;
  String message;
  Bookings? bookings;

  VenueBookingsResponseModel({
    required this.httpCode,
    required this.message,
    required this.bookings,
  });

  factory VenueBookingsResponseModel.fromJson(Map<String, dynamic> json) =>
      VenueBookingsResponseModel(
        httpCode: json["http_code"],
        message: json["message"],
        bookings: json["http_code"] == 200
            ? Bookings.fromJson(json["data"] is String
                ? js.json.decode(json["data"])
                : json["data"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "http_code": httpCode,
        "message": message,
        "data": bookings?.toJson(),
      };
}

class Bookings {
  int currentPage;
  List<BookingData> data;
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

  Bookings({
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

  factory Bookings.fromJson(Map<String, dynamic> json) => Bookings(
        currentPage: json["current_page"],
        data: List<BookingData>.from(
            json["data"].map((x) => BookingData.fromJson(x))),
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

class BookingData {
  int id;
  DateTime bookingDate;
  int longTermBooking;
  double longTermBookingPrice;
  List<DateTime> date;
  List<Slot> slots;
  int totalAmount;
  List<GroundData> groundData;
  String sportsName;
  String groundName;
  String playerName;
  String playerPicture;
  String playerPhone;
  DateTime? playerBirthDate;

  BookingData({
    required this.id,
    required this.bookingDate,
    required this.longTermBooking,
    required this.longTermBookingPrice,
    required this.date,
    required this.slots,
    required this.totalAmount,
    required this.groundData,
    required this.sportsName,
    required this.groundName,
    required this.playerName,
    required this.playerPicture,
    required this.playerPhone,
    this.playerBirthDate,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) => BookingData(
        id: json["id"],
        bookingDate: DateTime.parse(json["booking_date"]),
        longTermBooking: json["long_term_booking"] ?? 0,
        longTermBookingPrice:
            json["long_term_booking_price"]?.toDouble() ?? 0.0,
        date: json["date"] == null
            ? []
            : List<DateTime>.from(json["date"].map((x) => DateTime.parse(x))),
        slots: json["slots"] == null
            ? []
            : List<Slot>.from(json["slots"].map((x) => Slot.fromJson(x))),
        totalAmount: int.parse(json["total_amount"].toString()),
        groundData: json["ground_data"] == null
            ? []
            : List<GroundData>.from(
                json["ground_data"].map((x) => GroundData.fromJson(x))),
        sportsName: json["sports_name"],
        groundName: json["ground_name"],
        playerName: json["player_name"],
        playerPicture: json["player_picture"],
        playerPhone: json["player_phone"].toString(),
        playerBirthDate: json['player_birth_date'] == null
            ? null
            : DateTime.tryParse(json["player_birth_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "booking_date": bookingDate.toIso8601String(),
        "long_term_booking": longTermBooking,
        "long_term_booking_price": longTermBookingPrice,
        "date": List<dynamic>.from(date.map((x) =>
            "${x.year.toString().padLeft(4, '0')}-${x.month.toString().padLeft(2, '0')}-${x.day.toString().padLeft(2, '0')}")),
        "slots": List<dynamic>.from(slots.map((x) => x.toJson())),
        "total_amount": totalAmount,
        "ground_data": List<dynamic>.from(groundData.map((x) => x.toJson())),
        "sports_name": sportsName,
        "ground_name": groundName,
        "player_name": playerName,
        "player_picture": playerPicture,
        "player_phone": playerPhone,
        "player_birth_date":
            "${playerBirthDate?.year.toString().padLeft(4, '0')}-${playerBirthDate?.month.toString().padLeft(2, '0')}-${playerBirthDate?.day.toString().padLeft(2, '0')}",
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
        itemId: json["item_id"].toString(),
        itemName: json["item_name"],
        price: json["price"].toString(),
        quality: json["quality"].toString(),
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
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
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
