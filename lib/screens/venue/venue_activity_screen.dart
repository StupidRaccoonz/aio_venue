import 'dart:developer';

import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/controllers/veneue_manager_controller.dart';
import 'package:aio_sport/models/booking_filter_model.dart';
import 'package:aio_sport/models/venue_create_activity_reponse.dart';
import 'package:aio_sport/models/venue_details_model.dart';
import 'package:aio_sport/screens/venue/venue_create_activity.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/activity_card_widget.dart';
import 'package:aio_sport/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

import 'venue_bookings_filters.dart';

class VenueActivityScreen extends StatefulWidget {
  const VenueActivityScreen({super.key});

  @override
  State<VenueActivityScreen> createState() => _VenueActivityScreenState();
}

class _VenueActivityScreenState extends State<VenueActivityScreen> with AutomaticKeepAliveClientMixin {
  late BookingFilterModel filterModelMyActivity;
  late BookingFilterModel filterModelOther;
  bool isMyActivity = true;
  final manager = Get.find<VenueManagerController>();
  final profileController = Get.find<ProfileController>();

  @override
  void initState() {
    filterModelMyActivity = BookingFilterModel(sport: Sport(), date: 6);
    filterModelOther = BookingFilterModel(sport: Sport(), date: 6);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      filterModelMyActivity = BookingFilterModel(sport: profileController.currentVenue.value!.data!.venue.sports!.first, date: 6);

      filterModelOther = BookingFilterModel(sport: profileController.currentVenue.value!.data!.venue.sports!.first, date: 6);
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.maxFinite, 10.vh),
          child: const AppbarWidget(
            title: "Activities",
            //  leading: SizedBox(),
          )),
      body: LayoutBuilder(builder: (context, constraints) {
        return DefaultTabController(
          length: 3,
          child: Column(
            children: [
              TabBar(
                  onTap: (value) => setState(() {
                        isMyActivity = value == 0;
                      }),
                  tabs: [
                    Tab(
                        height: 30.rh,
                        child: FittedBox(
                          child: Text(
                            "My Activity",
                          ),
                        )),
                    Tab(height: 30.rh, child: FittedBox(child: const Text("Other Activity"))),
                    Tab(height: 30.rh, child: const Text("Completed")),
                  ]),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    // My Activity
                    Column(
                      children: [
                        // Filters list
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => applyFilters(0, true),
                                child: Chip(
                                  label: Text(
                                    filterModelMyActivity.sport.name ?? "",
                                    style: Get.textTheme.labelMedium,
                                  ),
                                  deleteIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                                  onDeleted: () {
                                    applyFilters(0, true);
                                  },
                                  side: BorderSide(color: CustomTheme.borderColor),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.br)),
                                ),
                              ),
                              const SizedBox(width: 13.0),
                              GestureDetector(
                                onTap: () => applyFilters(1, true),
                                child: Chip(
                                  label: Text(
                                    Constants.intToString(filterModelMyActivity.date, false),
                                    style: Get.textTheme.labelMedium,
                                  ),
                                  deleteIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                                  onDeleted: () {
                                    applyFilters(1, true);
                                  },
                                  side: BorderSide(color: CustomTheme.borderColor),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.br)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Obx(() {
                            var listOfMatches = profileController.venueActivities.value?.data?.match.where((element) => element.type == "venue" && element.sport.name == filterModelMyActivity.sport.name).toList() ?? [];

                            listOfMatches = Constants.filterMatchesByDate(listOfMatches, filterModelMyActivity.date).reversed.toList();
                            return listOfMatches.isEmpty
                                ? Center(
                                    child: Text(
                                      "No activities found",
                                      style: Get.textTheme.headlineSmall!.copyWith(color: CustomTheme.appColor),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: listOfMatches.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: ActivityCardWidget(
                                            height: constraints.maxHeight * 0.35,
                                            width: constraints.maxWidth * 0.9,
                                            fromActivity: true,
                                            onPressed: () {},
                                            activityModel: listOfMatches[index],
                                          ));
                                    },
                                  );
                          }),
                        ),
                      ],
                    ),

                    // Other Activity
                    Column(
                      children: [
                        // Filters list
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => applyFilters(0, false),
                                child: Chip(
                                  label: Text(
                                    filterModelOther.sport.name ?? "",
                                    style: Get.textTheme.labelMedium,
                                  ),
                                  deleteIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                                  onDeleted: () {
                                    applyFilters(0, false);
                                  },
                                  side: BorderSide(color: CustomTheme.borderColor),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.br)),
                                ),
                              ),
                              const SizedBox(width: 13.0),
                              GestureDetector(
                                onTap: () => applyFilters(1, false),
                                child: Chip(
                                  label: Text(
                                    Constants.intToString(filterModelOther.date, false),
                                    style: Get.textTheme.labelMedium,
                                  ),
                                  deleteIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                                  onDeleted: () {
                                    applyFilters(1, false);
                                  },
                                  side: BorderSide(color: CustomTheme.borderColor),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.br)),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          child: Obx(() {
                            var listOfMatches = profileController.otherVenueActivities.value?.data?.match.where((element) => element.type != "venue" && element.sport.name == filterModelOther.sport.name).toList() ?? [];
                            listOfMatches = Constants.filterMatchesByDate(listOfMatches, filterModelOther.date);

                            return ListView.builder(
                              itemCount: listOfMatches.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: ActivityCardWidget(
                                    height: constraints.maxHeight * 0.25,
                                    width: constraints.maxWidth * 0.9,
                                    fromActivity: true,
                                    onPressed: () {},
                                    activityModel: listOfMatches[index],
                                  ),
                                );
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                    //completed
                    Column(
                      children: [
                        // Filters list
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () => applyFilters(0, true),
                                child: Chip(
                                  label: Text(
                                    filterModelMyActivity.sport.name ?? "",
                                    style: Get.textTheme.labelMedium,
                                  ),
                                  deleteIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                                  onDeleted: () {
                                    applyFilters(0, true);
                                  },
                                  side: BorderSide(color: CustomTheme.borderColor),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.br)),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => applyFilters(0, true),
                                child: Chip(
                                  label: Text(
                                    Constants.intToString(filterModelMyActivity.date, false),
                                    style: Get.textTheme.labelMedium,
                                  ),
                                  deleteIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                                  onDeleted: () {
                                    applyFilters(1, true);
                                  },
                                  side: BorderSide(color: CustomTheme.borderColor),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.br)),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => applyFilters(0, true),
                                child: Chip(
                                  label: Text(
                                    filterModelMyActivity.sport.name ?? "",
                                    style: Get.textTheme.labelMedium,
                                  ),
                                  deleteIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                                  onDeleted: () {
                                    applyFilters(0, true);
                                  },
                                  side: BorderSide(color: CustomTheme.borderColor),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.br)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Obx(() {
                            List<CreateActivityMatch> completedMatches = _getCompletedMatches();
                            completedMatches = Constants.filterMatchesByDate(completedMatches, filterModelMyActivity.date);
                            return completedMatches.isEmpty
                                ? Center(
                                    child: Text(
                                      "No activities found",
                                      style: Get.textTheme.headlineSmall!.copyWith(color: CustomTheme.appColor),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: completedMatches.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: ActivityCardWidget(
                                            height: constraints.maxHeight * 0.35,
                                            width: constraints.maxWidth * 0.9,
                                            fromActivity: true,
                                            onPressed: () {},
                                            activityModel: completedMatches[index],
                                          ));
                                    },
                                  );
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
      floatingActionButton: isMyActivity
          ? FloatingActionButton(
              heroTag: Get.currentRoute,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.br)),
              backgroundColor: CustomTheme.appColorSecondary,
              onPressed: () => Get.to(() => const VenueCreateActivityScreen()),
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }

  List<CreateActivityMatch> _getCompletedMatches() {
    List<CreateActivityMatch>? myActivityMatches = profileController.venueActivities.value?.data?.match;
    List<CreateActivityMatch>? otherActivityMatches = profileController.otherVenueActivities.value?.data?.match;
    List<CreateActivityMatch> completedMatches = [];

    DateTime currentDate = DateTime.now();

    if (myActivityMatches != null) {
      completedMatches.addAll(
        myActivityMatches.where((match) => match.date.isBefore(currentDate)).toList(),
      );
    }

    if (otherActivityMatches != null) {
      completedMatches.addAll(
        otherActivityMatches.where((match) => match.date.isBefore(currentDate)).toList(),
      );
    }

    return completedMatches;
  }

  Future<void> applyFilters(int filterIndex, bool myActivity) async {
    BookingFilterModel? bookingFilters = await Get.bottomSheet<BookingFilterModel>(
      VenueBookingFilters(filterModel: filterIndex == 0 ? filterModelMyActivity : filterModelOther, isBooking: false, filterIndex: filterIndex),
      isScrollControlled: false,
      enableDrag: false,
    );
    if (bookingFilters != null) {
      if (myActivity) {
        filterModelMyActivity = bookingFilters;
      } else {
        filterModelOther = bookingFilters;
      }
      setState(() {});
    }
    log("bookingFilters applied: $bookingFilters");
  }

  @override
  bool get wantKeepAlive => true;
}
