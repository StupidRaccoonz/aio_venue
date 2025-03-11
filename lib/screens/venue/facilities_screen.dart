import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/models/venue_details_model.dart';
import 'package:aio_sport/screens/authentication/wrapper.dart';
import 'package:aio_sport/screens/venue/new_add_ground_screen.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

import '../common/upload_media_screen.dart';
import 'add_grounds_screen.dart';

class FacilitiesScreen extends StatefulWidget {
  final String? venueId;

  const FacilitiesScreen({super.key, this.venueId});

  @override
  State<FacilitiesScreen> createState() => _FacilitiesScreenState();
}

class _FacilitiesScreenState extends State<FacilitiesScreen> {
  final profileController = Get.find<ProfileController>();

  List<int> selectedFacilities = List.filled(11, 0);

  @override
  void initState() {
    getFacilities();
    super.initState();
    if ((getStorage.read<bool>(Constants.isNewAccount) ?? false) || widget.venueId == null) {
      getStorage.write(Constants.lastPage, "FacilitiesScreen");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(builder: (context, constraints) {
          return Obx(() {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5.0.rh),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: IconButton(onPressed: () => Get.to(() => UploadMediaScreen()), icon: Icon(Icons.arrow_back_rounded, color: CustomTheme.appColor)),
                      ),
                      SizedBox(height: 5.0.rh),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Facilities", style: Get.textTheme.titleLarge),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text("Let us know what facilities you will provide to the players", style: Get.textTheme.displaySmall),
                      ),
                      SizedBox(height: 10.0.rh),
                      Expanded(
                        child: ListView.builder(
                          itemCount: selectedFacilities.length,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: Text(profileController.facilities[index].name, style: Get.textTheme.headlineLarge),
                                  // value: selectedFacilities[index] == profileController.facilities[index].id,
                                  onTap: () {
                                    if (selectedFacilities[index] != profileController.facilities[index].id) {
                                      selectedFacilities[index] = profileController.facilities[index].id;
                                    } else {
                                      selectedFacilities[index] = 0;
                                    }
                                    setState(() {});
                                  },
                                  trailing: selectedFacilities[index] == 0 ? const SizedBox() : Icon(Icons.check_rounded, color: CustomTheme.iconColor),
                                  // activeColor: CustomTheme.appColorSecondary,
                                ),
                                Divider(color: CustomTheme.borderColor)
                              ],
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: MyButton(
                          text: "Next",
                          onPressed: () async {
                            profileController.loading.value = true;
                            await profileController.venueService
                                .addFacilities(profileController.bearer, "${profileController.venueId}", selectedFacilities.map((e) => "$e").toList());
                            if (profileController.currentVenue.value != null && profileController.currentVenue.value!.data!.venue.grounds.isEmpty ||
                                widget.venueId != null) {
                              Get.to(() =>  NewAddGroundScreen()); // old
                              // Get.to(() => const AddGroundsScreen());
                            } else {
                              for (var facility in profileController.facilities) {
                                if (selectedFacilities.contains(facility.id)) {
                                  profileController.currentVenue.value!.data!.venue.facilitiesVenues.add(FacilitiesVenue.fromJson(facility.toJson()));
                                }
                              }
                              // getStorage.write(Constants.lastPage, "AddGroundsScreen");
                              profileController.currentVenue.refresh();
                              Get.to(() => NewAddGroundScreen()); // old
                              // Get.to(() => const AddGroundsScreen());
                            }
                            profileController.loading.value = false;
                          },
                          height: 25.rh,
                        ),
                      ),
                    ],
                  ),
                ),
                profileController.loading.value
                    ? Container(color: Colors.white54, child: Center(child: CircularProgressIndicator(color: CustomTheme.appColor)))
                    : const SizedBox(),
              ],
            );
          });
        }),
      ),
    );
  }

  Future<void> getFacilities() async {
    selectedFacilities = List.filled(profileController.facilities.length, 0);
    final data = await profileController.venueService.getFacilities(profileController.bearer);
    if (data != null && data.data.facilities.isNotEmpty) {
      profileController.facilities.assignAll(data.data.facilities);
      selectedFacilities = List.filled(profileController.facilities.length, 0);
      setState(() {});
    }
    // profileController.loading.value = false;
  }
}
