import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/models/paused_ground_model.dart';
import 'package:aio_sport/models/venue_details_model.dart' as details;
import 'package:aio_sport/services/venue_service.dart';
import 'package:get/get.dart';

class VenueManagerController extends GetxController {
  var loading = false.obs;
  final profileController = Get.find<ProfileController>();
  late Rx<details.VenueDetailsModel> selectedVenue;
  List<PausedGround> get pausedGroundes => profileController.pausedGroudsLi.value?.data.grounds ?? [];
  // int get venueId => selectedVenue.value.data?.venue.id ?? 0;
  List<details.Venue> get myVenuesList =>
      profileController.myVenues.value!.data!.venue.map((e) => details.Venue.fromJson(e.toJson())).toList();
  var selectedGroundSportId = 1.obs;
  VenueService get venueService => profileController.venueService;
  // for venue home screen
  var selectedSportForVenueActivityIndex = 0.obs;
  var selectedSportForOtherActivityIndex = 0.obs;

  // for create activity screen
  var selectedDate = 1.obs;
  var numberOfPlayers = 5.obs;
  Rx<String> selectedSport = "Football".obs;
  var teamChallange = false.obs;

  @override
  void onInit() {
    selectedVenue = Rx(profileController.currentVenue.value!);
    if (profileController.selectedSportsList.isNotEmpty) {
      selectedSport = Rx(profileController.selectedSportsList.first.name);
    }
    // myVenuesList = RxList(profileController.myVenues.value!.data!.venue.map((e) => details.Venue.fromJson(e.toJson())).toList());
    super.onInit();
  }
}
