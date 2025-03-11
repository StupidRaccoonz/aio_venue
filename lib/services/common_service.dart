import 'dart:developer';
import 'dart:io';

import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/models/submit_report_resp_model.dart';
import 'package:aio_sport/models/success_response_model.dart';
import 'package:dio/dio.dart';

import 'server_urls.dart';

class CommonService {
  Dio dio = Dio(
      BaseOptions(baseUrl: ServerUrls.basUrl, connectTimeout: const Duration(seconds: 15), receiveTimeout: const Duration(seconds: 40), sendTimeout: const Duration(seconds: 50)));

  Future<SuccessResponseModel?> uploadImages(List<File> image, List<File> videos, String token, String venueId) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data',
      "Authorization": "Bearer $token",
    };
    final options = Options(headers: headers);
    final formData = FormData.fromMap({'venue_id': venueId});
    Future.forEach(image, (element) async {
      return formData.files.add(MapEntry(
        "images[]",
        await MultipartFile.fromFile(element.path, filename: element.path.split("/").last),
      ));
    });
    Future.forEach(videos, (element) async {
      return formData.files.add(MapEntry(
        "videos[]",
        await MultipartFile.fromFile(element.path, filename: element.path.split("/").last),
      ));
    });
    Response response = await dio.post('upload_media', data: formData, options: options);
    log("Response data: ${response.data}");
    if (response.statusCode == 200 && response.data != null) {
      final responseModel = SuccessResponseModel.fromJson(response.data);
      log(responseModel.toJson().toString());
      return responseModel;
    } else {
      log("reasonPhrase upload image: ${response.statusMessage}");
      Constants.showSnackbar("Error", "${response.statusMessage}");
      return null;
    }
  }

  Future<SuccessResponseModel?> uploadVideos(List<File> videos, String token, String venueId) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data',
      "Authorization": "Bearer $token",
    };
    // var request = http.MultipartRequest('POST', Uri.parse('${ServerUrls.basUrl}upload_media'));
    // request.fields.addAll({'venue_id': venueId});
    // Future.forEach(videos, (element) async => request.files.add(await http.MultipartFile.fromPath('videos[]', element.path)));
    // request.files.add();
    // request.files.add(await http.MultipartFile.fromPath('images[]', '/Users/akhlaqshah/wallpapers/wallpaper1.jpg'));
    final options = Options(headers: headers);
    final formData = FormData.fromMap({
      'venue_id': venueId,
      'videos[]': videos.map((e) async => await MultipartFile.fromFile(e.path, filename: e.path.split("/").last)).toList(),
    });

    Response response = await dio.post('upload_media', data: formData, options: options);

    if (response.statusCode == 200 && response.data != null) {
      final responseModel = SuccessResponseModel.fromJson(response.data);
      log(responseModel.toJson().toString());
      return responseModel;
    } else {
      log("reasonPhrase upload video: ${response.statusMessage}");
      Constants.showSnackbar("Error", "${response.statusMessage}");
      return null;
    }
  }

  Future<SuccessResponseModel?> deleteMedia(List<String> id, String token) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data',
      "Authorization": "Bearer $token",
    };
    final options = Options(headers: headers);
    final formData = FormData();
    for (String imageName in id) {
      // Each image name will appear as a separate "ids[]" field
      formData.fields.add(MapEntry('ids[]', imageName));
    }
    Response response = await dio.post('venue_delete_photos', data: formData, options: options);

    if (response.statusCode == 200 && response.data != null) {
      final responseModel = SuccessResponseModel.fromJson(response.data);
      log(responseModel.toJson().toString());
      return responseModel;
    } else {
      log("reasonPhrase delete media: ${response.statusMessage}");
      Constants.showSnackbar("Error", "${response.statusMessage}");
      return null;
    }
  }

  Future<SubmitReportResponse?> submitReport({
    required int userId,
    required String userRole,
    required String catergoryId,
    required String issue,
    required String token,
  }) async {
    var headers = {'Accept': 'application/json', "Authorization": "Bearer $token"};
    final options = Options(headers: headers);
    Map<String, dynamic> body = {'user_id': userId, 'user_role': userRole, 'category_id': 17, 'issue': issue};

    try {
      Response response = await dio.post("report_problem_saved", data: body, options: options).catchError((error) {
        log('Error: $error');
        return error;
      }, test: (error) {
        log("response error: $error");
        return false;
      });
      // log("sent request REGISTER: ${response.request!.files?.fields} body: $body");

      if (response.data == null) {
        Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }

      if (response.statusCode == 200 && SuccessResponseModel.fromJson(response.data).httpCode == 200) {
        // log("${response.bodyString}");

        SubmitReportResponse model = SubmitReportResponse.fromJson(response.data);
        log("response status code success: ${response.statusCode} body: ${response.statusMessage}");
        Constants.showSnackbar("Sucesss", SuccessResponseModel.fromJson(response.data).message);

        return model;
      } else {
        log("response status code error: ${response.statusCode} body: ${response.statusMessage}");
        Constants.showSnackbar("Error", SuccessResponseModel.fromJson(response.data).message);
        // response.status.printError(info: response.statusText ?? "-");
        return null;
      }
    } catch (ex) {
      print("connection ------------------------->");
      print("${ex}");
      Constants.showSnackbar("Connection Error", "${ex}");
      return null;
    }
  }

/* Future<SuccessResponseModel?> uploadSingleImage(File image, String token) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data',
      "Authorization": "Bearer $token",
    };
    final form = FormData({
      'images[]': MultipartFile(await image.readAsBytes(), filename: image.path.split("/").last, contentType: "multipart/form-data"),
      "venue_id": 165,
    });
    Response response = await post('${ServerUrls.basUrl}upload_media', form, headers: headers);

    if (response.bodyString != null) {
      log("Upload success ${response.body}  ${response.bodyString} ${response.statusText}");
      return successResponseModelFromJson(response.bodyString!);
    }

    return null;
  } */
}
