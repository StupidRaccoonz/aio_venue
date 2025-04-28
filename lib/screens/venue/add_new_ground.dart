import 'dart:developer';

import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/models/add_ground_req_model.dart';
import 'package:aio_sport/models/form_info.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/add_ground_form.dart';
import 'package:aio_sport/widgets/addon_form_widget.dart';
import 'package:aio_sport/widgets/app_bar_widget.dart';
import 'package:aio_sport/widgets/my_button.dart';
import 'package:aio_sport/models/sports_data_model.dart' as sport;
import 'package:aio_sport/widgets/select_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aio_sport/models/add_ground_req_model.dart' as req;
import 'package:scaled_size/scaled_size.dart';

class AddNewGroundScreen extends StatefulWidget {
  final sport.Sport selectedSport;
  const AddNewGroundScreen({super.key, required this.selectedSport});

  @override
  State<AddNewGroundScreen> createState() => _AddNewGroundScreenState();
}

class _AddNewGroundScreenState extends State<AddNewGroundScreen> {
  final profile = Get.find<ProfileController>();
  Rx<bool> groundExpanded = false.obs;
  Rx<bool> addonExpanded = false.obs;
  RxList<Map<String, dynamic>> formsMapDataList = <Map<String, dynamic>>[].obs;
  RxList<int> numberOfGrounds = [1].obs;
  RxList<int> numberOfAddons = [1].obs;
  RxList<req.AddOn> addonFormsData =
      <req.AddOn>[req.AddOn(itemName: "", quality: "", rentPrice: "")].obs;
  List<String> morningTimings = [];
  List<String> eveningTimings = [];
  late RxList<FormInfo> groundFormsData;

