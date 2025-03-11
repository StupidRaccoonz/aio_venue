import 'dart:developer';
import 'dart:io';
import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/main.dart';
import 'package:aio_sport/models/player/add_player_details_model.dart';
import 'package:aio_sport/models/player/challenge_team_list_model.dart';
import 'package:aio_sport/models/player/coaches_list_model.dart';
import 'package:aio_sport/models/player/player_create_match_request_model.dart';
import 'package:aio_sport/models/player/player_details_model.dart';
import 'package:aio_sport/models/player/player_my_matches_response_model.dart';
import 'package:aio_sport/models/player/player_nearby_matches_response.dart';
import 'package:aio_sport/models/player/player_team_response_model.dart';
import 'package:aio_sport/models/player/sports_venue_list_model.dart';
import 'package:aio_sport/models/success_response_model.dart';
import 'package:aio_sport/objecbox_models/player_details_obj.dart';
import 'package:dio/dio.dart';

import 'server_urls.dart';

class PlayerService {
  final ProfileController profileController;
  final Dio dio = Dio(BaseOptions(
      baseUrl: ServerUrls.basUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30)));

  PlayerService(this.profileController);

  Future<PlayerDetailsModel?> addPlayerDetails({required AddPlayerDetailsModel requestmodel, required File image, required String token}) async {
    Map<String, String> headers = {'Accept': 'application/json', "Authorization": "Bearer $token"};
    final options = Options(headers: headers);
    Map<String, dynamic> body = requestmodel.toJson();
    body.addAll({"profile_picture": await MultipartFile.fromFile(image.path, filename: image.path.split("/").last)});

    try {
      final formData = FormData.fromMap(body);
      log("addVenueDetails request ${body.toString()} ");
      final response = await dio.post("add_player_detail", data: formData, options: options);

      if (response.data == null) {
        log("internet error: addVenueDetails => ${response.data}");
        Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }

      if (SuccessResponseModel.fromJson(response.data!).httpCode == 200) {
        log("Upload success ${response.data}  ${response.statusCode} ${response.statusMessage}");
        // log("Request data: ${form.fields.toString()}");
        log("player details saved with ID: ${objectbox.playerBox.put(PlayerDetailsModelObj.fromJson(response.data!.toJson()))}");
        return PlayerDetailsModel.fromJson(response.data);
      } else {
        Constants.showSnackbar("Error", "add_venue_detail: ${response.statusMessage}");
        return null;
      }
    } on DioException catch (e) {
      log("addPlayerDetails Exception: ${e.message} and ${e.error}");
      Constants.showSnackbar("Error", "${e.message}");
      return null;
    }
  }

  Future<PlayerDetailsModel?> getPlayerDetails(String token, String playerId) async {
    Map<String, String> headers = {'Accept': 'application/json', "Authorization": "Bearer $token"};

    final options = Options(headers: headers);
    try {
      Map<String, String> params = {"player_id": playerId};

      final response = await dio.get('player_detail', queryParameters: params, options: options);

      log("getPlayerDetails request: $params");
      if (response.data == null) {
        log("internet error: getPlayerDetails => ${response.statusMessage}");
        Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }
      if (response.statusCode == 500) {
        Constants.showSnackbar("Error", "${response.statusCode}  ${response.statusMessage}");
        return null;
      }

      if (response.data != null) {
        log("getPlayerDetails message ${response.data} \n-> ${response.statusCode} \n-> ${response.statusMessage}");
        if (SuccessResponseModel.fromJson(response.data!).httpCode == 200) {
          return PlayerDetailsModel.fromJson(response.data);
        }
        // Constants.showSnackbar("Error", successResponseModelFromJson(response.bodyString!).message);
      } else {
        Constants.showSnackbar("Error", response.statusMessage ?? "getPlayerDetails: network request error");
      }

      return null;
    } on DioException catch (ex) {
      Constants.showSnackbar("Error", "check your internet connection ${ex.message}");
      return null;
    }
  }

  Future<PlayerMyMatchesResponseModel?> getPlayerMatchesList(String token, String playerId) async {
    Map<String, String> headers = {'Accept': 'application/json', "Authorization": "Bearer $token"};

    final options = Options(headers: headers);
    try {
      Map<String, String> params = {"player_id": playerId};

      final response = await dio.get('match_list', queryParameters: params, options: options);

      log("getPlayerMatchesList request: $params");
      if (response.data == null) {
        log("internet error: getPlayerMatchesList => ${response.statusMessage}");
        Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }
      if (response.statusCode == 500) {
        Constants.showSnackbar("Error", "${response.statusCode}  ${response.statusMessage}");
        return null;
      }

      if (response.data != null) {
        log("getPlayerMatchesList message ${response.data} \n-> ${response.statusCode} \n-> ${response.statusMessage}");
        if (SuccessResponseModel.fromJson(response.data!).httpCode == 200) {
          return PlayerMyMatchesResponseModel.fromJson(response.data);
        }
        // Constants.showSnackbar("Error", successResponseModelFromJson(response.bodyString!).message);
      } else {
        Constants.showSnackbar("Error", response.statusMessage ?? "getPlayerMatchesList: network request error");
      }

      return null;
    } on DioException catch (ex) {
      Constants.showSnackbar("Error", "check your internet connection ${ex.message}");
      return null;
    }
  }

  Future<PlayerTeamResponseModel?> getPlayerTeam(String token, String playerId) async {
    Map<String, String> headers = {'Accept': 'application/json', "Authorization": "Bearer $token"};

    final options = Options(headers: headers);
    try {
      Map<String, String> params = {"player_id": playerId};

      final response = await dio.get('my_teams', queryParameters: params, options: options);

      log("getPlayerTeam request: $params");
      if (response.data == null) {
        log("internet error: getPlayerTeam => ${response.statusMessage}");
        Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }
      if (response.statusCode == 500) {
        Constants.showSnackbar("Error", "${response.statusCode}  ${response.statusMessage}");
        return null;
      }

      if (response.data != null) {
        log("getPlayerTeam message ${response.data} \n-> ${response.statusCode} \n-> ${response.statusMessage}");
        if (SuccessResponseModel.fromJson(response.data!).httpCode == 200) {
          return PlayerTeamResponseModel.fromJson(response.data);
        }
        // Constants.showSnackbar("Error", successResponseModelFromJson(response.bodyString!).message);
      } else {
        Constants.showSnackbar("Error", response.statusMessage ?? "getPlayerTeam: network request error");
      }

      return null;
    } on DioException catch (ex) {
      Constants.showSnackbar("Error", "check your internet connection ${ex.message}");
      return null;
    }
  }

  Future<ChallengeTeamListModel?> getChallengeTeamList(
      {required String token, required String playerId, required String sportId, required String matchId}) async {
    Map<String, String> headers = {'Accept': 'application/json', "Authorization": "Bearer $token"};

    final options = Options(headers: headers);
    try {
      Map<String, String> params = {
        "player_id": playerId,
        "sports_id": sportId,
        "match_id": matchId,
      };

      final response = await dio.get('challange_team_list', queryParameters: params, options: options);

      log("getChallengeTeamList request: $params");
      if (response.data == null) {
        log("internet error: getChallengeTeamList => ${response.statusMessage}");
        Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }
      if (response.statusCode == 500) {
        Constants.showSnackbar("Error", "${response.statusCode}  ${response.statusMessage}");
        return null;
      }

      if (response.data != null) {
        log("getChallengeTeamList message ${response.data} \n-> ${response.statusCode} \n-> ${response.statusMessage}");
        if (SuccessResponseModel.fromJson(response.data!).httpCode == 200) {
          return ChallengeTeamListModel.fromJson(response.data);
        }
        // Constants.showSnackbar("Error", successResponseModelFromJson(response.bodyString!).message);
      } else {
        Constants.showSnackbar("Error", response.statusMessage ?? "getChallengeTeamList: network request error");
      }

      return null;
    } on DioException catch (ex) {
      Constants.showSnackbar("Error", "check your internet connection ${ex.message}");
      return null;
    }
  }

  Future<SuccessResponseModel?> inviteTeamForMatch(
      {required String token, required String playerId, required String sportId, required String matchId, required String teamId}) async {
    Map<String, String> headers = {'Accept': 'application/json', "Authorization": "Bearer $token"};

    final options = Options(headers: headers);
    try {
      Map<String, String> params = {
        "player_id": playerId,
        "sports_id": sportId,
        "match_id": matchId,
        "team_id": teamId,
        "whole_team": '1',
        "request_type": 'invite',
      };

      final response = await dio.post('invite_team_for_match', queryParameters: params, options: options);

      log("inviteTeamForMatch request: $params");
      if (response.data == null) {
        log("internet error: inviteTeamForMatch => ${response.statusMessage}");
        Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }
      if (response.statusCode == 500) {
        Constants.showSnackbar("Error", "${response.statusCode}  ${response.statusMessage}");
        return null;
      }

      if (response.data != null) {
        log("inviteTeamForMatch message ${response.data} \n-> ${response.statusCode} \n-> ${response.statusMessage}");
        if (SuccessResponseModel.fromJson(response.data!).httpCode == 200) {
          return SuccessResponseModel.fromJson(response.data);
        }
        // Constants.showSnackbar("Error", successResponseModelFromJson(response.bodyString!).message);
      } else {
        Constants.showSnackbar("Error", response.statusMessage ?? "inviteTeamForMatch: network request error");
      }

      return null;
    } on DioException catch (ex) {
      Constants.showSnackbar("Error", "check your internet connection ${ex.message}");
      return null;
    }
  }

  Future<PlayerNearbyMatchesResponseModel?> getPlayerNearbyMatchesList(String token, String playerId) async {
    Map<String, String> headers = {'Accept': 'application/json', "Authorization": "Bearer $token"};

    final options = Options(headers: headers);
    try {
      Map<String, String> params = {
        "player_id": playerId,
        "longitude": '1',
        "latitude": '1',
      };

      final response = await dio.get('player_home_nearby_matches', queryParameters: params, options: options);

      log("getPlayerNearbyMatchesList request: $params");
      if (response.data == null) {
        log("internet error: getPlayerNearbyMatchesList => ${response.statusMessage}");
        Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }
      if (response.statusCode == 500) {
        Constants.showSnackbar("Error", "${response.statusCode}  ${response.statusMessage}");
        return null;
      }

      if (response.data != null) {
        log("getPlayerNearbyMatchesList message ${response.data} \n-> ${response.statusCode} \n-> ${response.statusMessage}");
        if (SuccessResponseModel.fromJson(response.data!).httpCode == 200) {
          return PlayerNearbyMatchesResponseModel.fromJson(response.data);
        }
        // Constants.showSnackbar("Error", successResponseModelFromJson(response.bodyString!).message);
      } else {
        Constants.showSnackbar("Error", response.statusMessage ?? "getPlayerNearbyMatchesList: network request error");
      }

      return null;
    } on DioException catch (ex) {
      Constants.showSnackbar("Error", "check your internet connection ${ex.message}");
      return null;
    }
  }

  Future<CoachesListModel?> getCoachesList(String token, String playerId) async {
    Map<String, String> headers = {'Accept': 'application/json', "Authorization": "Bearer $token"};

    final options = Options(headers: headers);
    try {
      Map<String, String> params = {"player_id": playerId};

      final response = await dio.get('get_coach_listing', queryParameters: params, options: options);

      log("getCoachesList request: $params");
      if (response.data == null) {
        log("internet error: getCoachesList => ${response.statusMessage}");
        Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }
      if (response.statusCode == 500) {
        Constants.showSnackbar("Error", "${response.statusCode}  ${response.statusMessage}");
        return null;
      }

      if (response.data != null) {
        log("getSportsVenueInfoList message ${response.data} \n-> ${response.statusCode} \n-> ${response.statusMessage}");
        if (SuccessResponseModel.fromJson(response.data!).httpCode == 200) {
          return CoachesListModel.fromJson(response.data);
        }
        // Constants.showSnackbar("Error", successResponseModelFromJson(response.bodyString!).message);
      } else {
        Constants.showSnackbar("Error", response.statusMessage ?? "getCoachesList: network request error");
      }

      return null;
    } on DioException catch (ex) {
      Constants.showSnackbar("Error", "check your internet connection ${ex.message}");
      return null;
    }
  }

  Future<SportsVenueListModel?> getSportsVenueInfoList(String token, String playerId, String sportId) async {
    Map<String, String> headers = {'Accept': 'application/json', "Authorization": "Bearer $token"};

    final options = Options(headers: headers);
    try {
      Map<String, String> params = {
        "player_id": playerId,
        "sport_id": sportId,
        "page": '1',
      };

      final response = await dio.get('player_venue_list', queryParameters: params, options: options);

      log("getSportsVenueInfoList request: $params");
      if (response.data == null) {
        log("internet error: getSportsVenueInfoList => ${response.statusMessage}");
        Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }
      if (response.statusCode == 500) {
        Constants.showSnackbar("Error", "${response.statusCode}  ${response.statusMessage}");
        return null;
      }

      if (response.data != null) {
        log("getSportsVenueInfoList message ${response.data} \n-> ${response.statusCode} \n-> ${response.statusMessage}");
        if (SuccessResponseModel.fromJson(response.data!).httpCode == 200) {
          return SportsVenueListModel.fromJson(response.data);
        }
        // Constants.showSnackbar("Error", successResponseModelFromJson(response.bodyString!).message);
      } else {
        Constants.showSnackbar("Error", response.statusMessage ?? "getSportsVenueInfoList: network request error");
      }

      return null;
    } on DioException catch (ex) {
      Constants.showSnackbar("Error", "check your internet connection ${ex.message}");
      return null;
    }
  }

  Future<SuccessResponseModel?> createMatch(String bearer, PlayerCreateMatcheRequestModel requestModel) async {
    Map<String, String> headers = {'Accept': 'application/json', "Authorization": "Bearer $bearer"};

    final options = Options(headers: headers);
    try {
      final response = await dio.post('create_match', data: requestModel.toJson(), options: options);

      log("create_match request: ${requestModel.toJson()}");
      if (response.data == null) {
        log("internet error: create_match => ${response.statusMessage}");
        Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }
      if (response.statusCode == 500) {
        Constants.showSnackbar("Error", "${response.statusCode}  ${response.statusMessage}");
        return null;
      }

      if (response.data != null) {
        log("create_match message ${response.data} \n-> ${response.statusCode} \n-> ${response.statusMessage}");
        if (SuccessResponseModel.fromJson(response.data!).httpCode == 200) {
          return SuccessResponseModel.fromJson(response.data);
        }
        // Constants.showSnackbar("Error", successResponseModelFromJson(response.bodyString!).message);
      } else {
        Constants.showSnackbar("Error", response.statusMessage ?? "create_match: network request error");
      }

      return null;
    } on DioException catch (ex) {
      Constants.showSnackbar("Error", "check your internet connection ${ex.message}");
      return null;
    }
  }
}
