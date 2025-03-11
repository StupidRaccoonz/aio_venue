import 'dart:developer';

import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/controllers/auth_controller.dart';
import 'package:aio_sport/controllers/home_controller.dart';
import 'package:aio_sport/models/login_response_model.dart';
import 'package:aio_sport/models/sports_data_model.dart';
import 'package:aio_sport/models/venue_details_model.dart' as venue;
import 'package:aio_sport/objecbox_models/sports_data_obj.dart';
import 'package:aio_sport/objecbox_models/venue_details_obj.dart';
import 'package:aio_sport/screens/common/loading_page.dart';
import 'package:aio_sport/screens/common/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:objectbox/objectbox.dart';
import 'package:scaled_size/scaled_size.dart';

import 'controllers/profile_controller.dart';
import 'models/my_venues_model.dart';
import 'objecbox_models/object_box.dart';
import 'themes/custom_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  objectbox = await ObjectBox.create();

  if (Admin.isAvailable()) {
    // Keep a reference until no longer needed or manually closed.
    admin = Admin(objectbox.store);
  }

  runApp(MyApp());
  // runApp(DevicePreview(
  //   builder: (context) => MyApp(), // Wrap your app
  // ));
}

late ObjectBox objectbox;
late Admin admin;

class MyApp extends StatelessWidget {
  final getStorage = GetStorage();
  MyApp({super.key});

  // final venuprofile = Get.put(VenueProfileController());

  final profile = Get.put(ProfileController());
  final home = Get.put(HomeController());
  final authC = Get.put(AuthController());

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    // profile.signout();
    // getStorage.write(Constants.lastPage, "UploadMediaScreen");
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScaledSize(builder: () {
      // getStorage.write(Constants.isNewAccount, true);
      profile.isLoggedIn.value = getStorage.read<bool>(Constants.isLoggedIn) ?? false;
      // bool isNew = getStorage.read<bool>(Constants.isNewAccount) ?? false;
      // if user is logged in
      if (profile.isLoggedIn.value && !objectbox.loginBox.isEmpty()) {
        profile.loginDataModel.value = LoginResponseModel.fromJson(objectbox.loginBox.get(1)!.toJson());
        log("user info ${profile.loginDataModel.value?.toJson()}");

        // get all sports list
        if (!objectbox.sportsBox.isEmpty()) {
          profile.sportsList.assignAll(SportsDatamodel.fromJson(objectbox.sportsBox.get(5)!.toJson()).data!.sports);
        }
        profile.venueService.getSports(profile.bearer).then((value) {
          if (value != null && value.data != null && value.data!.sports.isNotEmpty) {
            profile.sportsList.assignAll(value.data!.sports);
            profile.sportsList.refresh();
            objectbox.sportsBox.put(SportsDatamodelObj.fromJson(value.toJson()));
          }
        });

        if (profile.isVenue()) {
          // if offline data available
          if (!objectbox.venueBox.isEmpty()) {
            profile.currentVenue.value = venue.VenueDetailsModel.fromJson(objectbox.venueBox.get(2)!.toJson());

            // get venue sports list
            profile.venueService.getVenueSports(profile.bearer, "${profile.venueId}").then((value) {
              if (value != null && value.data != null && value.data!.sports.isNotEmpty) {
                profile.selectedSportsList.assignAll(value.data!.sports);
                profile.selectedSportsList.refresh();
                if (profile.addGroundFormsList.isNotEmpty) {
                  profile.addGroundFormsList.first.value.groundSize = profile.selectedSportsList.first.sportsizes.first.size;
                }
              }
            });

            // Get venue details
            profile.venueService.getVenueDetails(profile.bearer, "${profile.venueId}").then((response) {
              if (response != null && response.httpCode == 200) {
                profile.currentVenue.value = response;
                objectbox.venueBox.put(VenueDetailsModelObj.fromJson(response.toJson()));
              }
            });
            profile.venueService.getMyVenuesDetails(profile.bearer).then((MyVenuesResponseModel? myVenues) {
              if (myVenues != null && myVenues.data != null) {
                profile.myVenues.value = myVenues;
              }
            });

            profile.getVenueBookings();
            profile.getVenueActivities();
            profile.getOtherVenueActivities();
            profile.getVenueAnalytics();
            profile.getVenueReviews();
            profile.getVenueEarning();

            // log("currentVenue ${objectbox.venueBox.get(2)!.toJson()}");
          } else {
            // profile.currentVenue.value = VenueDetailsModel.fromJson(objectbox.venueBox.get(2)!.toJson());
            profile.loading.value = true;
            // getting venue details from API
            profile.venueService.getMyVenuesDetails(profile.bearer).then((MyVenuesResponseModel? myVenues) async {
              if (myVenues != null && myVenues.data != null && myVenues.data!.venue.isNotEmpty && myVenues.httpCode == 200) {
                profile.currentVenue.value = venue.VenueDetailsModel.fromJson(myVenues.toJson());
                profile.myVenues.value = myVenues;
                profile.myVenues.refresh();
                // get venue sports list
                await profile.venueService.getVenueSports(profile.bearer, "${profile.venueId}").then((value) {
                  if (value != null && value.data != null && value.data!.sports.isNotEmpty) {
                    profile.selectedSportsList.assignAll(value.data!.sports);
                    profile.selectedSportsList.refresh();
                  }
                });
                profile.getVenueBookings();
                profile.getVenueActivities();
                profile.getOtherVenueActivities();
                profile.getVenueAnalytics();
                profile.getVenueReviews();
                profile.getVenueEarning();
                // adding data for offline
                objectbox.venueBox.put(VenueDetailsModelObj.fromJson(profile.currentVenue.value!.toJson()));
              } else {
                // Constants.showSnackbar("Error", myVenues?.message ?? "Venue data not found");
                getStorage.write(Constants.lastPage, 'VenueDetails');
              }
              profile.loading.value = false;
            });
          }
        }

        // objectbox.loginBox.removeAll();
      }

      return GetMaterialApp(
        title: 'AIO Sport',
        theme: ThemeData(
            useMaterial3: true,
            primaryColor: CustomTheme.appColor,
            textTheme: CustomTheme.textTheme,
            appBarTheme: CustomTheme.appBarTheme,
            scaffoldBackgroundColor: const Color(0xFFF7F9FA)),
        // home: Wrapper(),
        routes: {"/": (context) => SplashScreen()},
        defaultTransition: Transition.cupertino,
        initialRoute: "/",
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          if (child == null) {
            return const LoadingPage();
          }
          double textScale = MediaQuery.of(context).textScaler.scale(1);
          log("textScale value: $textScale");
          return MediaQuery(data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(textScale >= 1 ? 0.8 : 0.9)), child: child);
        },
      );
    });
  }
}
