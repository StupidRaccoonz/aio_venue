import 'dart:developer';
import 'dart:io';

import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/controllers/auth_controller.dart';
import 'package:aio_sport/controllers/player_manager_controller.dart';
import 'package:aio_sport/controllers/veneue_manager_controller.dart';
import 'package:aio_sport/main.dart';
import 'package:aio_sport/models/form_info.dart';
import 'package:aio_sport/models/get_facilities_model.dart';
import 'package:aio_sport/models/login_response_model.dart';
import 'package:aio_sport/models/my_venues_model.dart' as my_venue;
import 'package:aio_sport/models/paused_ground_model.dart';
import 'package:aio_sport/models/player/player_details_model.dart';
import 'package:aio_sport/models/player/player_my_matches_response_model.dart'
    as mymatch;
import 'package:aio_sport/models/player/player_nearby_matches_response.dart'
    as nearby;
import 'package:aio_sport/models/player/player_team_response_model.dart'
    as myteams;
import 'package:aio_sport/models/player/sports_venue_list_model.dart'
    as sportsvenue;
import 'package:aio_sport/models/sports_data_model.dart' as sports;
import 'package:aio_sport/models/success_response_model.dart';
import 'package:aio_sport/models/teams_list_data_model.dart';
import 'package:aio_sport/models/venue_analytics_model.dart' as analytics;
import 'package:aio_sport/models/venue_booking_list_response.dart';
import 'package:aio_sport/models/venue_booking_response.dart';
import 'package:aio_sport/models/venue_create_activity_reponse.dart';
import 'package:aio_sport/models/venue_details_model.dart';
import 'package:aio_sport/models/venue_media_model.dart';
import 'package:aio_sport/models/venue_reviews_model.dart';
import 'package:aio_sport/objecbox_models/my_venue_bookings_model.dart';
import 'package:aio_sport/objecbox_models/venue_activities_model_obj.dart';
import 'package:aio_sport/objecbox_models/venue_details_obj.dart';
import 'package:aio_sport/objecbox_models/venue_media_model_obj.dart';
import 'package:aio_sport/screens/authentication/wrapper.dart';
import 'package:aio_sport/services/common_service.dart';
import 'package:aio_sport/services/player_service.dart';
import 'package:aio_sport/services/venue_service.dart';
import 'package:get/get.dart';

import '../models/venue_earning_model.dart';

class ProfileController extends GetxController {
  final authController = Get.isRegistered<AuthController>()
      ? Get.find<AuthController>()
      : Get.put(AuthController());
  var loading = false.obs;
  Rx<LoginResponseModel?> loginDataModel = Rx(null);
  Rx<VenueDetailsModel?> currentVenue = Rx(null);
  Rx<PlayerDetailsModel?> currentPlayer = Rx(null);
  RxList<mymatch.Match> playerMatches = <mymatch.Match>[].obs;
  RxList<nearby.Match> playerNearbyMatches = <nearby.Match>[].obs;
  RxList<sportsvenue.Venue> playerSportsVenueInfoList =
      <sportsvenue.Venue>[].obs;
  RxList<myteams.MyTeam> myTeams = <myteams.MyTeam>[].obs;
  Rx<VenueBookingsResponseModel?> venueBookings = Rx(null);
  Rx<VenueCreateActivityResponse?> venueActivities = Rx(null);
  Rx<VenueCreateActivityResponse?> otherVenueActivities = Rx(null);
  Rx<TeamsListDataModel?> teamsListData = Rx(null);
  Rx<PausedGroundModel?> pausedGroudsLi = Rx(null);
  Rx<analytics.VenueAnalyticsModel?> venueAnalytics = Rx(null);
  Rx<VenueEarningModel?> venueEarnings = Rx(null);
  Rx<VenueReviewsModel?> venueReviews = Rx(null);
  Rx<VenueMediaModel> venueMedia = Rx(
      VenueMediaModel(data: null, httpCode: 403, message: "Data not found."));
  Rx<my_venue.MyVenuesResponseModel?> myVenues = Rx(null);
  RxList<sports.Sport?> sportsList = <sports.Sport?>[].obs;
  RxList listOfVenueActivities = [].obs;
  //
  Rx<VenueBookingsResponseModel?> longBookings = Rx(null);
  Rx<VenueBookingsResponseModel?> shortBookings = Rx(null);

