// To parse this JSON data, do
//
//     final addPlayerDetailsModel = addPlayerDetailsModelFromJson(jsonString);

import 'dart:convert';

AddPlayerDetailsModel addPlayerDetailsModelFromJson(String str) => AddPlayerDetailsModel.fromJson(json.decode(str));

String addPlayerDetailsModelToJson(AddPlayerDetailsModel data) => json.encode(data.toJson());

class AddPlayerDetailsModel {
  String name;
  String address;
  String sports;
  DateTime birthDate;
  String aboutMe;

  AddPlayerDetailsModel({
    required this.name,
    required this.address,
    required this.sports,
    required this.birthDate,
    required this.aboutMe,
  });

  factory AddPlayerDetailsModel.fromJson(Map<String, dynamic> json) => AddPlayerDetailsModel(
        name: json["name"],
        address: json["address"],
        sports: json["sports"],
        birthDate: DateTime.parse(json["birth_date"]),
        aboutMe: json["about_me"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "sports": sports,
        "birth_date": "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
        "about_me": aboutMe,
      };
}
