// ignore_for_file: depend_on_referenced_packages

import 'package:aio_sport/objecbox_models/player_details_obj.dart';
import 'package:aio_sport/objecbox_models/venue_media_model_obj.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../objectbox.g.dart'; // created by `flutter pub run build_runner build`
import 'login_response_obj.dart';
import 'my_venue_bookings_model.dart';
import 'sports_data_obj.dart';
import 'venue_activities_model_obj.dart';
import 'venue_details_obj.dart';

class ObjectBox {
  /// The Store of this app.
  late final Store store;
  late final Box<LoginResponseModelObj> loginBox;
  late final Box<VenueDetailsModelObj> venueBox;
  late final Box<PlayerDetailsModelObj> playerBox;
  late final Box<SportsDatamodelObj> sportsBox;
  late final Box<VenueBookingsResponseModelObj> venuebookingBox;
  late final Box<VenueActivitiesObj> venueActivityBox;
  late final Box<VenueActivitiesObj> otherVenueActivityBox;
  late final Box<VenueMediaModelObj> venueMediaBox;

  ObjectBox._create(this.store) {
    // Add any additional setup code, e.g. build queries.
    loginBox = Box<LoginResponseModelObj>(store);
    venueBox = Box<VenueDetailsModelObj>(store);
    playerBox = Box<PlayerDetailsModelObj>(store);
    sportsBox = Box<SportsDatamodelObj>(store);
    venuebookingBox = Box<VenueBookingsResponseModelObj>(store);
    venueActivityBox = Box<VenueActivitiesObj>(store);
    otherVenueActivityBox = Box<VenueActivitiesObj>(store);
    venueMediaBox = Box<VenueMediaModelObj>(store);
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore(directory: p.join(docsDir.path, "aiosport-obj"));

    return ObjectBox._create(store);
  }
}
