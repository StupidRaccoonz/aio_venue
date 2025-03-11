import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/controllers/home_controller.dart';
import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/controllers/veneue_manager_controller.dart';
import 'package:aio_sport/screens/common/venue_review_widget.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/activity_card_widget.dart';
import 'package:aio_sport/widgets/empty_box_widget.dart';
import 'package:aio_sport/widgets/filter_selection_chip.dart';
import 'package:aio_sport/widgets/home_page_card.dart';
import 'package:aio_sport/widgets/icon_button_widget.dart';
import 'package:aio_sport/widgets/venu_home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

import 'slider_widget.dart';
import 'venue_booking_details_screen.dart';

class VenueHomeScreen extends StatefulWidget {
  final Function onNavigateToActivityScreen;
  final Function onNavigateToBookingScreen;

  const VenueHomeScreen({super.key, required this.onNavigateToActivityScreen, required this.onNavigateToBookingScreen});

  @override
  State<VenueHomeScreen> createState() => _VenueHomeScreenState();
}

class _VenueHomeScreenState extends State<VenueHomeScreen> with AutomaticKeepAliveClientMixin {
  /*  BookingModel bookingModel = BookingModel(
    sportName: "Football",
    groundName: "East side G1",
    timing: "06:00 - 07:00 am",
    bookedBy: "Lucifer morningstar",
    addons: [
      Addon(name: "Ball", price: "1", quantity: "3"),
      Addon(name: "Gloves", price: "3", quantity: "5"),
    ],
  ); */
  int currentIndex = 0;

  final homeController = Get.find<HomeController>();
  final profileController = Get.find<ProfileController>();
  late final VenueManagerController manager;

  @override
  void initState() {
    super.initState();
    manager = Get.put(VenueManagerController());
  }

