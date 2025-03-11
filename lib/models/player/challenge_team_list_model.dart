// To parse this JSON data, do
//
//     final challengeTeamListModel = challengeTeamListModelFromJson(jsonString);

import 'dart:convert';

ChallengeTeamListModel challengeTeamListModelFromJson(String str) => ChallengeTeamListModel.fromJson(json.decode(str));

String challengeTeamListModelToJson(ChallengeTeamListModel data) => json.encode(data.toJson());

class ChallengeTeamListModel {
  final int httpCode;
  final String message;
  final Data? data;

  ChallengeTeamListModel({
    required this.httpCode,
    required this.message,
    required this.data,
  });

  factory ChallengeTeamListModel.fromJson(Map<String, dynamic> json) => ChallengeTeamListModel(
        httpCode: json["http_code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "http_code": httpCode,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  final Team team;
  final int teamcount;

  Data({
    required this.team,
    required this.teamcount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        team: Team.fromJson(json["team"]),
        teamcount: json["teamcount"],
      );

  Map<String, dynamic> toJson() => {
        "team": team.toJson(),
        "teamcount": teamcount,
      };
}

class Team {
  final int currentPage;
  final List<TeamData> data;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final List<Link> links;
  final String nextPageUrl;
  final String path;
  final int perPage;
  final dynamic prevPageUrl;
  final int to;
  final int total;

  Team({
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

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        currentPage: json["current_page"],
        data: json["data"] == null ? <TeamData>[] : List<TeamData>.from(json["data"].map((x) => TeamData.fromJson(x))),
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

class TeamData {
  final int id;
  final String name;
  final String? logo;
  final String sportId;
  final int wins;
  final int losses;
  int requestSent;

  TeamData({
    required this.id,
    required this.name,
    required this.logo,
    required this.sportId,
    required this.wins,
    required this.losses,
    required this.requestSent,
  });

  factory TeamData.fromJson(Map<String, dynamic> json) => TeamData(
        id: json["id"],
        name: json["name"] ?? "N/A",
        logo: json["logo"],
        sportId: json["sport_id"],
        wins: json["wins"],
        losses: json["losses"],
        requestSent: json["request_sent"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
        "sport_id": sportId,
        "wins": wins,
        "losses": losses,
        "request_sent": requestSent,
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
