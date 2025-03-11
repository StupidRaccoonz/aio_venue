import 'package:get/get.dart';

class VenueProfileController extends GetxController {
  var loading = false.obs;
  var venueName = "".obs;
  var venueImage = "".obs;
  var selectedSport = "Football".obs;
  var numberOfBookings = 0.obs;
  var selectedDate = 1.obs;
  var numberOfPlayers = 5.obs;
  var teamChallange = false.obs;
}
