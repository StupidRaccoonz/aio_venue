class VenueBookingListResponseModel {
  VenueBookingListResponseModel({
    required this.httpCode,
    required this.message,
    required this.data,
  });

  final int? httpCode;
  final String? message;
  final Data? data;

  VenueBookingListResponseModel copyWith({
    int? httpCode,
    String? message,
    Data? data,
  }) {
    return VenueBookingListResponseModel(
      httpCode: httpCode ?? this.httpCode,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  factory VenueBookingListResponseModel.fromJson(Map<String, dynamic> json) {
    return VenueBookingListResponseModel(
      httpCode: json["http_code"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "http_code": httpCode,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
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

  final int? currentPage;
  final List<BookData> data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Link> links;
  final dynamic nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  Data copyWith({
    int? currentPage,
    List<BookData>? data,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    List<Link>? links,
    dynamic? nextPageUrl,
    String? path,
    int? perPage,
    dynamic? prevPageUrl,
    int? to,
    int? total,
  }) {
    return Data(
      currentPage: currentPage ?? this.currentPage,
      data: data ?? this.data,
      firstPageUrl: firstPageUrl ?? this.firstPageUrl,
      from: from ?? this.from,
      lastPage: lastPage ?? this.lastPage,
      lastPageUrl: lastPageUrl ?? this.lastPageUrl,
      links: links ?? this.links,
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
      path: path ?? this.path,
      perPage: perPage ?? this.perPage,
      prevPageUrl: prevPageUrl ?? this.prevPageUrl,
      to: to ?? this.to,
      total: total ?? this.total,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      currentPage: json["current_page"],
      data: json["data"] == null ? [] : List<BookData>.from(json["data"]!.map((x) => BookData.fromJson(x))),
      firstPageUrl: json["first_page_url"],
      from: json["from"],
      lastPage: json["last_page"],
      lastPageUrl: json["last_page_url"],
      links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
      nextPageUrl: json["next_page_url"],
      path: json["path"],
      perPage: json["per_page"],
      prevPageUrl: json["prev_page_url"],
      to: json["to"],
      total: json["total"],
    );
  }

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links.map((x) => x?.toJson()).toList(),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class BookData {
  BookData({
    required this.id,
    required this.bookingDate,
    required this.longTermBooking,
    required this.longTermBookingPrice,
    required this.date,
    required this.slots,
    required this.totalAmount,
    required this.groundData,
    required this.sportsName,
    required this.venueName,
    required this.venuePicture,
    required this.groundName,
    required this.playerName,
    required this.playerPicture,
    required this.playerPhone,
    required this.playerBirthDate,
    required this.onPeakSlots,
    required this.offPeakSlots,
    required this.weekendSlots,
  });

  final int? id;
  final DateTime? bookingDate;
  final int? longTermBooking;
  final int? longTermBookingPrice;
  final List<DateTime> date;
  final List<Slot> slots;
  final int? totalAmount;
  final List<GroundDatum> groundData;
  final String? sportsName;
  final String? venueName;
  final String? venuePicture;
  final String? groundName;
  final String? playerName;
  final String? playerPicture;
  final String? playerPhone;
  final DateTime? playerBirthDate;
  final List<Slot> onPeakSlots;
  final List<dynamic> offPeakSlots;
  final List<Slot> weekendSlots;

  BookData copyWith({
    int? id,
    DateTime? bookingDate,
    int? longTermBooking,
    int? longTermBookingPrice,
    List<DateTime>? date,
    List<Slot>? slots,
    int? totalAmount,
    List<GroundDatum>? groundData,
    String? sportsName,
    String? venueName,
    String? venuePicture,
    String? groundName,
    String? playerName,
    String? playerPicture,
    String? playerPhone,
    DateTime? playerBirthDate,
    List<Slot>? onPeakSlots,
    List<dynamic>? offPeakSlots,
    List<Slot>? weekendSlots,
  }) {
    return BookData(
      id: id ?? this.id,
      bookingDate: bookingDate ?? this.bookingDate,
      longTermBooking: longTermBooking ?? this.longTermBooking,
      longTermBookingPrice: longTermBookingPrice ?? this.longTermBookingPrice,
      date: date ?? this.date,
      slots: slots ?? this.slots,
      totalAmount: totalAmount ?? this.totalAmount,
      groundData: groundData ?? this.groundData,
      sportsName: sportsName ?? this.sportsName,
      venueName: venueName ?? this.venueName,
      venuePicture: venuePicture ?? this.venuePicture,
      groundName: groundName ?? this.groundName,
      playerName: playerName ?? this.playerName,
      playerPicture: playerPicture ?? this.playerPicture,
      playerPhone: playerPhone ?? this.playerPhone,
      playerBirthDate: playerBirthDate ?? this.playerBirthDate,
      onPeakSlots: onPeakSlots ?? this.onPeakSlots,
      offPeakSlots: offPeakSlots ?? this.offPeakSlots,
      weekendSlots: weekendSlots ?? this.weekendSlots,
    );
  }

  factory BookData.fromJson(Map<String, dynamic> json) {
    return BookData(
      id: json["id"],
      bookingDate: DateTime.tryParse(json["booking_date"] ?? ""),
      longTermBooking: json["long_term_booking"],
      longTermBookingPrice: json["long_term_booking_price"],
      date: json["date"] == null ? [] : List<DateTime>.from(json["date"]!.map((x) => DateTime.tryParse(x ?? ""))),
      slots: json["slots"] == null ? [] : List<Slot>.from(json["slots"]!.map((x) => Slot.fromJson(x))),
      totalAmount: json["total_amount"],
      groundData: json["ground_data"] == null ? [] : List<GroundDatum>.from(json["ground_data"]!.map((x) => GroundDatum.fromJson(x))),
      sportsName: json["sports_name"],
      venueName: json["venue_name"],
      venuePicture: json["venue_picture"],
      groundName: json["ground_name"],
      playerName: json["player_name"],
      playerPicture: json["player_picture"],
      playerPhone: json["player_phone"],
      playerBirthDate: DateTime.tryParse(json["player_birth_date"] ?? ""),
      onPeakSlots: json["on_peak_slots"] == null ? [] : List<Slot>.from(json["on_peak_slots"]!.map((x) => Slot.fromJson(x))),
      offPeakSlots: json["off_peak_slots"] == null ? [] : List<dynamic>.from(json["off_peak_slots"]!.map((x) => x)),
      weekendSlots: json["weekend_slots"] == null ? [] : List<Slot>.from(json["weekend_slots"]!.map((x) => Slot.fromJson(x))),
    );
  }
}

class GroundDatum {
  GroundDatum({
    required this.quality,
    required this.itemName,
    required this.price,
    required this.itemId,
  });

  final String? quality;
  final String? itemName;
  final String? price;
  final String? itemId;

  GroundDatum copyWith({
    String? quality,
    String? itemName,
    String? price,
    String? itemId,
  }) {
    return GroundDatum(
      quality: quality ?? this.quality,
      itemName: itemName ?? this.itemName,
      price: price ?? this.price,
      itemId: itemId ?? this.itemId,
    );
  }

  factory GroundDatum.fromJson(Map<String, dynamic> json) {
    return GroundDatum(
      quality: json["quality"],
      itemName: json["item_name"],
      price: json["price"],
      itemId: json["item_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "quality": quality,
        "item_name": itemName,
        "price": price,
        "item_id": itemId,
      };
}

class Slot {
  Slot({
    required this.time,
    required this.date,
  });

  final List<String> time;
  final DateTime? date;

  Slot copyWith({
    List<String>? time,
    DateTime? date,
  }) {
    return Slot(
      time: time ?? this.time,
      date: date ?? this.date,
    );
  }

  factory Slot.fromJson(Map<String, dynamic> json) {
    return Slot(
      time: json["time"] == null ? [] : List<String>.from(json["time"]!.map((x) => x)),
      date: DateTime.tryParse(json["date"] ?? ""),
    );
  }
}

class Link {
  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  final String? url;
  final String? label;
  final bool? active;

  Link copyWith({
    String? url,
    String? label,
    bool? active,
  }) {
    return Link(
      url: url ?? this.url,
      label: label ?? this.label,
      active: active ?? this.active,
    );
  }

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      url: json["url"],
      label: json["label"],
      active: json["active"],
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