  // RxList<my_venue.Venue> myVenuesList = <my_venue.Venue>[].obs;
  var facilities = <Facility>[].obs;

  var isLongTerm = false.obs;

  String? get accountType => loginDataModel.value?.data?.user.roles.first.slug;
  RxList<sports.Sport> selectedSportsList = <sports.Sport>[].obs;
  var isLoggedIn = false.obs;
  var venueName = "".obs;
  var venueImage = "".obs;
  RxString selectedValue = "Last month".obs;

  int get numberOfBookings => venueBookings.value?.bookings?.data.length ?? 0;

  List<sports.Sport?> get venueSports =>
      currentVenue.value!.data!.venue.sports
          ?.map((e) => sportsList.firstWhere((element) => element!.id == e.id))
          .toList() ??
      <sports.Sport>[];
  var addFormSelectedSport = 0.obs;
  var addGroundFormSelectedGround = 0.obs;
  var addGroundFormSelectedAddon = 0.obs;
  var addGroundsFormSubmitted = false.obs;
  RxList<Ground> addGroundList = <Ground>[].obs;

  int get addGroundFormNumberOfGrounds => addGroundFormsList.length;
  var videosList = <File>[].obs;
  var videosThumbnailList = <File>[].obs;
  var imagesList = <File>[].obs;
  var addGroundFormsList = <Rx<FormInfo>>[].obs;

  String get bearer => loginDataModel.value!.data?.user.token ?? "";

  int? get venueId => currentVenue.value?.data!.venue.id;
  late VenueService venueService;

  int? get playerId => currentPlayer.value?.data.id;
  late PlayerService playerService;

  CommonService commonService = CommonService();

  @override
  void onInit() {
    super.onInit();
    venueService = VenueService(this);
    playerService = PlayerService(this);
  }

  Future<SuccessResponseModel?> uploadMedia(
      List<File> videos, List<File> images, String venueId) async {
    loading.value = true;
    SuccessResponseModel? model;
    if (images.isNotEmpty || videos.isNotEmpty) {
      model = await commonService.uploadImages(
          images, videos, loginDataModel.value!.data!.user.token, venueId);
      log("images upload result: $model");
    }
    return model;
  }

  int get numberOfPlayerMtaches => playerMatches.length;

  int get numberOfNearbyMtaches => playerNearbyMatches.length;

  int? get earnings => venueEarnings.value?.data!.totalVenueEarning;

  int? get metrics => venueAnalytics.value?.data.totalBooking;

  bool isVenue() {
    try {
      if (loginDataModel.value?.data?.user.roles.isNotEmpty ?? false) {
        return loginDataModel.value!.data!.user.roles.first.slug == "venue";
      } else {
        return loginDataModel.value?.data?.venueId == 0;
      }
    } on Exception catch (e) {
      log("exception calles isVenue() $e");
      return loginDataModel.value?.data?.venueId == 0;
    }
  }

  bool isCoach() {
    try {
      if (loginDataModel.value!.data!.user.roles.isNotEmpty) {
        return loginDataModel.value!.data!.user.roles.first.slug == "coach";
      } else {
        return loginDataModel.value!.data!.coachId == 0;
      }
    } on Exception catch (e) {
      log("exception calles isCoach() $e");
      return loginDataModel.value!.data!.coachId == 0;
    }
  }

  bool isPlayer() {
    try {
      if (loginDataModel.value?.data?.user.roles.isNotEmpty ?? false) {
        return loginDataModel.value!.data!.user.roles.first.slug == "player";
      } else {
        return loginDataModel.value?.data?.playerId == 0;
      }
    } on Exception catch (e) {
      log("exception calles isCoach() $e");
      return loginDataModel.value?.data?.playerId == 0;
    }
  }

