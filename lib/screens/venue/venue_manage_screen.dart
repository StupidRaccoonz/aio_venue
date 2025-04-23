import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/models/success_response_model.dart';
import 'package:aio_sport/screens/venue/venue_details.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/app_bar_widget.dart';
import 'package:aio_sport/widgets/manage_venue_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

class VenuemanageScreen extends StatefulWidget {
  const VenuemanageScreen({super.key});

  @override
  State<VenuemanageScreen> createState() => _VenuemanageScreenState();
}

class _VenuemanageScreenState extends State<VenuemanageScreen>
    with SingleTickerProviderStateMixin {
  final profile = Get.find<ProfileController>();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.maxFinite, 10.vh),
          child: AppbarWidget(
            title: "Manage Venues",
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                onPressed: () => Get.back()),
            actionIcon: IconButton(
              onPressed: () =>
                  Get.to(() => const VenueDetails(addAnotherVenue: true)),
              padding: const EdgeInsets.all(16),
              icon: const Icon(Icons.add),
              color: Colors.white,
            ),
          )),
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            Column(
              children: [
                TabBar(
                  controller: _tabController,
                  isScrollable: false,
                  indicatorColor: Colors.blue,
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(text: 'My Venue'),
                    Tab(text: 'Remove venue'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // First Tab
                      profile.myVenues.value == null
                          ? ManageVenueWidget(
                              imageUrl: profile.currentVenue.value?.data?.venue
                                      .profilePicture ??
                                  "",
                              onDelete: () {},
                              venueCity: profile
                                  .currentVenue.value!.data!.venue.address,
                              venueName:
                                  profile.currentVenue.value!.data!.venue.name,
                              index: 0,
                            )
                          : Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: ListView.builder(
                                itemCount:
                                    profile.myVenues.value?.data?.venue.length,
                                itemBuilder: (context, index) {
                                  final model = profile
                                      .myVenues.value!.data!.venue[index];
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ManageVenueWidget(
                                        imageUrl: model.profilePicture ?? "n/a",
                                        onDelete: () async {
                                          if (profile.venueId! == model.id) {
                                            return;
                                          }
                                          SuccessResponseModel? response =
                                              await profile.venueService
                                                  .deleteVenue(profile.bearer,
                                                      "${model.id}");
                                          if (response != null) {
                                            Constants.showSnackbar(
                                                "Result", response.message);
                                            if (response.httpCode == 200) {
                                              profile
                                                  .myVenues.value!.data!.venue
                                                  .removeWhere((element) =>
                                                      element.id == model.id);
                                              profile.myVenues.refresh();
                                            }
                                          }
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
                            ),
                      // Second Tab
                      profile.myVenues.value == null
                          ? ManageVenueWidget(
                              imageUrl: profile.currentVenue.value?.data?.venue
                                      .profilePicture ??
                                  "",
                              onDelete: () {},
                              venueCity: profile
                                  .currentVenue.value!.data!.venue.address,
                              venueName:
                                  profile.currentVenue.value!.data!.venue.name,
                              index: 0,
                            )
                          : Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: ListView.builder(
                                itemCount:
                                    profile.myVenues.value?.data?.venue.length,
                                itemBuilder: (context, index) {
                                  final model = profile
                                      .myVenues.value!.data!.venue[index];
                                  return Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                child: Icon(
                                                  Icons.image,
                                                  size: 50,
                                                )),
                                            const SizedBox(width: 16.0),
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  model.name,
                                                  style: Get
                                                      .textTheme.labelSmall!
                                                      .copyWith(
                                                          color: CustomTheme
                                                              .appColor),
                                                ),
                                                Text(
                                                  model.address,
                                                  style: Get
                                                      .textTheme.displaySmall,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return SimpleDialog(
                                                      title: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          children: [
                                                            Image.asset(
                                                              'assets/icons/refresh.png',
                                                              height: 80,
                                                              width: 80,
                                                            ),
                                                            SizedBox(
                                                                height: 15),
                                                            Text(
                                                              "Recover Venue",
                                                              style: TextStyle(
                                                                  fontSize: 30,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                                height: 10),
                                                            Text(
                                                              "Venue will go live and will be available for booking",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                            SizedBox(
                                                                height: 10),
                                                            InkWell(
                                                              onTap: () {
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return SimpleDialog(
                                                                      title:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Image.asset(
                                                                              'assets/icons/Group.png',
                                                                              height: 80,
                                                                              width: 80,
                                                                            ),
                                                                            SizedBox(height: 15),
                                                                            Text(
                                                                              "Venue Recovered Successfully",
                                                                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            SizedBox(height: 10),
                                                                            Text(
                                                                              "Your venue is live and available for booking",
                                                                              style: TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold),
                                                                              textAlign: TextAlign.center,
                                                                            ),
                                                                            SizedBox(height: 10),
                                                                            GestureDetector(
                                                                              onTap: () => Navigator.pop(context),
                                                                              child: Container(
                                                                                height: MediaQuery.of(context).size.height * 0.06,
                                                                                width: MediaQuery.of(context).size.width * 1,
                                                                                decoration: BoxDecoration(
                                                                                  color: Colors.orange,
                                                                                  borderRadius: BorderRadius.circular(50),
                                                                                ),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    "Switch to Venue",
                                                                                    style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(height: 20),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(),
                                                                              child: TextButton(
                                                                                onPressed: () {
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                child: Text(
                                                                                  'Not now',
                                                                                  style: TextStyle(color: Colors.orange, fontSize: 25, fontWeight: FontWeight.bold),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              child: Container(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.06,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    1,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .orange,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50),
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    "Recover venue",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            25,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 20),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(),
                                                              child: TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                  'Not now',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .orange,
                                                                      fontSize:
                                                                          25,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              icon: Icon(
                                                  Icons
                                                      .replay_circle_filled_rounded,
                                                  color: CustomTheme.appColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Divider(height: 4.0),
                                    ],
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                ),
                // profile.myVenues.value == null
                //     ? ManageVenueWidget(
                //         imageUrl: profile.currentVenue.value?.data?.venue.profilePicture ?? "",
                //         // onDelete: () {},
                //         venueCity: profile.currentVenue.value!.data!.venue.address,
                //         venueName: profile.currentVenue.value!.data!.venue.name,
                //         index: 0,
                //       )
                //     : Expanded(
                //         child: ListView.builder(
                //           itemCount: profile.myVenues.value?.data?.venue.length,
                //           itemBuilder: (context, index) {
                //             final model = profile.myVenues.value!.data!.venue[index];
                //             return Column(
                //               mainAxisSize: MainAxisSize.min,
                //               children: [
                //                 ManageVenueWidget(
                //                   imageUrl: model.profilePicture ?? "n/a",
                //                   // onDelete: () async {
                //                   //   if (profile.venueId! == model.id) {
                //                   //     return;
                //                   //   }
                //                   //   SuccessResponseModel? response = await profile.venueService.deleteVenue(profile.bearer, "${model.id}");
                //                   //   if (response != null) {
                //                   //     Constants.showSnackbar("Result", response.message);
                //                   //     if (response.httpCode == 200) {
                //                   //       profile.myVenues.value!.data!.venue.removeWhere((element) => element.id == model.id);
                //                   //       profile.myVenues.refresh();
                //                   //     }
                //                   //   }
                //                   // },
                //                   venueCity: model.address,
                //                   venueName: model.name,
                //                   index: index,
                //                 ),
                //                 const Divider(height: 4.0),
                //               ],
                //             );
                //           },
                //         ),
                //       )
              ],
            ),
            Obx(() {
              return profile.loading.value
                  ? Container(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                      color: Colors.white54,
                      child: Center(
                          child: CircularProgressIndicator(
                              color: CustomTheme.appColor)),
                    )
                  : const SizedBox();
            })
          ],
        );
      }),
    );
  }
}
