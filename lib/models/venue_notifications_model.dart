// To parse this JSON data, do
//
//     final venueNotificationsResponse = venueNotificationsResponseFromJson(jsonString);

import 'dart:convert';

VenueNotificationsResponse venueNotificationsResponseFromJson(String str) =>
    VenueNotificationsResponse.fromJson(json.decode(str));

String venueNotificationsResponseToJson(VenueNotificationsResponse data) => json.encode(data.toJson());

class VenueNotificationsResponse {
  int httpCode;
  String message;
  Data data;

  VenueNotificationsResponse({
    required this.httpCode,
    required this.message,
    required this.data,
  });

  VenueNotificationsResponse copyWith({
    int? httpCode,
    String? message,
    Data? data,
  }) =>
      VenueNotificationsResponse(
        httpCode: httpCode ?? this.httpCode,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory VenueNotificationsResponse.fromJson(Map<String, dynamic> json) => VenueNotificationsResponse(
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
  int currentPage;
  List<Datum> data;
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

  Data copyWith({
    int? currentPage,
    List<Datum>? data,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    List<Link>? links,
    dynamic nextPageUrl,
    String? path,
    int? perPage,
    dynamic prevPageUrl,
    int? to,
    int? total,
  }) =>
      Data(
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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

class Datum {
  int id;
  int notificationFrom;
  String notificationFromRole;
  int notificationFor;
  String notificationForRole;
  DateTime date;
  String status;
  dynamic actionBy;
  dynamic actionDate;
  DateTime createdAt;
  DateTime updatedAt;
  String title;
  String body;
  int bookingId;
  dynamic teamId;
  dynamic programId;
  dynamic sportsId;
  dynamic hourly;
  dynamic other;
  String notificationType;
  String isRead;
  String wholeTeam;
  dynamic matchId;
  String inviteFor;
  String requestType;
  dynamic reschedule;
  dynamic group;
  String splitCost;
  String isReadBooking;
  String matchCreatedBy;

  Datum({
    required this.id,
    required this.notificationFrom,
    required this.notificationFromRole,
    required this.notificationFor,
    required this.notificationForRole,
    required this.date,
    required this.status,
    required this.actionBy,
    required this.actionDate,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.body,
    required this.bookingId,
    required this.teamId,
    required this.programId,
    required this.sportsId,
    required this.hourly,
    required this.other,
    required this.notificationType,
    required this.isRead,
    required this.wholeTeam,
    required this.matchId,
    required this.inviteFor,
    required this.requestType,
    required this.reschedule,
    required this.group,
    required this.splitCost,
    required this.isReadBooking,
    required this.matchCreatedBy,
  });

  Datum copyWith({
    int? id,
    int? notificationFrom,
    String? notificationFromRole,
    int? notificationFor,
    String? notificationForRole,
    DateTime? date,
    String? status,
    dynamic actionBy,
    dynamic actionDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? title,
    String? body,
    int? bookingId,
    dynamic teamId,
    dynamic programId,
    dynamic sportsId,
    dynamic hourly,
    dynamic other,
    String? notificationType,
    String? isRead,
    String? wholeTeam,
    dynamic matchId,
    String? inviteFor,
    String? requestType,
    dynamic reschedule,
    dynamic group,
    String? splitCost,
    String? isReadBooking,
    String? matchCreatedBy,
  }) =>
      Datum(
        id: id ?? this.id,
        notificationFrom: notificationFrom ?? this.notificationFrom,
        notificationFromRole: notificationFromRole ?? this.notificationFromRole,
        notificationFor: notificationFor ?? this.notificationFor,
        notificationForRole: notificationForRole ?? this.notificationForRole,
        date: date ?? this.date,
        status: status ?? this.status,
        actionBy: actionBy ?? this.actionBy,
        actionDate: actionDate ?? this.actionDate,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        title: title ?? this.title,
        body: body ?? this.body,
        bookingId: bookingId ?? this.bookingId,
        teamId: teamId ?? this.teamId,
        programId: programId ?? this.programId,
        sportsId: sportsId ?? this.sportsId,
        hourly: hourly ?? this.hourly,
        other: other ?? this.other,
        notificationType: notificationType ?? this.notificationType,
        isRead: isRead ?? this.isRead,
        wholeTeam: wholeTeam ?? this.wholeTeam,
        matchId: matchId ?? this.matchId,
        inviteFor: inviteFor ?? this.inviteFor,
        requestType: requestType ?? this.requestType,
        reschedule: reschedule ?? this.reschedule,
        group: group ?? this.group,
        splitCost: splitCost ?? this.splitCost,
        isReadBooking: isReadBooking ?? this.isReadBooking,
        matchCreatedBy: matchCreatedBy ?? this.matchCreatedBy,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        notificationFrom: json["notification_from"],
        notificationFromRole: json["notification_from_role"],
        notificationFor: json["notification_for"],
        notificationForRole: json["notification_for_role"],
        date: DateTime.parse(json["date"]),
        status: json["status"],
        actionBy: json["action_by"],
        actionDate: json["action_date"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        title: json["title"],
        body: json["body"],
        bookingId: json["booking_id"],
        teamId: json["team_id"],
        programId: json["program_id"],
        sportsId: json["sports_id"],
        hourly: json["hourly"],
        other: json["other"],
        notificationType: json["notification_type"],
        isRead: json["is_read"],
        wholeTeam: json["whole_team"],
        matchId: json["match_id"],
        inviteFor: json["invite_for"],
        requestType: json["request_type"],
        reschedule: json["reschedule"],
        group: json["group"],
        splitCost: json["split_cost"],
        isReadBooking: json["is_read_booking"],
        matchCreatedBy: json["match_created_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "notification_from": notificationFrom,
        "notification_from_role": notificationFromRole,
        "notification_for": notificationFor,
        "notification_for_role": notificationForRole,
        "date": date.toIso8601String(),
        "status": status,
        "action_by": actionBy,
        "action_date": actionDate,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "title": title,
        "body": body,
        "booking_id": bookingId,
        "team_id": teamId,
        "program_id": programId,
        "sports_id": sportsId,
        "hourly": hourly,
        "other": other,
        "notification_type": notificationType,
        "is_read": isRead,
        "whole_team": wholeTeam,
        "match_id": matchId,
        "invite_for": inviteFor,
        "request_type": requestType,
        "reschedule": reschedule,
        "group": group,
        "split_cost": splitCost,
        "is_read_booking": isReadBooking,
        "match_created_by": matchCreatedBy,
      };
}

class Link {
  String? url;
  String label;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  Link copyWith({
    String? url,
    String? label,
    bool? active,
  }) =>
      Link(
        url: url ?? this.url,
        label: label ?? this.label,
        active: active ?? this.active,
      );

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
