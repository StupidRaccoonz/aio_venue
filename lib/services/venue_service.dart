import 'dart:developer';
import 'dart:io';

import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/main.dart';
import 'package:aio_sport/models/add_ground_req_model.dart';
import 'package:aio_sport/models/add_venue_details_request_model.dart';
import 'package:aio_sport/models/edit_pause_ground_response_model.dart';
import 'package:aio_sport/models/get_facilities_model.dart';
import 'package:aio_sport/models/my_venues_model.dart';
import 'package:aio_sport/models/pause_ground_request_model.dart';
import 'package:aio_sport/models/paused_ground_model.dart';
import 'package:aio_sport/models/sports_data_model.dart';
import 'package:aio_sport/models/success_response_model.dart';
import 'package:aio_sport/models/update_ground_req_model.dart';
import 'package:aio_sport/models/venue_analytics_model.dart';
import 'package:aio_sport/models/venue_booking_details_model.dart';
import 'package:aio_sport/models/venue_booking_response.dart';
import 'package:aio_sport/models/venue_create_activity_reponse.dart';
import 'package:aio_sport/models/venue_create_activity_req_model.dart';
import 'package:aio_sport/models/venue_details_model.dart';
import 'package:aio_sport/models/venue_earning_model.dart';
import 'package:aio_sport/models/venue_media_model.dart';
import 'package:aio_sport/models/venue_notifications_model.dart';
import 'package:aio_sport/models/venue_reviews_model.dart';
import 'package:aio_sport/objecbox_models/venue_details_obj.dart';
import 'package:dio/dio.dart';

import 'server_urls.dart';

class VenueService {
  final ProfileController profileController;
  final dio = Dio(BaseOptions(
      baseUrl: ServerUrls.basUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30)));

  VenueService(this.profileController);

  Future<VenueDetailsModel?> addVenueDetails(
      File image, String token, AddVenueDetailsRequestModel requestModel,
      {bool? addNewVenue}) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };
    final options = Options(headers: headers);
    Map<String, dynamic> body = requestModel.toJson();
    body.addAll({
      "profile_picture": await MultipartFile.fromFile(image.path,
          filename: image.path.split("/").last)
    });

    // form.files.add(MapEntry("profile_picture", MultipartFile(image, filename: image.path.split("/").last, contentType: "multipart/form-data")));
    try {
      final formData = FormData.fromMap(body);
      log("addVenueDetails request ${body.toString()} ");
      final response = await dio.post('${ServerUrls.basUrl}add_venue_detail',
          data: formData, options: options);

      if (response.data == null) {
        log("internet error: addVenueDetails => ${response.data}");
        // Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }

      if (SuccessResponseModel.fromJson(response.data).httpCode == 200) {
        log("Upload success ${response.data}  ${response.statusCode} ${response.statusMessage}");
        // log("Request data: ${form.fields.toString()}");
        if (addNewVenue == null) {
          log("venue details saved with ID: ${objectbox.venueBox.put(venueDetailsModelObjFromJson(response.data))}");
        }
        return VenueDetailsModel.fromJson(response.data);
      } else {
        // Constants.showSnackbar("Error", "${response.statusMessage} add_venue_detail: error");
        return null;
      }
    } catch (ex) {
      // Constants.showSnackbar("Error", "check your internet connection");
      return null;
    }
  }

  Future<SuccessResponseModel?> addGround(
      String token, AddGroundRequestModel requestModel) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };

    try {
      Map<String, dynamic> body = requestModel.toJson();
      final options = Options(headers: headers);
      // final form = FormData(body);
      // form.files.add(MapEntry("profile_picture", MultipartFile(image, filename: image.path.split("/").last, contentType: "multipart/form-data")));
      log("addGround request: $body");
      Response<Map<String, dynamic>> response =
          await dio.post('add_ground', data: body, options: options);

      if (response.data == null) {
        log("internet error: addGround => ${response.statusMessage}");
        // Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }

      if (SuccessResponseModel.fromJson(response.data!).httpCode == 200) {
        log("Add ground success ${response.data} \n-> ${response.statusMessage}");
        log("Request data: $body");
        Constants.showSnackbar(
            "Success", SuccessResponseModel.fromJson(response.data!).message);
        try {
          return SuccessResponseModel.fromJson(response.data!);
        } on Exception catch (e) {
          log("addGround exception called: $e");
        }
      } else {
        // Constants.showSnackbar("Error", response.statusMessage ?? "add_ground: network request error");
        return null;
      }

      return null;
    } catch (ex) {
      // Constants.showSnackbar("Error", "check your internet connection");
      return null;
    }
  }

