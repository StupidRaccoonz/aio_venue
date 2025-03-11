import 'dart:convert' as js;
import 'package:objectbox/objectbox.dart';

LoginResponseModelObj loginResponseModelObjFromJson(String str) => LoginResponseModelObj.fromJson(js.json.decode(str));

String loginResponseModelObjToJson(LoginResponseModelObj data) => js.json.encode(data.toJson());

@Entity()
class LoginResponseModelObj {
  @Id(assignable: true)
  int id = 1;
  int httpCode;
  String message;
  String? data;

  LoginResponseModelObj({
    required this.httpCode,
    required this.message,
    required this.data,
  });

  factory LoginResponseModelObj.fromJson(Map<String, dynamic> json) => LoginResponseModelObj(
        httpCode: json["http_code"],
        message: json["message"],
        data: json["http_code"] == 200 ? js.json.encode(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "http_code": httpCode,
        "message": message,
        "data": data,
      };
}