  @override
  Widget build(BuildContext context) {
    // print("testtt ====>");
    // print("${profileController.venueBookings.value!.bookings!.total}");
    super.build(context);
    var listOfVenueActivities;
    var otherSportsList;
    return Container(
      decoration: Constants.backgroundDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Obx(() {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Stack(
                  children: [
                    CustomScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      slivers: [
                        SliverAppBar(
                          pinned: false,
                          snap: true,
                          leading: const SizedBox(),
                          backgroundColor: CustomTheme.appColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.br))),
                          floating: true,
                          expandedHeight: constraints.maxHeight * 0.5,
                          flexibleSpace: FlexibleSpaceBar(
                              stretchModes: const [StretchMode.fadeTitle],
                              background: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: SizedBox(
                                      height: constraints.maxHeight * 0.12,
                                      child: VenueHomeAppBar(title: profileController.currentVenue.value?.data!.venue.name, subtitle: "${profileController.getTotalBookingsToday()} bookings for today", image: "image"),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Today's bookings",
                                          style: Get.textTheme.labelLarge!.copyWith(color: Colors.white),
                                        ),
                                        IconButtonWidget(
                                          icon: Icons.arrow_forward_rounded,
                                          buttonColor: Colors.white24,
                                          borderColor: Colors.transparent,
                                          iconColor: Colors.white,
                                          onPressed: () {
                                            widget.onNavigateToBookingScreen();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  (profileController.venueBookings.value?.bookings?.data.length ?? 0) < 1
                                      //profileController.venueAnalytics.value!.data.getTotalBookingsToday() < 1
                                      ? EmptyBoxWidget(
                                          height: constraints.maxHeight * 0.28,
                                          width: constraints.maxWidth * 0.85,
                                          isVenue: true,
                                        )
                                      : ExpandableCarousel.builder(
                                          itemCount: profileController.venueBookings.value?.bookings?.data.length,
                                          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) => Center(
                                            child: SizedBox(
                                              height: constraints.maxHeight * 0.30,
                                              width: constraints.maxWidth * 0.88,
                                              child: InkWell(
                                                onTap: () => Get.to(() => VenueBookingDetailsScreen(isLongterm: profileController.venueBookings.value!.bookings!.data[itemIndex].longTermBookingPrice > 0, bookingData: profileController.venueBookings.value!.bookings!.data[itemIndex])),
                                                child: SliderWidget(
                                                  height: constraints.maxHeight * 0.27,
                                                  width: constraints.maxWidth * 0.88,
                                                  bookingModel: profileController.venueBookings.value!.bookings!.data[itemIndex],
                                                ),
                                              ),
                                            ),
                                          ),
                                          options: ExpandableCarouselOptions(
                                            viewportFraction: 1.2,
                                            floatingIndicator: false,
                                          ),
                                        ),
                                ],
                              )),
                        ),
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              // dashboard cards
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: HomePageCard(
                                        title: "Metrics",
                                        data: "${profileController.venueAnalytics.value?.data.totalBooking}",
                                        image: "metrics",
                                        width: constraints.maxWidth * 0.45,
                                        height: constraints.maxWidth * 0.4,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Obx(() {
                                        return HomePageCard(
                                          title: "Earnings",
                                          // data: "OMR ${profileController.venueAnalytics.value?.data.totalEarning ?? 0}",
                                          data: "OMR ${profileController.venueEarnings.value?.data?.totalVenueEarning ?? 0}",
                                          image: "money",
                                          width: constraints.maxWidth * 0.45,
                                          height: constraints.maxWidth * 0.4,
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),

                              // Venue activity
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Venue activities", style: Get.textTheme.displayMedium),
                                    IconButtonWidget(
                                      icon: Icons.arrow_forward_rounded,
                                      onPressed: () {
                                        // Get.to(VenueActivityScreen());
                                        widget.onNavigateToActivityScreen();
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 10.rh),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: SizedBox(
                                  height: 40.rh,
                                  width: double.maxFinite,
                                  child: Obx(() {
                                    var sportsList = profileController.currentVenue.value?.data!.venue.sports?.map((e) => profileController.sportsList.firstWhere((element) => element!.id == e.id)).toList();
                                    if (sportsList!.isNotEmpty) {
                                      listOfVenueActivities = profileController.venueActivities.value?.data?.match.where((element) => element.type == "venue" && element.sport.name == sportsList?[0]?.name).toList().reversed.toList() ?? [];
                                    }

                                    return sportsList.isEmpty
                                        ? Text("No Sports to show")
                                        : ListView.builder(
                                            itemCount: sportsList?.length ?? 0,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return SizedBox(
                                                  height: 30.rh,
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                    child: FilterSelectionChip(
                                                      onPressed: () {
                                                        manager.selectedSportForVenueActivityIndex.value = index;
                                                        manager.selectedSportForVenueActivityIndex.refresh();
                                                        listOfVenueActivities = profileController.venueActivities.value?.data?.match.where((element) => element.type == "venue" && element.sport.name == sportsList[manager.selectedSportForVenueActivityIndex.value]!.name).toList() ?? [];
                                                      },
                                                      sportModel: sportsList![index]!,
                                                      radius: 35.br,
                                                      index: index,
                                                      isVenueActivity: true,
                                                      selectedIndex: manager.selectedSportForVenueActivityIndex.value,
                                                    ),
                                                  ));
                                            },
                                          );
                                  }),
                                ),
                              ),
                              SizedBox(height: 10.rh),

                              SizedBox(
                                height: constraints.maxHeight * 0.3,
                                child: Obx(() {
                                  if (manager.selectedSportForVenueActivityIndex.value == 0) {
                                    listOfVenueActivities = listOfVenueActivities;
                                  }
                                  return listOfVenueActivities == null || listOfVenueActivities.isEmpty
                                      ? Center(
                                          child: Text(
                                            "No activities found",
                                            style: Get.textTheme.headlineSmall!.copyWith(color: CustomTheme.appColor),
                                          ),
                                        )
                                      : ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: listOfVenueActivities.length,
                                          padding: const EdgeInsets.only(left: 16.0),
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(right: 16.0),
                                              child: ActivityCardWidget(
                                                height: constraints.maxHeight * 0.33,
                                                width: constraints.maxWidth * 0.9,
                                                fromActivity: false,
                                                onPressed: () {},
                                                activityModel: listOfVenueActivities[index],
                                              ),
                                            );
                                          });
                                }),
                              ),
                              SizedBox(height: 20.rh),

                              // Other Activities
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Other activities", style: Get.textTheme.displayMedium),
                                    IconButtonWidget(
                                      icon: Icons.arrow_forward_rounded,
                                      onPressed: () {
                                        // Get.to(VenueActivityScreen());
                                        widget.onNavigateToActivityScreen();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.rh),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: SizedBox(
                                  height: 40.rh,
                                  width: double.maxFinite,
                                  child: Obx(() {
                                    otherSportsList = profileController.currentVenue.value?.data?.venue.sports?.map((e) => profileController.sportsList.firstWhere((element) => element!.id == e.id)).toList();
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: otherSportsList?.length ?? 0,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return SizedBox(
                                            height: 40.rh,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: FilterSelectionChip(
                                                sportModel: otherSportsList![index]!,
                                                radius: 35.br,
                                                index: index,
                                                isVenueActivity: false,
                                                selectedIndex: manager.selectedSportForOtherActivityIndex.value,
                                              ),
                                            ));
                                      },
                                    );
                                  }),
                                ),
                              ),
                              SizedBox(height: 10.rh),
                              SizedBox(
                                height: constraints.maxHeight * 0.25,
                                child: Obx(() {
                                  final listOfOtherActivities = profileController.otherVenueActivities.value?.data?.match ?? [];

                                  return listOfOtherActivities.isEmpty
                                      ? Center(
                                          child: Text(
                                            "No activities found",
                                            style: Get.textTheme.headlineSmall!.copyWith(color: CustomTheme.appColor),
                                          ),
                                        )
                                      : ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: listOfOtherActivities.length,
                                          padding: const EdgeInsets.only(left: 16.0),
                                          itemBuilder: (context, index) {
                                            return ActivityCardWidget(
                                              height: constraints.maxHeight * 0.2,
                                              width: constraints.maxWidth * 0.9,
                                              fromActivity: false,
                                              onPressed: () {},
                                              activityModel: listOfOtherActivities[index],
                                            );
                                          });
                                }),
                              ),

                              SizedBox(height: 20.rh),
                              // Reviews
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Reviews", style: Get.textTheme.displayMedium),
                                    IconButtonWidget(
                                      icon: Icons.arrow_forward_rounded,
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
                                child: SizedBox(
                                  height: constraints.maxHeight * 0.25,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: profileController.venueReviews.value?.data?.review?.data.length ?? 0,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        final ratingModel = profileController.venueReviews.value?.data?.review?.data[index];
                                        return Padding(
                                          padding: const EdgeInsets.only(right: 16.0),
                                          child: SizedBox(
                                            width: constraints.maxWidth * 0.78,
                                            child: VenueReviewWidget(
                                              image: ratingModel!.profilePicture,
                                              name: ratingModel.name,
                                              ratingCount: ratingModel.rating,
                                              review: ratingModel.comment,
                                              time: ratingModel.date,
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                              SizedBox(height: 5.rh),
                            ],
                          ),
                        )
                      ],
                    ),
                    profileController.loading.value
                        ? Container(
                            color: Colors.white54,
                            height: Get.height * .45,
                            child: Center(child: CircularProgressIndicator(color: CustomTheme.appColor)),
                          )
                        : const SizedBox()
                  ],
                ),
              );
            });
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
