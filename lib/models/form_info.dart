// import 'package:aio_sport/models/add_ground_req_model.dart';

class FormInfo {
  String groundName, groundSize, groundUnits = "1", hourlyRent;
  List<String> morningTiming, eveningTiming;
  bool isIndoor;
  int sportId;
  // List<AddOn>? addOn;

  FormInfo({
    required this.groundName,
    required this.groundSize,
    required this.groundUnits,
    required this.hourlyRent,
    required this.isIndoor,
    required this.sportId,
    required this.morningTiming,
    required this.eveningTiming,
  });

  Map<String, dynamic> toJson() => {
        "sports_id": sportId,
        "ground_type": isIndoor ? "indoor" : "outdoor",
        "name": groundName,
        "ground_size": groundSize,
        "unit": groundUnits,
        "hourly_rent": hourlyRent,
        "morning_availability": morningTiming,
        "evening_availability": eveningTiming,
      };
}
