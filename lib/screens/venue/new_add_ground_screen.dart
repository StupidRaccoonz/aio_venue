import 'dart:developer';

import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/models/add_ground_req_model.dart' as req;
import 'package:aio_sport/models/add_ground_req_model.dart';
import 'package:aio_sport/models/form_info.dart';
import 'package:aio_sport/models/venue_details_model.dart';
import 'package:aio_sport/models/sports_data_model.dart' as sport;
import 'package:aio_sport/screens/authentication/wrapper.dart';
import 'package:aio_sport/services/server_urls.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/add_ground_form.dart';
import 'package:aio_sport/widgets/addon_form_widget.dart';
import 'package:aio_sport/widgets/image_widget.dart';
import 'package:aio_sport/widgets/my_button.dart';
import 'package:aio_sport/widgets/select_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

import '../common/congratulation_screen.dart';
import 'facilities_screen.dart';
// import 'venue_main_page.dart';

class NewAddGroundScreen extends StatefulWidget {
  final String? venueId;

  const NewAddGroundScreen({super.key, this.venueId});

  @override
  State<NewAddGroundScreen> createState() => _NewAddGroundScreenState();
}

class _NewAddGroundScreenState extends State<NewAddGroundScreen>
    with TickerProviderStateMixin {
  final profile = Get.find<ProfileController>();
  RxList<sport.Sport> sports = <sport.Sport>[].obs;
  Rx<int> selectedSport = 0.obs;
  late TabController tabController;
  RxList<req.Ground> groundsMainForms = <req.Ground>[].obs;
  RxList<Map<String, dynamic>> formsMapDataList = <Map<String, dynamic>>[].obs;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (profile.currentVenue.value != null && profile.sportsList.isNotEmpty) {
        for (Sport element1
            in profile.currentVenue.value!.data!.venue.sports!) {
          sports.add(profile.sportsList
              .firstWhere((element) => element!.id == element1.id)!);
        }
        sports.refresh();
        tabController = TabController(
            length: profile.currentVenue.value!.data!.venue.sports!.length,
            vsync: this);
        setState(() {});
      } else {
        tabController = TabController(length: 0, vsync: this);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                      sliver: SliverAppBar(
                        automaticallyImplyLeading: false,
                        pinned: false,
                        snap: false,
                        backgroundColor: Colors.transparent,
                        floating: true,
                        expandedHeight: constraints.maxHeight * 0.112,
                        flexibleSpace: FlexibleSpaceBar(
                          stretchModes: const [StretchMode.fadeTitle],
                          centerTitle: true,
                          collapseMode: CollapseMode.parallax,
                          background: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  child: IconButton(
                                      onPressed: () =>
                                          Get.to(() => FacilitiesScreen()),
                                      icon: Icon(Icons.arrow_back_rounded,
                                          color: CustomTheme.appColor)),
                                ),
                                SizedBox(height: 3.0.rh),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text("Add Grounds",
                                      style: Get.textTheme.titleLarge),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    "Let us know how many grounds you have for each sport",
                                    style: Get.textTheme.displaySmall,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ];
                },
                body: Stack(
                  children: [
                    SizedBox(
                      height: constraints.maxHeight,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: constraints.maxHeight * 0.15,
                            right: 16,
                            left: 16),
                        child: TabBarView(
                            controller: tabController,
                            physics: const NeverScrollableScrollPhysics(
                                parent: ClampingScrollPhysics()),
                            children: sports.map(
                              (element) {
                                Rx<bool> expanded = false.obs;
                                Rx<bool> expandedAddon = false.obs;
                                RxList<int> numberOfGrounds = [1].obs;
                                RxList<int> numberOfAddons = [1].obs;
                                RxList<req.AddOn> addonFormsData = <req.AddOn>[
                                  req.AddOn(
                                      itemName: "", quality: "", rentPrice: "")
                                ].obs;
                                RxList<FormInfo> groundFormsData = <FormInfo>[
                                  FormInfo(
                                    groundName: "",
                                    groundSize: element.sportsizes.isNotEmpty
                                        ? element.sportsizes.first.size
                                        : "",
                                    groundUnits: "",
                                    hourlyRent: "",
                                    isIndoor: true,
                                    sportId: element.id,
                                    morningTiming: [],
                                    eveningTiming: [],
                                    // addOn: [],
                                  )
                                ].obs;

                                if (formsMapDataList.length < sports.length) {
                                  formsMapDataList.add({
                                    "sport": element.name,
                                    "list": groundFormsData
                                        .map((element) => req.Ground.fromJson(
                                            element.toJson()))
                                        .toList(),
                                    "addons": addonFormsData,
                                  });
                                  log("updated maps ${formsMapDataList.join(",")}");
                                }

                                return Obx(() {
                                  return SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //for grounds form list
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: CustomTheme.borderColor,
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 4.0),
                                            child: ExpansionPanelList(
                                              elevation: 0.0,
                                              expandedHeaderPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4.0),
                                              expansionCallback:
                                                  (panelIndex, isExpanded) =>
                                                      expanded.value =
                                                          !expanded.value,
                                              children: [
                                                ExpansionPanel(
                                                    canTapOnHeader: true,
                                                    backgroundColor:
                                                        Colors.white,
                                                    isExpanded: expanded.value,
                                                    headerBuilder:
                                                        (context, isExpanded) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                                "Ground Details (${numberOfGrounds.length})",
                                                                style: Get
                                                                    .textTheme
                                                                    .titleSmall!
                                                                    .copyWith(
                                                                        color: CustomTheme
                                                                            .appColor)),
                                                            const Spacer(),
                                                            InkWell(
                                                                onTap: () {
                                                                  numberOfGrounds.add(
                                                                      numberOfGrounds
                                                                          .length);
                                                                  groundFormsData
                                                                      .add(
                                                                          FormInfo(
                                                                    groundName:
                                                                        "",
                                                                    groundSize: element
                                                                        .sportsizes
                                                                        .first
                                                                        .size,
                                                                    groundUnits:
                                                                        "",
                                                                    hourlyRent:
                                                                        "",
                                                                    isIndoor:
                                                                        true,
                                                                    sportId:
                                                                        element
                                                                            .id,
                                                                    morningTiming: [],
                                                                    eveningTiming: [],
                                                                    // addOn: [],
                                                                  ));
                                                                  setState(
                                                                      () {});
                                                                  // addnewGround(sportName: element.name, formInfo: groundFormsData.last);
                                                                },
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          16.0),
                                                                  child: Text(
                                                                    "+ Add more",
                                                                    style: Get
                                                                        .textTheme
                                                                        .displaySmall!
                                                                        .copyWith(
                                                                            color:
                                                                                CustomTheme.iconColor),
                                                                  ),
                                                                )),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    body: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Divider(
                                                            color: CustomTheme
                                                                .borderColor,
                                                            thickness: 2.0),
                                                        SizedBox(
                                                          height: numberOfGrounds
                                                                  .length *
                                                              constraints
                                                                  .maxHeight *
                                                              0.48,
                                                          child:
                                                              ListView.builder(
                                                            itemCount:
                                                                numberOfGrounds
                                                                    .length,
                                                            addAutomaticKeepAlives:
                                                                true,
                                                            physics:
                                                                const NeverScrollableScrollPhysics(),
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            16.0),
                                                                    child:
                                                                        ListTile(
                                                                      title: Text(
                                                                          "Ground ${index + 1}",
                                                                          style: Get
                                                                              .textTheme
                                                                              .headlineMedium),
                                                                      tileColor:
                                                                          CustomTheme
                                                                              .borderColor,
                                                                      trailing: InkWell(
                                                                          onTap: () {
                                                                            if (numberOfGrounds.length >
                                                                                1) {
                                                                              numberOfGrounds.removeAt(index);
                                                                              numberOfGrounds.refresh();
                                                                              groundFormsData.removeAt(index);
                                                                              groundFormsData.refresh();
                                                                              removeGround(index, element.name);
                                                                            }
                                                                          },
                                                                          child: const Icon(Icons.close, size: 32.0)),
                                                                    ),
                                                                  ),
                                                                  AddGroundForm(
                                                                    sport: profile
                                                                        .sportsList
                                                                        .firstWhere((e) =>
                                                                            e!.id ==
                                                                            element.id)!,
                                                                    formInfo:
                                                                        (FormInfo
                                                                            value) {
                                                                      groundFormsData[
                                                                              index] =
                                                                          value;
                                                                      updateFormData(
                                                                          sportName: element
                                                                              .name,
                                                                          formInfo:
                                                                              value,
                                                                          index:
                                                                              index);
                                                                    },
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 24.0),

                                        //for addons form list
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      CustomTheme.borderColor,
                                                  width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                              color: Colors.white),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 4.0),
                                            child: ExpansionPanelList(
                                              elevation: 0.0,
                                              expandedHeaderPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4.0),
                                              expansionCallback:
                                                  (panelIndex, isExpanded) =>
                                                      expandedAddon.value =
                                                          !expandedAddon.value,
                                              children: [
                                                ExpansionPanel(
                                                    canTapOnHeader: true,
                                                    isExpanded:
                                                        expandedAddon.value,
                                                    backgroundColor:
                                                        Colors.white,
                                                    headerBuilder:
                                                        (context, isExpanded) {
                                                      return ListTile(
                                                        title: Row(
                                                          children: [
                                                            Text(
                                                                "Add ons (${numberOfAddons.length})",
                                                                style: Get
                                                                    .textTheme
                                                                    .titleSmall!
                                                                    .copyWith(
                                                                        color: CustomTheme
                                                                            .appColor)),
                                                            const Spacer(),
                                                            InkWell(
                                                                onTap: () {
                                                                  addonFormsData.add(req.AddOn(
                                                                      itemName:
                                                                          "",
                                                                      quality:
                                                                          "",
                                                                      rentPrice:
                                                                          ""));
                                                                  numberOfAddons.add(
                                                                      numberOfAddons
                                                                          .length);
                                                                  addAddonsToAllGrounds(
                                                                      addons:
                                                                          addonFormsData,
                                                                      sportName:
                                                                          element
                                                                              .name);
                                                                },
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          16.0),
                                                                  child: Text(
                                                                      "+ Add more",
                                                                      style: Get
                                                                          .textTheme
                                                                          .displaySmall!
                                                                          .copyWith(
                                                                              color: CustomTheme.iconColor)),
                                                                )),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    body: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Divider(
                                                            color: CustomTheme
                                                                .borderColor,
                                                            thickness: 2.0),
                                                        SizedBox(
                                                          height: numberOfAddons
                                                                  .length *
                                                              constraints
                                                                  .maxHeight *
                                                              0.27,
                                                          child:
                                                              ListView.builder(
                                                            itemCount:
                                                                numberOfAddons
                                                                    .length,
                                                            addAutomaticKeepAlives:
                                                                true,
                                                            physics:
                                                                const NeverScrollableScrollPhysics(),
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            16.0),
                                                                    child:
                                                                        ListTile(
                                                                      title: Text(
                                                                          "Item ${index + 1}",
                                                                          style: Get
                                                                              .textTheme
                                                                              .headlineMedium),
                                                                      tileColor:
                                                                          CustomTheme
                                                                              .borderColor,
                                                                      trailing: InkWell(
                                                                          onTap: () {
                                                                            numberOfAddons.removeAt(index);
                                                                            numberOfAddons.refresh();
                                                                            addonFormsData.removeAt(index);
                                                                            addAddonsToAllGrounds(
                                                                                addons: addonFormsData,
                                                                                sportName: element.name);
                                                                          },
                                                                          child: const Icon(Icons.close, size: 32.0)),
                                                                    ),
                                                                  ),
                                                                  AddonFormWidget(
                                                                    index:
                                                                        index,
                                                                    addonData: (value) => updateAddonData(
                                                                        sportName:
                                                                            element
                                                                                .name,
                                                                        addon:
                                                                            value,
                                                                        index:
                                                                            index),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 16.0),
                                        // time selection
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Ground availability",
                                              style:
                                                  Get.textTheme.displayMedium),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Ante meridiem (AM)",
                                              style:
                                                  Get.textTheme.displaySmall),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            height: 25.rfs * 6,
                                            child: SelectTimeWidget(
                                              itemCount: 6,
                                              startingIndexValue: 6,
                                              removingZeroAtIndex: 4,
                                              callback: (List<String> val) {
                                                log("morning selected time $val");
                                                for (FormInfo element
                                                    in groundFormsData) {
                                                  element.morningTiming = val;
                                                }

                                                addAvailabilityTimigs(
                                                    isMorning: true,
                                                    sportName: element.name,
                                                    timings: val);
                                                // profile.addGroundFormsList[profile.addGroundFormSelectedGround.value].value.morningTiming = val;
                                              },
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Post meridiem (PM)",
                                              style:
                                                  Get.textTheme.displaySmall),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                              height: 25.rfs * 8,
                                              child: SelectTimeWidget(
                                                itemCount: 10,
                                                startingIndexValue: 0,
                                                removingZeroAtIndex: 5,
                                                callback: (List<String> val) {
                                                  log("evening selected time $val");
                                                  for (FormInfo element
                                                      in groundFormsData) {
                                                    element.eveningTiming = val;
                                                  }
                                                  addAvailabilityTimigs(
                                                      isMorning: false,
                                                      sportName: element.name,
                                                      timings: val);
                                                },
                                              )),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "We have selected ground availability automatically as per your opening and closing time you can modify them as per your liking.",
                                            style: Get.textTheme.displaySmall,
                                          ),
                                        ),

                                        SizedBox(
                                            height:
                                                constraints.maxHeight * 0.25),
                                      ],
                                    ),
                                  );
                                });
                              },
                            ).toList()),
                      ),
                    ),
                    // Floating Sports listview
                    Positioned(
                      top: 16.0,
                      right: 20.0,
                      left: 20.0,
                      child: Material(
                        color: Colors.white,
                        child: Stack(
                          children: [
                            sports.length > 1
                                ? Positioned(
                                    top: constraints.maxHeight * 0.04,
                                    left: 20,
                                    child: Container(
                                        color: CustomTheme.appColor,
                                        height: 2.0,
                                        width: sports.length * 60),
                                  )
                                : const SizedBox(),
                            SizedBox(
                              height: constraints.maxHeight * 0.12,
                              child: ListView.builder(
                                itemCount: sports.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Obx(() {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, right: 16.0),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            selectedSport.value = index;
                                            tabController.animateTo(index);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Center(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: selectedSport
                                                                        .value ==
                                                                    index
                                                                ? CustomTheme
                                                                    .iconColor
                                                                : CustomTheme
                                                                    .borderColor,
                                                            width: 1.0),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    30.0)),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2.0),
                                                        child: ImageWidget(
                                                            imageurl:
                                                                "${ServerUrls.mediaUrl}sports/${sports[index].image}",
                                                            radius: 25.0,
                                                            width: 45,
                                                            height: 45,
                                                            fit: BoxFit.fill)),
                                                  ),
                                                ),
                                                const SizedBox(height: 4.0),
                                                Text(sports[index].name,
                                                    style: Get
                                                        .textTheme.bodySmall!
                                                        .copyWith(
                                                            color: selectedSport
                                                                        .value ==
                                                                    index
                                                                ? CustomTheme
                                                                    .textColor
                                                                : CustomTheme
                                                                    .textColorLight)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Obx(() => profile.loading.value
                        ? Container(
                            width: constraints.maxWidth,
                            height: constraints.maxHeight,
                            color: Colors.white54,
                            child: Center(
                                child: CircularProgressIndicator(
                                    color: CustomTheme.appColor)),
                          )
                        : const SizedBox())
                  ],
                ),
              )),
          // child: NestedScrollView(
          //   headerSliverBuilder: (context, innerBoxIsScrolled) {
          //     return [
          //       SliverOverlapAbsorber(
          //         handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
          //             context),
          //         sliver: SliverAppBar(
          //           automaticallyImplyLeading: false,
          //           pinned: false,
          //           snap: false,
          //           backgroundColor: Colors.transparent,
          //           floating: true,
          //           expandedHeight: constraints.maxHeight * 0.112,
          //           flexibleSpace: FlexibleSpaceBar(
          //             stretchModes: const [StretchMode.fadeTitle],
          //             centerTitle: true,
          //             collapseMode: CollapseMode.parallax,
          //             background: Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 mainAxisSize: MainAxisSize.min,
          //                 children: [
          //                   Padding(
          //                     padding: const EdgeInsets.symmetric(
          //                         horizontal: 2.0),
          //                     child: IconButton(
          //                         onPressed: () =>
          //                             Get.to(() => FacilitiesScreen()),
          //                         icon: Icon(Icons.arrow_back_rounded,
          //                             color: CustomTheme.appColor)),
          //                   ),
          //                   SizedBox(height: 3.0.rh),
          //                   Padding(
          //                     padding: const EdgeInsets.symmetric(
          //                         horizontal: 10.0),
          //                     child: Text("Add Grounds",
          //                         style: Get.textTheme.titleLarge),
          //                   ),
          //                   Padding(
          //                     padding: const EdgeInsets.symmetric(
          //                         horizontal: 10.0),
          //                     child: Text(
          //                       "Let us know how many grounds you have for each sport",
          //                       style: Get.textTheme.displaySmall,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ];
          //   },
          //   body: Stack(
          //     children: [
          //       SizedBox(
          //         height: constraints.maxHeight,
          //         child: Padding(
          //           padding: EdgeInsets.only(
          //               top: constraints.maxHeight * 0.15,
          //               right: 16,
          //               left: 16),
          //           child: TabBarView(
          //               controller: tabController,
          //               physics: const NeverScrollableScrollPhysics(
          //                   parent: ClampingScrollPhysics()),
          //               children: sports.map(
          //                 (element) {
          //                   Rx<bool> expanded = false.obs;
          //                   Rx<bool> expandedAddon = false.obs;
          //                   RxList<int> numberOfGrounds = [1].obs;
          //                   RxList<int> numberOfAddons = [1].obs;
          //                   RxList<req.AddOn> addonFormsData = <req.AddOn>[
          //                     req.AddOn(
          //                         itemName: "", quality: "", rentPrice: "")
          //                   ].obs;
          //                   RxList<FormInfo> groundFormsData = <FormInfo>[
          //                     FormInfo(
          //                       groundName: "",
          //                       groundSize: element.sportsizes.first.size,
          //                       groundUnits: "",
          //                       hourlyRent: "",
          //                       isIndoor: true,
          //                       sportId: element.id,
          //                       morningTiming: [],
          //                       eveningTiming: [],
          //                     )
          //                   ].obs;
          //
          //                   if (formsMapDataList.length < sports.length) {
          //                     formsMapDataList.add({
          //                       "sport": element.name,
          //                       "list": groundFormsData
          //                           .map((element) => req.Ground.fromJson(
          //                               element.toJson()))
          //                           .toList(),
          //                       "addons": addonFormsData,
          //                     });
          //                     log("updated maps ${formsMapDataList.join(",")}");
          //                   }
          //
          //                   return Obx(() {
          //                     return SingleChildScrollView(
          //                       child: Column(
          //                         crossAxisAlignment:
          //                             CrossAxisAlignment.start,
          //                         children: [
          //                           //for grounds form list
          //                           Container(
          //                             decoration: BoxDecoration(
          //                               color: Colors.white,
          //                               border: Border.all(
          //                                   color: CustomTheme.borderColor,
          //                                   width: 1.5),
          //                               borderRadius:
          //                                   BorderRadius.circular(24.0),
          //                             ),
          //                             child: Padding(
          //                               padding: const EdgeInsets.symmetric(
          //                                   horizontal: 8.0, vertical: 4.0),
          //                               child: ExpansionPanelList(
          //                                 elevation: 0.0,
          //                                 expandedHeaderPadding:
          //                                     const EdgeInsets.symmetric(
          //                                         vertical: 4.0),
          //                                 expansionCallback:
          //                                     (panelIndex, isExpanded) =>
          //                                         expanded.value =
          //                                             !expanded.value,
          //                                 children: [
          //                                   ExpansionPanel(
          //                                     canTapOnHeader: true,
          //                                     backgroundColor: Colors.white,
          //                                     isExpanded: expanded.value,
          //                                     headerBuilder:
          //                                         (context, isExpanded) {
          //                                       return Padding(
          //                                         padding:
          //                                             const EdgeInsets.all(
          //                                                 8.0),
          //                                         child: Row(
          //                                           children: [
          //                                             Text(
          //                                                 "Ground Details (${numberOfGrounds.length})",
          //                                                 style: Get
          //                                                     .textTheme
          //                                                     .titleSmall!
          //                                                     .copyWith(
          //                                                         color: CustomTheme
          //                                                             .appColor)),
          //                                             const Spacer(),
          //                                             InkWell(
          //                                                 onTap: () {
          //                                                   numberOfGrounds.add(
          //                                                       numberOfGrounds
          //                                                           .length);
          //                                                   groundFormsData
          //                                                       .add(
          //                                                           FormInfo(
          //                                                     groundName:
          //                                                         "",
          //                                                     groundSize:
          //                                                         element
          //                                                             .sportsizes
          //                                                             .first
          //                                                             .size,
          //                                                     groundUnits:
          //                                                         "",
          //                                                     hourlyRent:
          //                                                         "",
          //                                                     isIndoor:
          //                                                         true,
          //                                                     sportId:
          //                                                         element
          //                                                             .id,
          //                                                     morningTiming: [],
          //                                                     eveningTiming: [],
          //                                                   ));
          //                                                   addnewGround(
          //                                                       sportName:
          //                                                           element
          //                                                               .name,
          //                                                       formInfo:
          //                                                           groundFormsData
          //                                                               .last);
          //                                                 },
          //                                                 child: Padding(
          //                                                   padding: const EdgeInsets
          //                                                       .symmetric(
          //                                                       vertical:
          //                                                           16.0),
          //                                                   child: Text(
          //                                                     "+ Add more",
          //                                                     style: Get
          //                                                         .textTheme
          //                                                         .displaySmall!
          //                                                         .copyWith(
          //                                                             color:
          //                                                                 CustomTheme.iconColor),
          //                                                   ),
          //                                                 )),
          //                                           ],
          //                                         ),
          //                                       );
          //                                     },
          //                                     body: Column(
          //                                       mainAxisSize:
          //                                           MainAxisSize.min,
          //                                       children: [
          //                                         Divider(
          //                                             color: CustomTheme
          //                                                 .borderColor,
          //                                             thickness: 2.0),
          //                                         SizedBox(
          //                                           height: numberOfGrounds
          //                                                   .length *
          //                                               constraints
          //                                                   .maxHeight *
          //                                               0.48,
          //                                           child: ListView.builder(
          //                                             itemCount:
          //                                                 numberOfGrounds
          //                                                     .length,
          //                                             addAutomaticKeepAlives:
          //                                                 true,
          //                                             physics:
          //                                                 const NeverScrollableScrollPhysics(),
          //                                             itemBuilder:
          //                                                 (context, index) {
          //                                               return Column(
          //                                                 mainAxisSize:
          //                                                     MainAxisSize
          //                                                         .min,
          //                                                 children: [
          //                                                   Padding(
          //                                                     padding: const EdgeInsets
          //                                                         .symmetric(
          //                                                         horizontal:
          //                                                             16.0),
          //                                                     child:
          //                                                         ListTile(
          //                                                       title: Text(
          //                                                           "Ground ${index + 1}",
          //                                                           style: Get
          //                                                               .textTheme
          //                                                               .headlineMedium),
          //                                                       tileColor:
          //                                                           CustomTheme
          //                                                               .borderColor,
          //                                                       trailing: InkWell(
          //                                                           onTap: () {
          //                                                             if (numberOfGrounds.length >
          //                                                                 1) {
          //                                                               numberOfGrounds.removeAt(index);
          //                                                               numberOfGrounds.refresh();
          //                                                               groundFormsData.removeAt(index);
          //                                                               groundFormsData.refresh();
          //                                                               removeGround(index,
          //                                                                   element.name);
          //                                                             }
          //                                                           },
          //                                                           child: const Icon(Icons.close, size: 32.0)),
          //                                                     ),
          //                                                   ),
          //                                                   AddGroundForm(
          //                                                     sport: profile
          //                                                         .sportsList
          //                                                         .firstWhere((e) =>
          //                                                             e!.id ==
          //                                                             element
          //                                                                 .id)!,
          //                                                     formInfo:
          //                                                         (FormInfo
          //                                                             value) {
          //                                                       groundFormsData[
          //                                                               index] =
          //                                                           value;
          //                                                       updateFormData(
          //                                                           sportName:
          //                                                               element
          //                                                                   .name,
          //                                                           formInfo:
          //                                                               value,
          //                                                           index:
          //                                                               index);
          //                                                     },
          //                                                   ),
          //                                                 ],
          //                                               );
          //                                             },
          //                                           ),
          //                                         ),
          //                                       ],
          //                                     ),
          //                                   ),
          //                                 ],
          //                               ),
          //                             ),
          //                           ),
          //
          //                           const SizedBox(height: 24.0),
          //
          //                           //for addons form list
          //                           Container(
          //                             decoration: BoxDecoration(
          //                                 border: Border.all(
          //                                     color:
          //                                         CustomTheme.borderColor,
          //                                     width: 1.5),
          //                                 borderRadius:
          //                                     BorderRadius.circular(24.0),
          //                                 color: Colors.white),
          //                             child: Padding(
          //                               padding: const EdgeInsets.symmetric(
          //                                   horizontal: 8.0, vertical: 4.0),
          //                               child: ExpansionPanelList(
          //                                 elevation: 0.0,
          //                                 expandedHeaderPadding:
          //                                     const EdgeInsets.symmetric(
          //                                         vertical: 4.0),
          //                                 expansionCallback:
          //                                     (panelIndex, isExpanded) =>
          //                                         expandedAddon.value =
          //                                             !expandedAddon.value,
          //                                 children: [
          //                                   ExpansionPanel(
          //                                       canTapOnHeader: true,
          //                                       isExpanded:
          //                                           expandedAddon.value,
          //                                       backgroundColor:
          //                                           Colors.white,
          //                                       headerBuilder:
          //                                           (context, isExpanded) {
          //                                         return ListTile(
          //                                           title: Row(
          //                                             children: [
          //                                               Text(
          //                                                   "Add ons (${numberOfAddons.length})",
          //                                                   style: Get
          //                                                       .textTheme
          //                                                       .titleSmall!
          //                                                       .copyWith(
          //                                                           color: CustomTheme
          //                                                               .appColor)),
          //                                               const Spacer(),
          //                                               InkWell(
          //                                                   onTap: () {
          //                                                     addonFormsData.add(req.AddOn(
          //                                                         itemName:
          //                                                             "",
          //                                                         quality:
          //                                                             "",
          //                                                         rentPrice:
          //                                                             ""));
          //                                                     numberOfAddons.add(
          //                                                         numberOfAddons
          //                                                             .length);
          //                                                     addAddonsToAllGrounds(
          //                                                         addons:
          //                                                             addonFormsData,
          //                                                         sportName:
          //                                                             element
          //                                                                 .name);
          //                                                   },
          //                                                   child: Padding(
          //                                                     padding: const EdgeInsets
          //                                                         .symmetric(
          //                                                         vertical:
          //                                                             16.0),
          //                                                     child: Text(
          //                                                         "+ Add more",
          //                                                         style: Get
          //                                                             .textTheme
          //                                                             .displaySmall!
          //                                                             .copyWith(
          //                                                                 color: CustomTheme.iconColor)),
          //                                                   )),
          //                                             ],
          //                                           ),
          //                                         );
          //                                       },
          //                                       body: Column(
          //                                         mainAxisSize:
          //                                             MainAxisSize.min,
          //                                         children: [
          //                                           Divider(
          //                                               color: CustomTheme
          //                                                   .borderColor,
          //                                               thickness: 2.0),
          //                                           SizedBox(
          //                                             height: numberOfAddons
          //                                                     .length *
          //                                                 constraints
          //                                                     .maxHeight *
          //                                                 0.27,
          //                                             child:
          //                                                 ListView.builder(
          //                                               itemCount:
          //                                                   numberOfAddons
          //                                                       .length,
          //                                               addAutomaticKeepAlives:
          //                                                   true,
          //                                               physics:
          //                                                   const NeverScrollableScrollPhysics(),
          //                                               itemBuilder:
          //                                                   (context,
          //                                                       index) {
          //                                                 return Column(
          //                                                   mainAxisSize:
          //                                                       MainAxisSize
          //                                                           .min,
          //                                                   children: [
          //                                                     Padding(
          //                                                       padding: const EdgeInsets
          //                                                           .symmetric(
          //                                                           horizontal:
          //                                                               16.0),
          //                                                       child:
          //                                                           ListTile(
          //                                                         title: Text(
          //                                                             "Item ${index + 1}",
          //                                                             style: Get
          //                                                                 .textTheme
          //                                                                 .headlineMedium),
          //                                                         tileColor:
          //                                                             CustomTheme
          //                                                                 .borderColor,
          //                                                         trailing: InkWell(
          //                                                             onTap: () {
          //                                                               numberOfAddons.removeAt(index);
          //                                                               numberOfAddons.refresh();
          //                                                               addonFormsData.removeAt(index);
          //                                                               addAddonsToAllGrounds(
          //                                                                   addons: addonFormsData,
          //                                                                   sportName: element.name);
          //                                                             },
          //                                                             child: const Icon(Icons.close, size: 32.0)),
          //                                                       ),
          //                                                     ),
          //                                                     AddonFormWidget(
          //                                                       index:
          //                                                           index,
          //                                                       addonData: (value) => updateAddonData(
          //                                                           sportName:
          //                                                               element
          //                                                                   .name,
          //                                                           addon:
          //                                                               value,
          //                                                           index:
          //                                                               index),
          //                                                     ),
          //                                                   ],
          //                                                 );
          //                                               },
          //                                             ),
          //                                           ),
          //                                         ],
          //                                       ))
          //                                 ],
          //                               ),
          //                             ),
          //                           ),
          //                           const SizedBox(height: 16.0),
          //                           // time selection
          //                           Padding(
          //                             padding: const EdgeInsets.all(8.0),
          //                             child: Text("Ground availability",
          //                                 style:
          //                                     Get.textTheme.displayMedium),
          //                           ),
          //                           Padding(
          //                             padding: const EdgeInsets.all(8.0),
          //                             child: Text("Ante meridiem (AM)",
          //                                 style:
          //                                     Get.textTheme.displaySmall),
          //                           ),
          //
          //                           Padding(
          //                             padding: const EdgeInsets.all(8.0),
          //                             child: SizedBox(
          //                                 height: 25.rfs * 3,
          //                                 child: SelectTimeWidget(
          //                                   itemCount: 6,
          //                                   startingIndexValue: 6,
          //                                   removingZeroAtIndex: 4,
          //                                   callback: (List<String> val) {
          //                                     log("morning selected time $val");
          //                                     for (FormInfo element
          //                                         in groundFormsData) {
          //                                       element.morningTiming = val;
          //                                     }
          //
          //                                     addAvailabilityTimigs(
          //                                         isMorning: true,
          //                                         sportName: element.name,
          //                                         timings: val);
          //                                     // profile.addGroundFormsList[profile.addGroundFormSelectedGround.value].value.morningTiming = val;
          //                                   },
          //                                 )),
          //                           ),
          //
          //                           Padding(
          //                             padding: const EdgeInsets.all(8.0),
          //                             child: Text("Post meridiem (PM)",
          //                                 style:
          //                                     Get.textTheme.displaySmall),
          //                           ),
          //
          //                           Padding(
          //                             padding: const EdgeInsets.all(8.0),
          //                             child: SizedBox(
          //                                 height: 25.rfs * 6,
          //                                 child: SelectTimeWidget(
          //                                   itemCount: 10,
          //                                   startingIndexValue: 0,
          //                                   removingZeroAtIndex: 5,
          //                                   callback: (List<String> val) {
          //                                     log("evening selected time $val");
          //                                     for (FormInfo element
          //                                         in groundFormsData) {
          //                                       element.eveningTiming = val;
          //                                     }
          //                                     addAvailabilityTimigs(
          //                                         isMorning: false,
          //                                         sportName: element.name,
          //                                         timings: val);
          //                                   },
          //                                 )),
          //                           ),
          //
          //                           Padding(
          //                             padding: const EdgeInsets.all(8.0),
          //                             child: Text(
          //                               "We have selected ground availability automatically as per your opening and closing time you can modify them as per your liking.",
          //                               style: Get.textTheme.displaySmall,
          //                             ),
          //                           ),
          //
          //                           SizedBox(
          //                               height:
          //                                   constraints.maxHeight * 0.25),
          //                         ],
          //                       ),
          //                     );
          //                   });
          //                 },
          //               ).toList()),
          //         ),
          //       ),
          //       // Floating Sports listview
          //       Positioned(
          //         top: 16.0,
          //         right: 20.0,
          //         left: 20.0,
          //         child: Material(
          //           color: Colors.white,
          //           child: Stack(
          //             children: [
          //               sports.length > 1
          //                   ? Positioned(
          //                       top: constraints.maxHeight * 0.04,
          //                       left: 20,
          //                       child: Container(
          //                           color: CustomTheme.appColor,
          //                           height: 2.0,
          //                           width: sports.length * 60),
          //                     )
          //                   : const SizedBox(),
          //               SizedBox(
          //                 height: constraints.maxHeight * 0.12,
          //                 child: ListView.builder(
          //                   itemCount: sports.length,
          //                   scrollDirection: Axis.horizontal,
          //                   itemBuilder: (context, index) {
          //                     return Obx(() {
          //                       return Padding(
          //                         padding: const EdgeInsets.only(
          //                             top: 8.0, right: 16.0),
          //                         child: Material(
          //                           color: Colors.transparent,
          //                           child: InkWell(
          //                             onTap: () {
          //                               selectedSport.value = index;
          //                               tabController.animateTo(index);
          //                             },
          //                             child: Padding(
          //                               padding: const EdgeInsets.all(4.0),
          //                               child: Column(
          //                                 mainAxisSize: MainAxisSize.min,
          //                                 children: [
          //                                   Center(
          //                                     child: Container(
          //                                       decoration: BoxDecoration(
          //                                           border: Border.all(
          //                                               color: selectedSport
          //                                                           .value ==
          //                                                       index
          //                                                   ? CustomTheme
          //                                                       .iconColor
          //                                                   : CustomTheme
          //                                                       .borderColor,
          //                                               width: 1.0),
          //                                           borderRadius:
          //                                               BorderRadius
          //                                                   .circular(
          //                                                       30.0)),
          //                                       child: Padding(
          //                                           padding:
          //                                               const EdgeInsets
          //                                                   .all(2.0),
          //                                           child: ImageWidget(
          //                                               imageurl:
          //                                                   "${ServerUrls.mediaUrl}sports/${sports[index].image}",
          //                                               radius: 25.0,
          //                                               width: 45,
          //                                               height: 45,
          //                                               fit: BoxFit.fill)),
          //                                     ),
          //                                   ),
          //                                   const SizedBox(height: 4.0),
          //                                   Text(sports[index].name,
          //                                       style: Get
          //                                           .textTheme.bodySmall!
          //                                           .copyWith(
          //                                               color: selectedSport
          //                                                           .value ==
          //                                                       index
          //                                                   ? CustomTheme
          //                                                       .textColor
          //                                                   : CustomTheme
          //                                                       .textColorLight)),
          //                                 ],
          //                               ),
          //                             ),
          //                           ),
          //                         ),
          //                       );
          //                     });
          //                   },
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //
          //       Obx(() => profile.loading.value
          //           ? Container(
          //               width: constraints.maxWidth,
          //               height: constraints.maxHeight,
          //               color: Colors.white54,
          //               child: Center(
          //                   child: CircularProgressIndicator(
          //                       color: CustomTheme.appColor)),
          //             )
          //           : const SizedBox())
          //     ],
          //   ),
          // )),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(16.0),
            child: MyButton(
              width: constraints.maxWidth * 0.5,
              text: "Start Earning",
              onPressed: () async {
                // profileController.addGroundsFormSubmitted.value = true;
                // Get.to(() => const CongratulationScreen());
                // log("Form validation data ${validateFormData()}");

                if (profile.loading.value) {
                  return;
                }
                profile.loading.value = true;

                if (validateFormData()) {
                  List<req.Ground> allGrounds = [];
                  for (Map<String, dynamic> map in formsMapDataList) {
                    allGrounds.addAll(map['list']);
                  }
                  final result = await profile.venueService.addGround(
                      profile.bearer,
                      AddGroundRequestModel(
                        venueId: widget.venueId != null
                            ? int.parse(widget.venueId!)
                            : profile.venueId!,
                        grounds: allGrounds,
                      ));
                  if (result != null && result.httpCode == 200) {
                    // log("is this user new?  ${getStorage.read<bool>(Constants.isNewAccount)}");
                    log("result from add ground screen ${result.toJson()}");
                    // if (getStorage.read<bool>(Constants.isNewAccount) ?? false) {}
                    getStorage.write(Constants.lastPage, "/");
                    // Get.off(() => const VenueMainPage());
                    Get.to(() => const CongratulationScreen());
                  }
                  profile.loading.value = false;
                  // profile.loading.refresh();
                } else {
                  profile.loading.value = false;
                }
              },
            ),
          ),
        ),
      );
    });
  }

  bool validateFormData() {
    for (var sport in sports) {
      var formData = formsMapDataList
          .firstWhere((element) => element['sport'] == sport.name);
      int index = formsMapDataList.indexOf(formData);
      List<req.Ground> groundsData = formData['list'];
      List<req.AddOn> addonsData = formData['addons'];
      for (int i = 0; i < groundsData.length; i++) {
        log("formData: ${groundsData.map((e) => e.toJson()).toList().join(',')}");
        if (groundsData[i].name.isEmpty) {
          Constants.showSnackbar(
              "Error", "${sport.name} Ground ${i + 1} name field is required");
          return false;
        }
        if (groundsData[i].hourlyRent <= 0) {
          Constants.showSnackbar("Error",
              "${sport.name} Ground ${i + 1} hourly rent field is required");
          return false;
        }
        if (groundsData[i].morningAvailability.isEmpty) {
          Constants.showSnackbar("Error",
              "${sport.name} Ground ${i + 1} select morning availability");
          return false;
        }
        if (groundsData[i].eveningAvailability.isEmpty) {
          Constants.showSnackbar("Error",
              "${sport.name} Ground ${i + 1} select evening availability");
          return false;
        }
      }

      for (int i = 0; i < addonsData.length; i++) {
        log("addonsData: ${addonsData.map((e) => e.toJson()).toList().join(',')}");
        if (addonsData[i].itemName.isEmpty) {
          Constants.showSnackbar(
              "Error", "${sport.name} Addon ${i + 1} name field is required");
          return false;
        }
        if (addonsData[i].rentPrice.isEmpty) {
          Constants.showSnackbar(
              "Error", "${sport.name} Addon ${i + 1} rent field is required");
          return false;
        }
        if (addonsData[i].quality.isEmpty) {
          Constants.showSnackbar("Error",
              "${sport.name} Addon ${i + 1} select morning availability");
          return false;
        }
      }

      if (index >= 0) {
        formsMapDataList[index]['list'] = groundsData.map((e) {
          e.addOns = addonsData;
          return e;
        }).toList();
      }
    }
    return true;
  }

  void testDataPopulate() {
    for (var sport in sports) {
      var formData = formsMapDataList
          .firstWhere((element) => element['sport'] == sport.name);
      List<req.Ground> groundsData = formData['list'];
      List<req.AddOn> addonsData = formData['addons'];
      for (int i = 0; i < groundsData.length; i++) {
        log("formData: ${groundsData.map((e) => e.toJson()).toList().join(',')}");
        if (groundsData[i].name.isEmpty) {
          Constants.showSnackbar(
              "Error", "${sport.name} Ground ${i + 1} name field is required");
          return;
        }
        if (groundsData[i].hourlyRent <= 0) {
          Constants.showSnackbar("Error",
              "${sport.name} Ground ${i + 1} hourly rent field is required");
          return;
        }
        if (groundsData[i].morningAvailability.isEmpty) {
          Constants.showSnackbar("Error",
              "${sport.name} Ground ${i + 1} select morning availability");
          return;
        }
        if (groundsData[i].eveningAvailability.isEmpty) {
          Constants.showSnackbar("Error",
              "${sport.name} Ground ${i + 1} select evening availability");
          return;
        }
      }

      for (int i = 0; i < addonsData.length; i++) {
        log("addonsData: ${addonsData.map((e) => e.toJson()).toList().join(',')}");
        if (addonsData[i].itemName.isEmpty) {
          Constants.showSnackbar(
              "Error", "${sport.name} Addon ${i + 1} name field is required");
          return;
        }
        if (addonsData[i].rentPrice.isEmpty) {
          Constants.showSnackbar(
              "Error", "${sport.name} Addon ${i + 1} rent field is required");
          return;
        }
        if (addonsData[i].quality.isEmpty) {
          Constants.showSnackbar("Error",
              "${sport.name} Addon ${i + 1} select morning availability");
          return;
        }
      }
    }
  }

  void addnewGround({required String sportName, required FormInfo formInfo}) {
    // var data = formInfo.toJson();
    // data.addEntries([MapEntry("add_ons", addon.map((e) => e.toJson()).toList())]);
    var listElement =
        formsMapDataList.firstWhere((element) => element['sport'] == sportName);
    int index = formsMapDataList.indexOf(listElement);
    List<req.Ground> list = listElement['list'];
    formInfo.morningTiming = list.first.morningAvailability;
    formInfo.eveningTiming = list.first.eveningAvailability;
    list.add(req.Ground.fromJson(formInfo.toJson()));

    if (index >= 0) {
      formsMapDataList[index]['list'] = list;
      formsMapDataList.refresh();
      log("addnewGround Update: ${formsMapDataList.map((element) => element.values).toList().join(',')}");
    }
    // groundsMainForms.add(req.Ground.fromJson(data));
  }

  void removeGround(int removeIndex, String sportname) {
    var element =
        formsMapDataList.firstWhere((value) => value['sport'] == sportname);
    int index = formsMapDataList.indexOf(element);
    List<req.Ground> list = element['list'];
    log("before removing ground ${list.map((e) => e.toJson()).toList().join(",")}");
    list.removeAt(removeIndex);
    log("after removing ground ${list.map((e) => e.toJson()).toList().join(",")}");
    formsMapDataList[index]['list'] = list;
  }

  void updateFormData(
      {required String sportName,
      required FormInfo formInfo,
      required int index}) {
    var value =
        formsMapDataList.firstWhere((element) => element['sport'] == sportName);
    int elIndex = formsMapDataList.indexOf(value);
    while (value['list'].length <= index) {
      value['list'].add(req.Ground.fromJson(
          formInfo.toJson())); // Add placeholders (null or default object)
    }

    log("value beforesd update ${value['list'].map((e) => e.toJson()).toList()}");
    value['list'][index] = req.Ground.fromJson(formInfo.toJson());
    formsMapDataList[elIndex] = value;
    log("value after update ${value['list'].map((e) => e.toJson()).toList()}");
  }

  void updateAddonData(
      {required String sportName,
      required req.AddOn addon,
      required int index}) {
    var value =
        formsMapDataList.firstWhere((element) => element['sport'] == sportName);
    int valueIndex = formsMapDataList.indexOf(value);
    log("value before update ${value['addons'].map((e) => e.toJson()).toList()}");
    value['addons'][index] = addon;
    formsMapDataList[valueIndex] = value;
    log("value after update ${value['addons'][index].toJson()}");
  }

  void addAddonsToAllGrounds(
      {required List<req.AddOn> addons, required String sportName}) {
    var data =
        formsMapDataList.firstWhere((element) => element['sport'] == sportName);
    int index = formsMapDataList.indexOf(data);
    data['addons'] = addons;
    formsMapDataList[index] = data;
    log("new added AddOns list: ${formsMapDataList.map((element) => element['addons']).toList().join(",")}");
  }

  void addAvailabilityTimigs(
      {required List<String> timings,
      required String sportName,
      required bool isMorning}) {
    var data =
        formsMapDataList.firstWhere((element) => element['sport'] == sportName);
    int index = formsMapDataList.indexOf(data);
    List<req.Ground> list = data["list"];
    log("list befor update ${list.map((e) => e.toJson()).toList().join(",")}");
    list
        .map((e) => isMorning
            ? e.morningAvailability = timings
            : e.eveningAvailability = timings)
        .toList();
    log("list after update ${list.map((e) => e.toJson()).toList().join(",")}");
    data['list'] = list;
    formsMapDataList[index] = data;
  }
}