  @override
  void initState() {
    super.initState();
    groundFormsData = <FormInfo>[
      FormInfo(
        groundName: "",
        groundSize: widget.selectedSport.sportsizes.first.size,
        groundUnits: "",
        hourlyRent: "",
        isIndoor: true,
        sportId: widget.selectedSport.id,
        morningTiming: [],
        eveningTiming: [],
        // addOn: [],
      )
    ].obs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: Size(double.maxFinite, 10.vh),
          child: const AppbarWidget(title: "Add New Ground")),
      body: LayoutBuilder(builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Obx(() {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //for grounds form list
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: CustomTheme.borderColor, width: 1.5),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ExpansionPanelList(
                        elevation: 0.0,
                        expansionCallback: (panelIndex, isExpanded) =>
                            groundExpanded.value = !groundExpanded.value,
                        children: [
                          ExpansionPanel(
                              canTapOnHeader: true,
                              isExpanded: groundExpanded.value,
                              headerBuilder: (context, isExpanded) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                          "Ground Details (${numberOfGrounds.length})",
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(
                                                  color: CustomTheme.appColor)),
                                      const Spacer(),
                                      InkWell(
                                          onTap: () {
                                            numberOfGrounds
                                                .add(numberOfGrounds.length);
                                            groundFormsData.add(FormInfo(
                                              groundName: "",
                                              groundSize: widget.selectedSport
                                                  .sportsizes.first.size,
                                              groundUnits: "",
                                              hourlyRent: "",
                                              isIndoor: true,
                                              sportId: widget.selectedSport.id,
                                              morningTiming: [],
                                              eveningTiming: [],
                                              // addOn: [],
                                            ));
                                            // addnewGround(sportName: widget.selectedSport.name, formInfo: groundFormsData.last);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16.0),
                                            child: Text(
                                              "+ Add more",
                                              style: Get.textTheme.displaySmall!
                                                  .copyWith(
                                                      color: CustomTheme
                                                          .iconColor),
                                            ),
                                          )),
                                    ],
                                  ),
                                );
                              },
                              body: SizedBox(
                                height: numberOfGrounds.length *
                                    constraints.maxHeight *
                                    0.5,
                                child: ListView.builder(
                                  itemCount: numberOfGrounds.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: ListTile(
                                            title: Text("Ground ${index + 1}",
                                                style: Get
                                                    .textTheme.headlineMedium),
                                            tileColor: CustomTheme.borderColor,
                                            trailing: InkWell(
                                                onTap: () {
                                                  if (numberOfGrounds.length >
                                                      1) {
                                                    numberOfGrounds
                                                        .removeAt(index);
                                                    numberOfGrounds.refresh();
                                                    groundFormsData
                                                        .removeAt(index);
                                                    groundFormsData.refresh();
                                                    removeGround(
                                                        index,
                                                        widget.selectedSport
                                                            .name);
                                                  }
                                                },
                                                child: const Icon(Icons.close,
                                                    size: 32.0)),
                                          ),
                                        ),
                                        AddGroundForm(
                                          sport: profile.sportsList.firstWhere(
                                              (e) =>
                                                  e!.id ==
                                                  widget.selectedSport.id)!,
                                          formInfo: (FormInfo value) {
                                            groundFormsData[index] = value;
                                            // updateFormData(sportName: widget.selectedSport.name, formInfo: value, index: index);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                ),
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
                            color: CustomTheme.borderColor, width: 1.5),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ExpansionPanelList(
                        elevation: 0.0,
                        expansionCallback: (panelIndex, isExpanded) =>
                            addonExpanded.value = !addonExpanded.value,
                        children: [
                          ExpansionPanel(
                              canTapOnHeader: true,
                              isExpanded: addonExpanded.value,
                              headerBuilder: (context, isExpanded) {
                                return ListTile(
                                  title: Row(
                                    children: [
                                      Text("Add ons (${numberOfAddons.length})",
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(
                                                  color: CustomTheme.appColor)),
                                      const Spacer(),
                                      InkWell(
                                          onTap: () {
                                            addonFormsData.add(req.AddOn(
                                                itemName: "",
                                                quality: "",
                                                rentPrice: ""));
                                            numberOfAddons
                                                .add(numberOfAddons.length);
                                            addAddonsToAllGrounds(
                                                addons: addonFormsData,
                                                sportName:
                                                    widget.selectedSport.name);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16.0),
                                            child: Text("+ Add more",
                                                style: Get
                                                    .textTheme.displaySmall!
                                                    .copyWith(
                                                        color: CustomTheme
                                                            .iconColor)),
                                          )),
                                    ],
                                  ),
                                );
                              },
                              body: SizedBox(
                                height: numberOfAddons.length *
                                    constraints.maxHeight *
                                    0.25,
                                child: ListView.builder(
                                  itemCount: numberOfAddons.length,
                                  physics: const ClampingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: ListTile(
                                            title: Text("Item ${index + 1}",
                                                style: Get
                                                    .textTheme.headlineMedium),
                                            tileColor: CustomTheme.borderColor,
                                            trailing: InkWell(
                                                onTap: () {
                                                  numberOfAddons
                                                      .removeAt(index);
                                                  numberOfAddons.refresh();
                                                  addonFormsData
                                                      .removeAt(index);
                                                  addAddonsToAllGrounds(
                                                      addons: addonFormsData,
                                                      sportName: widget
                                                          .selectedSport.name);
                                                },
                                                child: const Icon(Icons.close,
                                                    size: 32.0)),
                                          ),
                                        ),
                                        AddonFormWidget(
                                          index: index,
                                          addonData: (value) =>
                                              addonFormsData[index] = value,
                                        ),
                                      ],
                                    );
                                  },
                                ),
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
                        style: Get.textTheme.displayMedium),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Ante meridiem (AM)",
                        style: Get.textTheme.displaySmall),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        height: 25.rfs * 3,
                        child: SelectTimeWidget(
                          itemCount: 6,
                          startingIndexValue: 6,
                          removingZeroAtIndex: 4,
                          callback: (List<String> val) {
                            log("morning selected time $val");
                            for (FormInfo element in groundFormsData) {
                              element.morningTiming = val;
                            }

                            // addAvailabilityTimigs(isMorning: true, sportName: widget.selectedSport.name, timings: val);
                            // profile.addGroundFormsList[profile.addGroundFormSelectedGround.value].value.morningTiming = val;
                          },
                        )),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Post meridiem (PM)",
                        style: Get.textTheme.displaySmall),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        height: 25.rfs * 6,
                        child: SelectTimeWidget(
                          itemCount: 10,
                          startingIndexValue: 0,
                          removingZeroAtIndex: 5,
                          callback: (List<String> val) {
                            log("evening selected time $val");
                            for (FormInfo element in groundFormsData) {
                              element.eveningTiming = val;
                            }
                            // addAvailabilityTimigs(isMorning: false, sportName: widget.selectedSport.name, timings: val);
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

                  SizedBox(height: constraints.maxHeight * 0.05),
                  Center(
                    child: MyButton(
                      text: "Add Ground",
                      width: constraints.maxWidth * 0.8,
                      onPressed: () async {
                        profile.loading.value = true;

                        if (validateFormData()) {
                          List<req.Ground> allGrounds = [];
                          for (var data in groundFormsData) {
                            Map<String, dynamic> map = data.toJson();
                            map.putIfAbsent(
                                "add_ons",
                                () => addonFormsData
                                    .map((element) => element.toJson())
                                    .toList());
                            map.putIfAbsent(
                                "morning_availability", () => morningTimings);
                            map.putIfAbsent(
                                "evening_availability", () => morningTimings);
                            allGrounds.add(req.Ground.fromJson(map));
                          }
                          final result = await profile.venueService.addGround(
                              profile.bearer,
                              AddGroundRequestModel(
                                  venueId: profile.venueId!,
                                  grounds: allGrounds));
                          if (result != null && result.httpCode == 200) {
                            // log("is this user new?  ${getStorage.read<bool>(Constants.isNewAccount)}");
                            log("result from add ground screen ${result.toJson()}");
                            // profile.currentVenue.value!.data!.venue.grounds.addAll(allGrounds.map((e) => ven.Ground.fromJson(e.toJson())).toList());
                            // if (getStorage.read<bool>(Constants.isNewAccount) ?? false) {}
                            // getStorage.write(Constants.lastPage, "/");
                            if (Get.isSnackbarOpen) {
                              Get.back();
                            }
                            Get.back();

                            // Get.off(() => const VenueMainPage());
                          }
                          profile.loading.value = false;
                          Get.back();
                          // profile.loading.refresh();
                        } else {
                          profile.loading.value = false;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.1),
                ],
              ),
            );
          }),
        );
      }),
    );
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

  void addAddonsToAllGrounds(
      {required List<req.AddOn> addons, required String sportName}) {
    var data =
        formsMapDataList.firstWhere((element) => element['sport'] == sportName);
    int index = formsMapDataList.indexOf(data);
    data['addons'] = addons;
    formsMapDataList[index] = data;
    log("new added AddOns list: ${formsMapDataList.map((element) => element['addons']).toList().join(",")}");
  }

  bool validateFormData() {
    for (var data in groundFormsData.toList()) {
      int index = groundFormsData.indexOf(data);

      // log("formData: ${data.map((e) => e.toJson()).toList().join(',')}");
      if (data.groundName.isEmpty) {
        Constants.showSnackbar(
            "Error", "Ground ${index + 1} name field is required");
        return false;
      }
      if (data.hourlyRent.isEmpty) {
        Constants.showSnackbar(
            "Error", "Ground ${index + 1} hourly rent field is required");
        return false;
      }
      if (data.morningTiming.isEmpty) {
        Constants.showSnackbar(
            "Error", "Ground ${index + 1} select morning availability");
        return false;
      }
      if (data.eveningTiming.isEmpty) {
        Constants.showSnackbar(
            "Error", "Ground ${index + 1} select evening availability");
        return false;
      }
    }
    for (int i = 0; i < addonFormsData.length; i++) {
      // log("addonsData: ${addonsData.map((e) => e.toJson()).toList().join(',')}");
      if (addonFormsData[i].itemName.isEmpty) {
        Constants.showSnackbar(
            "Error", "Addon ${i + 1} name field is required");
        return false;
      }
      if (addonFormsData[i].rentPrice.isEmpty) {
        Constants.showSnackbar(
            "Error", "Addon ${i + 1} rent field is required");
        return false;
      }
      if (addonFormsData[i].quality.isEmpty) {
        Constants.showSnackbar(
            "Error", "Addon ${i + 1} select morning availability");
        return false;
      }
    }
    return true;
  }
}