//

  Future<VenueNotificationsResponse?> getVenueNotifications() async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer ${profileController.bearer}"
    };

    final options = Options(headers: headers);

    try {
      Map<String, dynamic> body = {
        "venue_id": profileController.venueId,
        "notification_type": 'booking'
      };

      log("getPausedGrounds request: $body");
      Response response = await dio.get('venue_notifications_lists',
          queryParameters: body, options: options);

      if (response.data == null) {
        log("internet error: getnoti => ${response.statusMessage}");
        // Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }

      if (VenueNotificationsResponse.fromJson(response.data!).httpCode == 200) {
        return VenueNotificationsResponse.fromJson(response.data!);
      } else {
        // Constants.showSnackbar("Error", response.statusMessage ?? "getPauedGrounds: network request error");
        return null;
      }
    } catch (ex) {
      // Constants.showSnackbar("Error", "check your internet connection");
      return null;
    }
  }

  Future<SuccessResponseModel?> addGroundToPausing(
      String token, PauseGroundRequestModel requestModel) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };

    Map<String, dynamic> body = requestModel.toJson();
    final options = Options(headers: headers);

    // final form = FormData(body);
    // form.files.add(MapEntry("profile_picture", MultipartFile(image, filename: image.path.split("/").last, contentType: "multipart/form-data")));
    try {
      log("addGroundToPausing request: $body");
      Response<Map<String, dynamic>> response =
          await dio.post('add_ground_to_pausing', data: body, options: options);

      log("internet error: addGroundToPausing => ${response.data}");

      if (response.data == null) {
        // Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }

      if (SuccessResponseModel.fromJson(response.data!).httpCode == 200) {
        log("Add ground success ${response.data} \n-> ${response.statusCode}");
        log("Request data: $body");
        Constants.showSnackbar(
            "Result", SuccessResponseModel.fromJson(response.data!).message);

        return SuccessResponseModel.fromJson(response.data!);
      } else {
        // Constants.showSnackbar("Error", response.statusMessage ?? "add_ground: network request error");
        return null;
      }

      return null;
    } catch (ex) {
      // Constants.showSnackbar("Error", "check your internet connection");
      return null;
    }
  }

  Future<EditPauseGroundResponseModel?> getPausedGroundsDetails(
      int groundId) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer ${profileController.bearer}"
    };
    final options = Options(headers: headers);

    Map<String, dynamic> body = {
      "venue_id": "${profileController.venueId}",
      "ground_id": groundId
    };

    try {
      log("getPausedGrounds request: $body");
      Response response =
          await dio.get('edit_pause_setting', data: body, options: options);

      if (response.data == null) {
        log("internet error: getPausedGrounds => ${response.statusMessage}");
        // Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }

      if (PausedGroundModel.fromJson(response.data!).httpCode == 200) {
        profileController.pausedGroudsLi.value =
            PausedGroundModel.fromJson(response.data!);
        profileController.pausedGroudsLi.refresh();
        return EditPauseGroundResponseModel.fromJson(response.data!);
      } else {
        // Constants.showSnackbar("Error", response.statusMessage ?? "getPauedGrounds: network request error");
        return null;
      }
    } catch (ex) {
      // Constants.showSnackbar("Error", "check your internet connection");
      return null;
    }
  }

  Future<PausedGroundModel?> getPausedGrounds() async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer ${profileController.bearer}"
    };
    final options = Options(headers: headers);

    Map<String, dynamic> body = {"venue_id": "${profileController.venueId}"};

    try {
      log("getPausedGrounds request: $body");
      Response response = await dio.get('paused_ground_list',
          queryParameters: body, options: options);

      if (response.data == null) {
        log("internet error: getPausedGrounds => ${response.statusMessage}");
        // Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }

      if (PausedGroundModel.fromJson(response.data!).httpCode == 200) {
        profileController.pausedGroudsLi.value =
            PausedGroundModel.fromJson(response.data!);
        profileController.pausedGroudsLi.refresh();
        // log("getPausedGrounds success ${response.body} \n-> ${response.bodyString} \n-> ${response.statusText}");
        // Constants.showSnackbar("Result", successResponseModelFromJson(response.bodyString!).message);
        return PausedGroundModel.fromJson(response.data!);
      } else {
        // Constants.showSnackbar("Error", response.statusMessage ?? "getPauedGrounds: network request error");
        return null;
      }

      return null;
    } catch (ex) {
      // Constants.showSnackbar("Error", "check your internet connection");
      return null;
    }
  }

  Future<GetFacilitiesModel?> getFacilities(String token) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };
    final options = Options(headers: headers);

    try {
      Response<Map<String, dynamic>> response =
          await dio.get('get_facilities_list', options: options);

      // Constants.showSnackbar("API call", "getFacilities  ${response.bodyString}");

      if (response.data == null) {
        log("internet error: getFacilities => ${response.statusMessage}");
        // Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }

      if (response.data != null) {
        log("get Facilities message ${response.data} \n-> ${response.statusMessage}");
        // log("Request data: $");
        // Constants.showSnackbar("Success", successResponseModelFromJson(response.bodyString!).message);
        return GetFacilitiesModel.fromJson(response.data!);
      } else {
        // Constants.showSnackbar("Error", response.statusMessage ?? "get_facilities_list: network request error");
        return null;
      }

      return null;
    } catch (ex) {
      // Constants.showSnackbar("Error", "check your internet connection");
      return null;
    }
  }

  Future<SportsDatamodel?> getSports(String token) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };
    final options = Options(headers: headers);

    try {
      Response<Map<String, dynamic>> response =
          await dio.get('get_sports', options: options);
      // log("getSports request ${response.bodyString}");
      log("getSports responseBody ${response.data}");
      if (response.data == null) {
        log("internet error: getSports => ${response.statusMessage}");
        // Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }

      if (response.data != null) {
        log("getSports message ${response.data} \n-> ${response.statusCode} \n-> ${response.statusMessage}");
        // log("Request data: $");
        // Constants.showSnackbar("Success", successResponseModelFromJson(response.bodyString!).message);
        try {
          return SportsDatamodel.fromJson(response.data!);
        } on Exception catch (e) {
          log("getSports Exception called: $e");
        }
      } else {
        // Constants.showSnackbar("Error", response.statusMessage ?? "get_sports: network request error");
        return null;
      }

      return null;
    } catch (ex) {
      // Constants.showSnackbar("Error", "check your internet connection");
      return null;
    }
  }

  Future<SuccessResponseModel?> addFacilities(
      String token, String venueId, List<String> facilities) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };
    final options = Options(headers: headers);
    facilities.removeWhere((element) => element == "0");
    // String list = facilities.replaceAll(",0", "");
    try {
      Map<String, dynamic> body = {
        "facilities": facilities,
        "venue_id": venueId
      };

      Response response =
          await dio.post('add_facilities', data: body, options: options);

      log("Add Facilities request: $body");
      if (response.statusCode == 500) {
        Constants.showSnackbar(
            "Error", "${response.statusCode}  ${response.statusMessage}");
        return null;
      }
      if (response.data == null) {
        log("internet error: addFacilities => ${response.statusMessage}");
        // Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }

      if (response.data != null) {
        log("addFacilities message ${response.data} \n-> ${response.statusMessage}");
        // log("Request data: $");
        // Constants.showSnackbar("Success", successResponseModelFromJson(response.bodyString!).message);
        return SuccessResponseModel.fromJson(response.data!);
      } else {
        // Constants.showSnackbar("Error", response.statusMessage ?? "add_facilities: network request error");
        return null;
      }

      return null;
    } catch (ex) {
      // Constants.showSnackbar("Error", "check your internet connection");
      return null;
    }
  }

  Future<VenueMediaModel?> getVenueMedia(String token, String venueId) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };
    final options = Options(headers: headers);

    try {
      Map<String, String> params = {"venue_id": venueId};

      Response<Map<String, dynamic>> response = await dio
          .get('get_venue_photos', queryParameters: params, options: options);

      log("getVenueMedia request: $params");

      if (response.data == null) {
        log("internet error: getVenueMedia => ${response.statusMessage}");
        // Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }
      if (response.statusCode == 500) {
        Constants.showSnackbar(
            "Error", "${response.statusCode}  ${response.statusMessage}");
        return null;
      }

      if (response.data != null) {
        log("getVenueMedia message ${response.data} \n-> ${response.statusCode} \n-> ${response.statusMessage}");
        if (SuccessResponseModel.fromJson(response.data!).httpCode == 200) {
          return VenueMediaModel.fromJson(response.data!);
        }
        // Constants.showSnackbar("Error", successResponseModelFromJson(response.bodyString!).message);
      } else {
        // Constants.showSnackbar("Error", response.statusMessage ?? "get_venue_photos: network request error");
        return null;
      }

      return null;
    } catch (ex) {
      // Constants.showSnackbar("Error", "check your internet connection");
      return null;
    }
  }

  Future<VenueDetailsModel?> getVenueDetails(
      String token, String venueId) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };

    final options = Options(headers: headers);
    try {
      Map<String, String> params = {"venue_id": venueId};

      Response<Map<String, dynamic>> response = await dio.get('venue_detail',
          queryParameters: params, options: options);

      log("getVenueDetails request: $params");
      if (response.data == null) {
        log("internet error: getVenueDetails => ${response.statusMessage}");
        // Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }
      if (response.statusCode == 500) {
        Constants.showSnackbar(
            "Error", "${response.statusCode}  ${response.statusMessage}");
        return null;
      }

      if (response.data != null) {
        log("getVenueDetails message ${response.data} \n-> ${response.statusCode} \n-> ${response.statusMessage}");
        if (SuccessResponseModel.fromJson(response.data!).httpCode == 200) {
          return VenueDetailsModel.fromJson(response.data!);
        }
        // Constants.showSnackbar("Error", successResponseModelFromJson(response.bodyString!).message);
      } else {
        // Constants.showSnackbar("Error", response.statusMessage ?? "venue_detail: network request error");
        return null;
      }

      return null;
    } catch (ex) {
      // Constants.showSnackbar("Error", "check your internet connection");
      return null;
    }
  }

  Future<SportsDatamodel?> getVenueSports(String token, String venueId) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };
    final options = Options(headers: headers);
    Map<String, String> params = {"venue_id": venueId};

    try {
      Response<Map<String, dynamic>> response = await dio
          .get('get_venue_sports', queryParameters: params, options: options);

      log("getVenueSports request: $params");
      if (response.data == null) {
        log("internet error: getVenueSports => ${response.statusMessage}");
        // Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }
      if (response.statusCode == 500) {
        Constants.showSnackbar(
            "Error", "${response.statusCode}  ${response.statusMessage}");
        return null;
      }

      if (response.data != null) {
        log("getVenueSports message ${response.data} \n-> ${response.statusMessage}");
        // log("Request data: $");
        // Constants.showSnackbar("Success", successResponseModelFromJson(response.bodyString!).message);
        // objectbox.venueBox.put(venueDetailsModelObjFromJson(response.bodyString!));

        return SportsDatamodel.fromJson(response.data!);
      } else {
        // Constants.showSnackbar("Error", response.statusMessage ?? "get_venue_sports: network request error");
        return null;
      }

      return null;
    } catch (ex) {
      // Constants.showSnackbar("Error", "check your internet connection");
      return null;
    }
  }

  Future<MyVenuesResponseModel?> getMyVenuesDetails(String token) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };
    final options = Options(headers: headers);
    try {
      Response<Map<String, dynamic>> response =
          await dio.get('get_my_venues', options: options);

      if (response.data == null) {
        // Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }
      if (response.statusCode == 500) {
        Constants.showSnackbar(
            "Error", "${response.statusCode}  ${response.statusMessage}");
        return null;
      }

      if (response.data != null) {
        return MyVenuesResponseModel.fromJson(response.data!);
      }
    } catch (ex) {
      // Constants.showSnackbar("Error", "check your internet connection");
      return null;
    }
  }

  Future<VenueBookingsResponseModel?> getVenuesBookings(
      String token,
      String venueId,
      String bookingType,
      String sportsId,
      String bookingCategory) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };
    final options = Options(headers: headers);

    try {
      Map<String, String> params = {
        "booking_type": bookingType,
        "sports_id": sportsId,
        "venue_id": venueId,
        "booking_category": bookingCategory
      };
      Response<Map<String, dynamic>> response = await dio
          .get('venue_booking_list', queryParameters: params, options: options);

      if (response.data == null) {
        // Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }
      if (response.statusCode == 500) {
        Constants.showSnackbar(
            "Error", "${response.statusCode}  ${response.statusMessage}");
        return null;
      }

      if (response.statusCode == 200) {
        return VenueBookingsResponseModel.fromJson(response.data!);
      }

      return null;
    } catch (ex) {
      log('Exception from getVenuesBookings ' + ex.toString());
      // Constants.showSnackbar("Error", "check your internet connection");
      return null;
    }
  }

  Future<VenueCreateActivityResponse?> getVenuesActivities(
      String token, String venueId) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };
    final options = Options(headers: headers);

    try {
      Map<String, String> params = {"venue_id": venueId};
      Response<Map<String, dynamic>> response = await dio
          .get('my_venue_activity', queryParameters: params, options: options);

      log("getVenuesActivities request: $params");
      if (response.data == null) {
        // Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }
      if (response.statusCode == 500) {
        Constants.showSnackbar(
            "Error", "${response.statusCode}  ${response.statusMessage}");
        return null;
      }

      if (SuccessResponseModel.fromJson(response.data!).httpCode == 200) {
        return VenueCreateActivityResponse.fromJson(response.data!);
      } else {
        return null;
      }
    } catch (ex) {
      // Constants.showSnackbar("Error", "check your internet connection");
      return null;
    }
  }

  Future<VenueCreateActivityResponse?> getOtherVenuesActivities(
      String token, String venueId) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };
    final options = Options(headers: headers);

    try {
      Map<String, String> params = {"venue_id": venueId};
      Response<Map<String, dynamic>> response = await dio.get(
          'other_venue_activity',
          queryParameters: params,
          options: options);
      if (response.data == null) {
        // Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }
      if (response.statusCode == 500) {
        Constants.showSnackbar(
            "Error", "${response.statusCode}  ${response.statusMessage}");
        return null;
      }

      if (SuccessResponseModel.fromJson(response.data!).httpCode == 200) {
        return VenueCreateActivityResponse.fromJson(response.data!);
      } else {
        return null;
      }
    } catch (ex) {
      // Constants.showSnackbar("Error", "check your internet connection");
      return null;
    }
  }

  Future<SuccessResponseModel?> createVenueActivity(
      String token, VenueCreateActivityRequestModel requestModel) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };
    final options = Options(headers: headers);

    try {
      Map<String, dynamic> body = requestModel.toJson();
      Response response =
          await dio.post('create_activity', data: body, options: options);

      log("createVenueActivity request: $body");
      if (response.data == null) {
        log("internet error: createVenueActivity => ${response.statusMessage}");
        // Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }
      if (response.statusCode == 500) {
        Constants.showSnackbar(
            "Error", "${response.statusCode}  ${response.statusMessage}");
        return null;
      }

      if (SuccessResponseModel.fromJson(response.data).httpCode == 200) {
        log("createVenueActivity success message ${response.data} \n-> ${response.statusMessage}");
        return SuccessResponseModel.fromJson(response.data!);
      } else {
        // Constants.showSnackbar("Error", response.statusMessage ?? "create_activity: network request error");
        return null;
      }

      return null;
    } catch (ex) {
      // Constants.showSnackbar("Error", "check your internet connection");
      return null;
    }
  }

  Future<SuccessResponseModel?> deleteVenue(
      String token, String venueId) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };

    try {
      final options = Options(headers: headers);
      Map<String, String> params = {"venue_id": venueId};

      Response response =
          await dio.post('delete_venue', data: params, options: options);

      log("deleteVenue request: $params");
      if (response.data == null) {
        log("internet error: deleteVenue => ${response.statusMessage}");
        // Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }
      if (response.statusCode == 500) {
        Constants.showSnackbar(
            "Error", "${response.statusCode}  ${response.statusMessage}");
        return null;
      }

      if (SuccessResponseModel.fromJson(response.data).httpCode == 200) {
        log("deleteVenue message ${response.data} \n->${response.statusMessage}");

        return SuccessResponseModel.fromJson(response.data!);

        // Constants.showSnackbar("Error", successResponseModelFromJson(response.bodyString!).message);
      } else {
        // Constants.showSnackbar("Error", response.statusMessage ?? "deleteVenue: network request error");
        return null;
      }
    } catch (ex) {
      // Constants.showSnackbar("Error", "check your internet connection");
      return null;
    }
  }

  Future<VenueAnalyticsModel?> getVenueAnalytics(
      String token, String venueId) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };

    try {
      final options = Options(headers: headers);
      Map<String, String> params = {"venue_id": venueId};
      print("params ======>");
      print(params);
      Response<Map<String, dynamic>> response = await dio.get('venue_analytics',
          queryParameters: params, options: options);
      // print("getVenueAnalytics response ==================================>");
      // print("${response.toString()}");

      log("getVenueAnalytics request: $params");
      if (response.data == null) {
        log("internet error: getVenueAnalytics => ${response.statusMessage}");
        // Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }
      if (response.statusCode == 500) {
        Constants.showSnackbar(
            "Error", "${response.statusCode}  ${response.statusMessage}");
        // print("statuseCode 500 ==========================>");
        // print("${response.statusCode}");
        return null;
      }

      if (SuccessResponseModel.fromJson(response.data!).httpCode == 200) {
        // log("getVenueAnalytics message ${response.data} \n->${response.statusMessage}");
        print("getVenueAnalytics httpCode 200 ====================>");
        print("${response.data.toString()}");

        return VenueAnalyticsModel.fromJson(response.data!);

        // Constants.showSnackbar("Error", successResponseModelFromJson(response.bodyString!).message);
      } else {
        // Constants.showSnackbar("Error", response.statusMessage ?? "getVenueAnalytics: network request error");
        return null;
      }

      return null;
    } catch (ex) {
      // Constants.showSnackbar("Error", "check your internet connection");
      return null;
    }
  }

  Future<VenueEarningModel?> getVenueEarnings(
      String token, String venueId) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };

    try {
      final options = Options(headers: headers);
      Map<String, String> params = {"venue_id": venueId};
      Response<Map<String, dynamic>> response = await dio.get('venue_earning',
          queryParameters: params, options: options);
      print(" VenueEarnings response ==================>");
      log("getVenueEarnings response: ${response.data}");
      print("${response.toString()}");

      log("getVenueEarnings request: $params");
      if (response.data == null) {
        log("internet error: getVenueEarnings => ${response.statusMessage}");
        // Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }

      if (response.statusCode == 500) {
        Constants.showSnackbar(
            "Error", "${response.statusCode}  ${response.statusMessage}");
        print(" statusCode 500 ============>");
        print("${response.statusCode}");
        return null;
      }

      if (SuccessResponseModel.fromJson(response.data!).httpCode == 200) {
        log("getVenueEarnings message ${response.data} \n->${response.statusMessage}");
        print("getVenueEarnings httpCode 200 ===========>");
        print("${response.data.toString()}");
        return VenueEarningModel.fromJson(response.data!);

        // Constants.showSnackbar("Error", successResponseModelFromJson(response.bodyString!).message);
      } else {
        return null;
      }
    } catch (ex, stacktrace) {
      // Constants.showSnackbar("Error", "check your internet connection");
      print(ex.toString());
      return null;
    }
  }

  Future<VenueBookingDetailsModel?> getVenueBookingDetails(
      String token, String bookingId) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };
    final options = Options(headers: headers);

    try {
      Map<String, String> params = {"booking_id": bookingId};

      Response<Map<String, dynamic>> response = await dio.get(
          'venue_booking_detail',
          queryParameters: params,
          options: options);

      // print("booking details response ==========>");
      // print(response.data.toString());

      log("getVenueBookingDetails request: $params");
      if (response.data == null) {
        log("internet error: getVenueBookingDetails => ${response.statusMessage}");
        // Constants.showSnackbar("Error", "check your internet connection");
        print("response data =========>");
        print(response.data);
        return null;
      }
      if (response.statusCode == 500) {
        Constants.showSnackbar(
            "Error", "${response.statusCode}  ${response.statusMessage}");
        print(
            "getVenueBookingDetails statusCode 500 booking details ==========>");
        print("${response.statusCode}");
        return null;
      }

      if (SuccessResponseModel.fromJson(response.data!).httpCode == 200) {
        log("getVenueBookingDetails message ${response.data} \n->${response.statusMessage}");

        // return VenueBookingDetailsModel.fromJson(response.data!);
        if (response.data != null) {
          print(
              "getVenueBookingDetails httpCode 200 booking details =======================>");
          print("${response.data.toString()}");
          print("okkkkkkkkkkkkkkkkkkk");
          return VenueBookingDetailsModel.fromJson(response.data!);
        } else {
          Constants.showSnackbar("Error", "Response data is null.");
          return null;
        }

        // Constants.showSnackbar("Error", successResponseModelFromJson(response.bodyString!).message);
      } else {
        // Constants.showSnackbar("Error", response.statusMessage ?? "getVenueBookingDetails: network request error");
        return null;
      }

      return null;
    } catch (ex, stacktrace) {
      // Constants.showSnackbar("Error", "check your internet connection");
      print("stacktrace ================>");
      print(stacktrace);
      return null;
    }
  }

  Future<VenueReviewsModel?> getVenueReviews(
      String token, String venueId) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };
    final options = Options(headers: headers);
    try {
      Map<String, String> params = {"venue_id": venueId};

      Response<Map<String, dynamic>> response = await dio
          .get('get_venue_reviews', queryParameters: params, options: options);

      log("getVenueReviews request: $params");
      if (response.data == null) {
        log("internet error: getVenueReviews => ${response.statusMessage}");
        // Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }
      if (response.statusCode == 500) {
        Constants.showSnackbar(
            "Error", "${response.statusCode}  ${response.statusMessage}");
        return null;
      }

      if (SuccessResponseModel.fromJson(response.data!).httpCode == 200) {
        log("getVenueReviews message ${response.data} \n->${response.statusMessage}");

        return VenueReviewsModel.fromJson(response.data!);

        // Constants.showSnackbar("Error", successResponseModelFromJson(response.bodyString!).message);
      } else {
        // Constants.showSnackbar("Error", response.statusMessage ?? "getVenueReviews: network request error");
        return null;
      }

      return null;
    } catch (ex) {
      // Constants.showSnackbar("Error", "check your internet connection");
      return null;
    }
  }

  Future<SuccessResponseModel?> updateGround(
      String token, UpdateGroundRequestModel request) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };
    final options = Options(headers: headers);
    // Map<String, String> params = request.toJson();

    try {
      Response<Map<String, dynamic>> response = await dio.post('update_ground',
          queryParameters: request.toJson(), options: options);

      log("updateGround request: ${request.toJson()}");
      if (response.data == null) {
        log("internet error: updateGround => ${response.statusMessage}");
        // Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }
      if (response.statusCode == 500) {
        Constants.showSnackbar(
            "Error", "${response.statusCode}  ${response.statusMessage}");
        return null;
      }

      if (SuccessResponseModel.fromJson(response.data!).httpCode == 200) {
        log("updateGround message ${response.data} \n->${response.statusMessage}");

        return SuccessResponseModel.fromJson(response.data!);

        // Constants.showSnackbar("Error", successResponseModelFromJson(response.bodyString!).message);
      } else {
        // Constants.showSnackbar("Error", response.statusMessage ?? "updateGround: network request error");
        return null;
      }

      return null;
    } catch (ex) {
      // Constants.showSnackbar("Error", "check your internet connection");
      return null;
    }
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  Future<SuccessResponseModel?> updateVenueDetails(
      String token, Map<String, dynamic> request) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };
    final options = Options(headers: headers);
    Map<String, dynamic> body = request;
    try {
      final formData = FormData.fromMap(body);
      log("update venue request ${body.toString()} ");
      final response = await dio.post('${ServerUrls.basUrl}update_venue',
          data: formData, options: options);

      if (response.data == null) {
        log("internet error: update venue => ${response.data}");
        // Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }

      if (SuccessResponseModel.fromJson(response.data).httpCode == 200) {
        log("Upload success ${response.data}  ${response.statusCode} ${response.statusMessage}");
        // log("Request data: ${form.fields.toString()}");

        Constants.showSnackbar("Success", "Details updated");
      } else {
        Constants.showSnackbar(
            "Error", "${SuccessResponseModel.fromJson(response.data).message}");
        return null;
      }
    } catch (ex) {
      // Constants.showSnackbar("Error", "check your internet connection");
      return null;
    }
  }

/*   Future<MyVenuesResponseModel?> getMyVenuesDetails(String token) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token",
    };

    Response response = await get('${ServerUrls.basUrl}get_my_venues', headers: headers);

    if (response.status.connectionError) {
      // Constants.showSnackbar("Error", "check your internet connection");
      return null;
    }
    if (response.status.isServerError) {
      Constants.showSnackbar("Error", "${response.statusCode}  ${response.statusText}");
      return null;
    }

    if (response.bodyString != null) {
      log("getMyVenuesDetails success message ${response.body} \n-> ${response.bodyString} \n-> ${response.statusText}");
      // log("Request data: $");
      // Constants.showSnackbar("Success", successResponseModelFromJson(response.bodyString!).message);
      // objectbox.venueBox.put(venueDetailsModelObjFromJson(response.bodyString!));
      return myVenuesResponseModelFromJson(response.bodyString!);
    } else {
      Constants.showSnackbar("Error", response.statusText ?? "network request error:");
    }

    return null;
  }
 */
}