  // void getVenueAnalytics() async {
  //   venueService.getVenueAnalytics(bearer, "$venueId").then((value) {
  //     if (value != null) {
  //       venueAnalytics.value = value;
  //       venueAnalytics.refresh();
  //     }
  //   });
  // }
  void getVenueAnalytics() async {
    try {
      var value = await venueService.getVenueAnalytics(bearer, "$venueId");
      if (value != null) {
        if (value.httpCode == 200) {
          venueAnalytics.value = value;
          venueAnalytics.refresh();
        } else {
          return print("${value.httpCode}");
        }
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  int fetchLongAndShortTypeOfBookings() {
    DateTime today = DateTime.now();

    bool isToday(DateTime date) {
      return date.year == today.year &&
          date.month == today.month &&
          date.day == today.day;
    }

    final shortTermBookings = venueAnalytics.value?.data.shortTermBooking ?? [];
    final longTermBookings = venueAnalytics.value?.data.longTermBooking ?? [];

    log("Length --> Short(${shortTermBookings.length}) Long(${longTermBookings.length})");

    int shortTermTotal = shortTermBookings
        .where((b) => isToday(b.bookingDate!))
        .fold(0, (sum, b) => sum + b.bookingCount);

    int longTermTotal = longTermBookings
        .where((b) => isToday(b.bookingDate!))
        .fold(0, (sum, b) => sum + b.bookingCount);

    return shortTermTotal + longTermTotal;
  }

  int getTotalBookingsToday() {
    DateTime today = DateTime.now();

    bool isToday(DateTime date) {
      return date.year == today.year &&
          date.month == today.month &&
          date.day == today.day;
    }

    /*final shortTermBookings = venueAnalytics.value?.data.shortTermBooking ?? [];
    final longTermBookings = venueAnalytics.value?.data.longTermBooking ?? [];

    log("Length --> Short(${shortTermBookings.length}) Long(${longTermBookings.length})");

    int shortTermTotal = shortTermBookings.where((b) => isToday(b.bookingDate)).fold(0, (sum, b) => sum + b.bookingCount);

    int longTermTotal = longTermBookings.where((b) => isToday(b.bookingDate)).fold(0, (sum, b) => sum + b.bookingCount);

    return shortTermTotal + longTermTotal;*/
    final todayBookings = venueBookings.value?.bookings?.data.where((b) {
      return isToday(b.bookingDate);
    }).toList();
    return todayBookings?.length ?? 0;
  }

  void changePassword(
      {required String oldPassword,
      required String newPassword,
      required String confirmPassword}) async {
    try {
      var result = await authController.authService.changePassword(
          confirmPassword: confirmPassword,
          password: newPassword,
          oldPassword: oldPassword,
          token: loginDataModel.value?.data?.user.token ?? "");
      if (result != null) {
        if (result.httpCode != 200) {
          Constants.showSnackbar("Error", result.message);
        } else {
          Get.back(closeOverlays: true);
          Constants.showSnackbar("Success", result.message);
        }
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void submitReport({required String issue, required String id}) async {
    try {
      var result = await commonService.submitReport(
          userId: loginDataModel.value?.data?.user.iD ?? 1,
          userRole: "venue",
          catergoryId: "17",
          issue: issue,
          token: loginDataModel.value?.data?.user.token ?? "");
      if (result != null) {
        if (result.httpCode != 200) {
          Constants.showSnackbar("Error", result.message);
        } else {
          Get.back(closeOverlays: true);
          Constants.showSnackbar("Success", result.message);
        }
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // void getVenueEarning() async {
  //   venueService.getVenueEarnings(bearer, "$venueId").then((value) {
  //     if (value != null) {
  //       venueEarnings.value = value;
  //       venueEarnings.refresh();
  //     }
  //     }
  //   );
  // }
  void getVenueEarning() async {
    try {
      var value = await venueService.getVenueEarnings(bearer, "$venueId");
      print('Valuereponse:' + value!.toString());
      if (value != null) {
        if (value.httpCode == 200) {
          venueEarnings.value = value;
          venueEarnings.refresh();
        } else {
          print("Hello cutireee");
          return print("${value.httpCode}");
        }
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void getVenueReviews() async {
    venueService.getVenueReviews(bearer, "$venueId").then((value) {
      if (value != null) {
        venueReviews.value = value;
        venueReviews.refresh();
      }
    });
  }

  void getVenueBookings() async {
    loading.value = true;

    final shortResults = await venueService.getVenuesBookings(
        bearer, "$venueId", "short", "1", "6");

    final longResults = await venueService.getVenuesBookings(
        bearer, "$venueId", "long", "1", "6");

    longBookings.value = longResults;
    shortBookings.value = shortResults;

    if (shortResults != null && longResults != null) {
      if (shortResults.httpCode == 200 || longResults.httpCode == 200) {
        var combinedBookings = [
          ...?shortResults.bookings?.data,
          ...?longResults.bookings?.data
        ];

        venueBookings.value = shortResults;
        combinedBookings
            .sort((b1, b2) => b2.bookingDate.compareTo(b1.bookingDate));
        venueBookings.value?.bookings?.data = combinedBookings;
        venueBookings.refresh();
        if (venueBookings.value != null) {
          objectbox.venuebookingBox.put(VenueBookingsResponseModelObj.fromJson(
              venueBookings.value!.toJson()));
        }
      }
    }
    loading.value = false;
  }

  void getVenueActivities({bool? getNewData}) async {
    loading.value = true;
    final results = await venueService.getVenuesActivities(bearer, "$venueId");
    if (results != null) {
      if (results.httpCode == 200 && results.data != null) {
        venueActivities.value = results;
        venueActivities.refresh();
        objectbox.venueActivityBox
            .put(VenueActivitiesObj.fromJson(results.toJson()));
      }
    }
    loading.value = false;
  }

  void getOtherVenueActivities({bool? getNewData}) async {
    loading.value = true;
    final results =
        await venueService.getOtherVenuesActivities(bearer, "$venueId");
    log("getOtherVenueActivities: $results");
    if (results != null) {
      if (results.httpCode == 200 && results.data != null) {
        otherVenueActivities.value = results;
        otherVenueActivities.refresh();
        objectbox.otherVenueActivityBox
            .put(VenueActivitiesObj.fromJson(results.toJson()));
      }
    }
    loading.value = false;
  }

  void getPausedGrounds({bool? getNewData}) async {
    loading.value = true;

    final results = await venueService.getPausedGrounds();
    if (results != null && results.httpCode == 200) {
      pausedGroudsLi.value = results;
      pausedGroudsLi.refresh();
    }

    loading.value = false;
  }

  void getVenuesListData() async {
    final results = await venueService.getMyVenuesDetails(bearer);
    if (results != null && results.httpCode == 200 && results.data != null) {
      myVenues.value = results;
      myVenues.refresh();
    }
  }

  Future<void> firstTimeLoginCheck() async {
    loading.value = true;
    final allSports = await venueService.getSports(bearer);
    if (allSports != null &&
        allSports.data != null &&
        allSports.data!.sports.isNotEmpty) {
      sportsList.assignAll(allSports.data!.sports);
      sportsList.refresh();
    }

    final facility = await venueService.getFacilities(bearer);
    if (facility != null && facility.data.facilities.isNotEmpty) {
      facilities.assignAll(facility.data.facilities);
      facilities.refresh();
    }
    if (isVenue()) {
      venueService
          .getVenueMedia(bearer, "${loginDataModel.value!.data!.venueId}")
          .then((value) => venueMedia.value = value ??
              VenueMediaModel(
                  httpCode: 401, message: "Data not found.", data: null));
      objectbox.venueMediaBox.put(
          venueMediaModelObjFromJson(venueMediaModelToJson(venueMedia.value)));
      final res = await venueService.getVenueDetails(
          bearer, "${loginDataModel.value!.data!.venueId}");
      getVenuesListData();
      getVenueAnalytics();
      if (res != null) {
        currentVenue.value = res;
        objectbox.venueBox.put(VenueDetailsModelObj.fromJson(res.toJson()));
        getVenueBookings();
        final sports = await venueService.getVenueSports(bearer, "$venueId");
        if (sports != null &&
            sports.data != null &&
            sports.data!.sports.isNotEmpty) {
          selectedSportsList.assignAll(sports.data!.sports);
        }
        getVenueActivities();
        getOtherVenueActivities();
        getPausedGrounds();
      }
    }

    loading.value = false;
  }

  void updateVenueData() {
    venueService.getVenueDetails(bearer, "$venueId").then((value) {
      if (value != null) {
        currentVenue.value = value;
        objectbox.venueBox.put(VenueDetailsModelObj.fromJson(value.toJson()));
      }
    });
  }

  Future<VenueMediaModel?> getVenueMedia() async {
    venueMedia.value = await venueService
        .getVenueMedia(bearer, "${loginDataModel.value!.data!.venueId}")
        .then((value) => venueMedia.value = value ??
            VenueMediaModel(
                httpCode: 401, message: "Data not found.", data: null));
    log("Venue media: ${venueMedia.value.data?.photos.toString()}");
    return venueMedia.value;
    ;
  }

  void switchVenue(String venueId) async {
    loading.value = true;
    final venue = await venueService.getVenueDetails(bearer, venueId);

    if (venue != null && venue.data != null) {
      currentVenue.value = venue;
      venueMedia.value =
          VenueMediaModel(httpCode: 401, message: "No media found", data: null);
      objectbox.venueMediaBox.removeAll();
      objectbox.venueActivityBox.removeAll();
      objectbox.venuebookingBox.removeAll();
      objectbox.venueBox.put(VenueDetailsModelObj.fromJson(venue.toJson()));
      venueMedia.value = await venueService.getVenueMedia(bearer, venueId) ??
          VenueMediaModel(
              httpCode: 401, message: "No media found.", data: null);
    }
    loading.value = false;
  }

  void updatePlayerDataFromApi() {
    playerService.getPlayerMatchesList(bearer, "$playerId").then((value) {
      if (value != null && value.httpCode == 200) {
        playerMatches.assignAll(value.data.match);
        playerMatches.refresh();
      }
    });
    playerService.getPlayerNearbyMatchesList(bearer, "$playerId").then((value) {
      if (value != null && value.data != null && value.httpCode == 200) {
        playerNearbyMatches.assignAll(value.data!.matches);
        playerNearbyMatches.refresh();
      }
    });

    playerService
        .getSportsVenueInfoList(bearer, "$playerId", "1")
        .then((value) {
      if (value != null && value.data != null && value.httpCode == 200) {
        playerSportsVenueInfoList
            .assignAll(value.data!.data ?? <sportsvenue.Venue>[]);
        playerSportsVenueInfoList.refresh();
      }
    });

    playerService.getPlayerTeam(bearer, "$playerId").then((value) {
      if (value != null && value.data != null && value.httpCode == 200) {
        myTeams.assignAll(value.data!.myTeams);
        myTeams.refresh();
      }
    });
  }

  void signout() {
    if (isVenue()) {
      getStorage.write(Constants.isLoggedIn, false);
      selectedSportsList.clear();
      loginDataModel.value = null;
      currentVenue.value = null;
      venueBookings.value = null;
      venueActivities.value = null;
      pausedGroudsLi.value = null;
      myVenues.value = null;
      myVenues.value = null;
      objectbox.loginBox.removeAll();
      objectbox.venueBox.removeAll();
      objectbox.venueActivityBox.removeAll();
      objectbox.venuebookingBox.removeAll();
      isLoggedIn.value = false;
      Get.delete<VenueManagerController>();
    }
    if (isPlayer()) {
      getStorage.write(Constants.isLoggedIn, false);
      selectedSportsList.clear();
      loginDataModel.value = null;
      currentPlayer.value = null;
      objectbox.loginBox.removeAll();
      objectbox.playerBox.removeAll();
      isLoggedIn.value = false;
      Get.delete<PlayerManagerController>();
    }
  }
}
