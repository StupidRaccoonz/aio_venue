import 'dart:developer';
import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/controllers/auth_controller.dart';
import 'package:aio_sport/controllers/home_controller.dart';
import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/main.dart';
import 'package:aio_sport/models/venue_media_model.dart';
import 'package:aio_sport/objecbox_models/venue_media_model_obj.dart';
import 'package:aio_sport/screens/authentication/login_screen.dart';
import 'package:aio_sport/screens/authentication/signup_screen.dart';
import 'package:aio_sport/screens/common/loading_page.dart';
import 'package:aio_sport/screens/common/upload_media_screen.dart';
// import 'package:aio_sport/screens/player/player_details_screen.dart';
// import 'package:aio_sport/screens/player/player_main_screen.dart';
// import 'package:aio_sport/screens/venue/add_grounds_screen.dart';
import 'package:aio_sport/screens/venue/facilities_screen.dart';
import 'package:aio_sport/screens/venue/new_add_ground_screen.dart';
import 'package:aio_sport/screens/venue/venue_details.dart';
import 'package:aio_sport/screens/venue/venue_main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

final getStorage = GetStorage();

class Wrapper extends StatelessWidget {
  Wrapper({Key? key}) : super(key: key);
  final homeController = Get.find<HomeController>();
  final authController = Get.find<AuthController>();
  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    bool loadingMedia = false;
    return Obx(() {
      if (profileController.isLoggedIn.value && profileController.loginDataModel.value != null) {
        // checking if user type is venue
        // getStorage.write(Constants.lastPage, "UploadMediaScreen");
        if (profileController.isVenue()) {
          /* if (profileController.currentVenue.value == null) {
            return const LoadingPage();
          } */

          if (profileController.loading.value && profileController.currentVenue.value == null) {
            return const LoadingPage();
          }

          if (profileController.loginDataModel.value!.data!.venueId == 0 && profileController.currentVenue.value == null) {
            getStorage.write(Constants.lastPage, "VenueDetails");
            return const VenueDetails(addAnotherVenue: false);
          }

          if (!objectbox.venueMediaBox.isEmpty() &&
              objectbox.venueMediaBox.get(6) != null &&
              objectbox.venueMediaBox.get(6)?.httpCode == 200 &&
              profileController.venueMedia.value.data == null) {
            profileController.venueMedia.value = VenueMediaModel.fromJson(objectbox.venueMediaBox.get(6)!.toJson());
          } else if (profileController.currentVenue.value != null && profileController.venueMedia.value.data == null && !loadingMedia) {
            loadingMedia = true;
            final venueId =
                profileController.loginDataModel.value!.data!.venueId != 0 ? profileController.loginDataModel.value!.data!.venueId : profileController.venueId;
            profileController.venueService.getVenueMedia(profileController.bearer, "$venueId").then((value) {
              profileController.venueMedia.value = value ?? VenueMediaModel(httpCode: 401, message: "Media not found.", data: null);
              objectbox.venueMediaBox.put(venueMediaModelObjFromJson(venueMediaModelToJson(profileController.venueMedia.value)));
            });
          }

          if (profileController.currentVenue.value != null && profileController.venueMedia.value.data == null ||
              profileController.venueMedia.value.data!.photos.isEmpty) {
            return const UploadMediaScreen();
          }

          if (profileController.currentVenue.value != null && profileController.currentVenue.value!.data!.venue.facilitiesVenues.isEmpty) {
            getStorage.write(Constants.lastPage, "FacilitiesScreen");
            return const FacilitiesScreen();
          }

          if (profileController.currentVenue.value != null && profileController.currentVenue.value!.data!.venue.grounds.isEmpty) {
            getStorage.write(Constants.lastPage, "AddGroundsScreen");
            return const NewAddGroundScreen();
          }

          if (getStorage.read<bool>(Constants.isNewAccount) ?? false || profileController.currentVenue.value == null) {
            log("Last page value: ${getStorage.read<String>(Constants.lastPage)}");
            /* if (profileController.currentVenue.value!.data!.venue.grounds.isEmpty && getStorage.read<String>(Constants.lastPage) == "/") {
              return const AddGroundsScreen();
            } */

            switch (getStorage.read<String>(Constants.lastPage) ?? "/") {
              case "/":
                return const VenueMainPage();
              case "VenueDetails":
                return const VenueDetails(addAnotherVenue: false);
              case "UploadMediaScreen":
                return const UploadMediaScreen();
              case "FacilitiesScreen":
                return const FacilitiesScreen();
              case "AddGroundsScreen":
                return const NewAddGroundScreen();
            }
          }

          if (profileController.currentVenue.value!.data!.venue.grounds.isEmpty) {
            return const NewAddGroundScreen();
          }

          return const VenueMainPage();
        }
        // for Coach
        if (profileController.isCoach()) {
          return const VenueMainPage();
        }
        // for player
        if (profileController.isPlayer()) {
          if (profileController.loading.value && profileController.currentPlayer.value == null) {
            return const LoadingPage();
          }

          // if (profileController.loginDataModel.value!.data!.playerId == 0 && profileController.currentPlayer.value == null) {
          //   // getStorage.write(Constants.lastPage, "VenueDetails");
          //   return const PlayerDetailsScreen();
          // }

          if (profileController.loginDataModel.value?.data?.playerId != 0 && profileController.currentPlayer.value == null && objectbox.playerBox.isEmpty()) {
            profileController.loading.value = true;
            profileController.playerService
                .getPlayerDetails(profileController.bearer, "${profileController.loginDataModel.value!.data!.playerId}")
                .then((value) {
              profileController.currentPlayer.value = value;
              objectbox.playerBox.get(7);
              profileController.updatePlayerDataFromApi();
              profileController.loading.value = false;
            });
            return const LoadingPage();
          }

         // return const PlayerMainPage();
        }
        return const VenueDetails(addAnotherVenue: false);
      }

      getStorage.write(Constants.isLoggedIn, false);
      return authController.isLoginPage.value ? const LoginScreen() : const SignupScreen();
    });
  }
}
