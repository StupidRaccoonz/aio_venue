import 'dart:developer';

import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/screens/venue/venue_details.dart';
import 'package:aio_sport/widgets/venue_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

class VenueListBottomSheet extends StatefulWidget {
  const VenueListBottomSheet({super.key});

  @override
  State<VenueListBottomSheet> createState() => _VenueListBottomSheetState();
}

class _VenueListBottomSheetState extends State<VenueListBottomSheet> {
  int selectedVenue = 0;
  final profileController = Get.find<ProfileController>();

  @override
  void initState() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
      selectedVenue = profileController.myVenues.value!.data!.venue
          .indexWhere((element) => element.id == profileController.currentVenue.value!.data!.venue.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.br)),
      child: Column(
        children: [
          Material(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.br)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: Row(
                children: [
                  Text("My Venue", style: Get.textTheme.displayMedium),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Get.back();
                      Get.to(() => const VenueDetails(addAnotherVenue: true));
                    },
                    child: Text("+ Add new venue", style: Get.textTheme.headlineSmall),
                  )
                ],
              ),
            ),
          ),
          const Divider(),
          profileController.myVenues.value == null
              ? VenueListWidget(
                  imageUrl: profileController.currentVenue.value?.data?.venue.profilePicture ?? "",
                  selectedVenue: selectedVenue,
                  onChanged: (value) {},
                  venueCity: profileController.currentVenue.value!.data!.venue.address,
                  venueName: profileController.currentVenue.value!.data!.venue.name,
                  index: 0,
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: profileController.myVenues.value?.data?.venue.length,
                    itemBuilder: (context, index) {
                      final model = profileController.myVenues.value!.data!.venue[index];
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          VenueListWidget(
                            imageUrl: model.profilePicture ?? "n/a",
                            selectedVenue: selectedVenue,
                            onChanged: (value) async {
                              log("onChanged: $value");
                              selectedVenue = value ?? 0;

                              setState(() {});
                              Get.back();
                              if (model.id == profileController.currentVenue.value!.data!.venue.id) {
                                return;
                              }

                              profileController.switchVenue("${model.id}");
                            },
                            venueCity: model.address,
                            venueName: model.name,
                            index: index,
                          ),
                          const Divider(height: 4.0),
                        ],
                      );
                    },
                  ),
                )
        ],
      ),
    );
  }
}
