import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/models/player/player_details_model.dart';
import 'package:aio_sport/models/player/sports_venue_list_model.dart' as venuesport;
import 'package:get/get.dart';

class PlayerManagerController extends GetxController {
  var loading = false.obs;
  final profileController = Get.find<ProfileController>();
  Rx<venuesport.Sport?> selectedSport = Rx(null);
  RxList<venuesport.Venue?> venuesList = <venuesport.Venue>[].obs;
  PlayerDetailsModel get player => profileController.currentPlayer.value!;
  List<Sport> get playerSports => player.data.sports ?? <Sport>[];
  List<Sport> get myTeams => player.data.sports ?? <Sport>[];

  @override
  void onReady() {
    super.onReady();

    if (player.data.sports != null && player.data.sports!.isNotEmpty) {
      selectedSport.value = venuesport.Sport.fromJson(playerSports.first.toJson());
    }
  }

  void getPlayerData() {}
}
