class VenueEarningModel {
  int? httpCode;
  String? message;
  Data? data;

  VenueEarningModel({this.httpCode, this.message, this.data});

  VenueEarningModel.fromJson(Map<String, dynamic> json) {
    httpCode = json['http_code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['http_code'] = this.httpCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  MyEarning? myEarning;
  int? totalVenueEarning;

  Data({this.myEarning, this.totalVenueEarning});

  Data.fromJson(Map<String, dynamic> json) {
    myEarning = json['my_earning'] != null
        ? new MyEarning.fromJson(json['my_earning'])
        : null;
    totalVenueEarning =
        double.parse(json['total_venue_earning'].toString()).toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.myEarning != null) {
      data['my_earning'] = this.myEarning!.toJson();
    }
    data['total_venue_earning'] = this.totalVenueEarning;
    return data;
  }
}

class MyEarning {
  int? currentPage;
  List<Earning>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  // Null? nextPageUrl;
  String? path;
  int? perPage;
  // Null? prevPageUrl;
  int? to;
  int? total;

  MyEarning(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      // this.nextPageUrl,
      this.path,
      this.perPage,
      // this.prevPageUrl,
      this.to,
      this.total});

  MyEarning.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Earning>[];
      json['data'].forEach((v) {
        data!.add(new Earning.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    // nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    // prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    // data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    // data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Earning {
  int? id;
  int? sourceId;
  String? sourceRole;
  String? bookingDate;
  String? bookingType;
  int? sportsId;
  int? groundId;
  String? bookingStatus;
  int? totalAmount;
  String? paymentId;
  String? paymentDate;
  String? bookingId;
  String? isRescheduled;

  // Null? coachId;
  // Null? packageType;
  // Null? coachpackageId;
  // Null? haveVenue;
  // Null? longTermBooking;
  String? createdAt;
  // Null? longTermBookingPrice;
  Player? player;
  // Null? coachpackage;
  List<Slots>? slots;

  Earning(
      {this.id,
      this.sourceId,
      this.sourceRole,
      this.bookingDate,
      this.bookingType,
      this.sportsId,
      this.groundId,
      this.bookingStatus,
      this.totalAmount,
      this.paymentId,
      this.paymentDate,
      this.bookingId,
      this.isRescheduled,
      // this.coachId,
      // this.packageType,
      // this.coachpackageId,
      // this.haveVenue,
      // this.longTermBooking,
      this.createdAt,
      // this.longTermBookingPrice,
      this.player,
      // this.coachpackage,
      this.slots});

  Earning.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sourceId = json['source_id'];
    sourceRole = json['source_role'];
    bookingDate = json['booking_date'];
    bookingType = json['booking_type'];
    sportsId = json['sports_id'];
    groundId = json['ground_id'];
    bookingStatus = json['booking_status'];
    totalAmount = json['total_amount'];
    paymentId = json['payment_id'];
    paymentDate = json['payment_date'];
    bookingId = json['booking_id'];
    isRescheduled = json['is_rescheduled'];
    // coachId = json['coach_id'];
    // packageType = json['package_type'];
    // coachpackageId = json['coachpackage_id'];
    // haveVenue = json['have_venue'];
    // longTermBooking = json['long_term_booking'];
    createdAt = json['created_at'];
    // longTermBookingPrice = json['long_term_booking_price'];
    player =
        json['player'] != null ? new Player.fromJson(json['player']) : null;
    // coachpackage = json['coachpackage'];
    if (json['slots'] != null) {
      slots = <Slots>[];
      json['slots'].forEach((v) {
        slots!.add(new Slots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['source_id'] = this.sourceId;
    data['source_role'] = this.sourceRole;
    data['booking_date'] = this.bookingDate;
    data['booking_type'] = this.bookingType;
    data['sports_id'] = this.sportsId;
    data['ground_id'] = this.groundId;
    data['booking_status'] = this.bookingStatus;
    data['total_amount'] = this.totalAmount;
    data['payment_id'] = this.paymentId;
    data['payment_date'] = this.paymentDate;
    data['booking_id'] = this.bookingId;
    data['is_rescheduled'] = this.isRescheduled;
    // data['coach_id'] = this.coachId;
    // data['package_type'] = this.packageType;
    // data['coachpackage_id'] = this.coachpackageId;
    // data['have_venue'] = this.haveVenue;
    // data['long_term_booking'] = this.longTermBooking;
    data['created_at'] = this.createdAt;
    // data['long_term_booking_price'] = this.longTermBookingPrice;
    if (this.player != null) {
      data['player'] = this.player!.toJson();
    }
    // data['coachpackage'] = this.coachpackage;
    if (this.slots != null) {
      data['slots'] = this.slots!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Player {
  int? id;
  String? name;

  Player({this.id, this.name});

  Player.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Slots {
  int? id;
  int? bookingId;
  String? date;
  String? time;
  int? venueId;
  int? groundId;
  int? playerId;
  int? sportsId;
  String? createdAt;
  String? updatedAt;
  String? bookingFor;

  Slots(
      {this.id,
      this.bookingId,
      this.date,
      this.time,
      this.venueId,
      this.groundId,
      this.playerId,
      this.sportsId,
      this.createdAt,
      this.updatedAt,
      this.bookingFor});

  Slots.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    date = json['date'];
    time = json['time'];
    venueId = json['venue_id'];
    groundId = json['ground_id'];
    playerId = json['player_id'];
    sportsId = json['sports_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bookingFor = json['booking_for'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['date'] = this.date;
    data['time'] = this.time;
    data['venue_id'] = this.venueId;
    data['ground_id'] = this.groundId;
    data['player_id'] = this.playerId;
    data['sports_id'] = this.sportsId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['booking_for'] = this.bookingFor;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
