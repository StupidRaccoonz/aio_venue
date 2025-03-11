import 'dart:developer';

import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/models/form_info.dart';
import 'package:aio_sport/models/update_ground_req_model.dart' as req;
import 'package:aio_sport/models/venue_details_model.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/add_ground_form.dart';
import 'package:aio_sport/widgets/addon_form_widget.dart';
import 'package:aio_sport/widgets/app_bar_widget.dart';
import 'package:aio_sport/widgets/my_button.dart';
import 'package:aio_sport/widgets/select_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

class ManageGroundScreen extends StatefulWidget {
  final Ground ground;
  const ManageGroundScreen({super.key, required this.ground});

  @override
  State<ManageGroundScreen> createState() => _ManageGroundScreenState();
}

class _ManageGroundScreenState extends State<ManageGroundScreen> {
  final profile = Get.find<ProfileController>();
  late Ground ground;
  late req.UpdateGroundRequestModel requestModel;
  Rx<bool> loading = false.obs;
  @override
  void initState() {
    ground = widget.ground;
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Constants.backgroundDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(preferredSize: Size(double.maxFinite, 10.vh), child: AppbarWidget(title: "${widget.ground.name}")),
        body: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ListTile(title: Text("Ground  1", style: Get.textTheme.headlineMedium), tileColor: CustomTheme.borderColor),
                      ),
                      AddGroundForm(
                        sport: profile.sportsList.firstWhere((e) => e!.id == ground.sportsId)!,
                        oldfFormInfo: FormInfo(
                            groundName: ground.name ?? "N/A",
                            groundSize: ground.groundSize ?? "N/A",
                            groundUnits: ground.unit ?? "N/A",
                            hourlyRent: ground.hourlyRent ?? "0.0",
                            isIndoor: ground.groundType == null ? true : ground.groundType! == "indoor",
                            sportId: ground.sportsId,
                            morningTiming: ground.morningAvailability,
                            eveningTiming: ground.eveningAvailability,
                            // addOn: []
                        ),
                        formInfo: (FormInfo value) {
                          requestModel.ground = req.Ground(
                            addOns: requestModel.ground.addOns,
                            name: value.groundName.isEmpty ? ground.name ?? "" : value.groundName,
                            groundSize: value.groundSize.isEmpty
                                ? ground.groundSize ?? profile.sportsList.firstWhere((element) => element?.id == ground.sportsId)!.sportsizes.first.size
                                : value.groundSize,
                            unit: value.groundUnits.isEmpty ? (ground.unit ?? "1") : value.groundUnits,
                            hourlyRent: value.hourlyRent.isEmpty ? double.parse(ground.hourlyRent ?? "1.0") : double.parse(value.hourlyRent),
                            groundId: ground.id,
                            groundType: value.isIndoor ? "indoor" : "outdoor",
                            sportsId: ground.sportsId,
                            venueId: ground.venueId,
                            eveningAvailability: ground.eveningAvailability,
                            morningAvailability: ground.morningAvailability,
                          );

                          log("updated ground data ${requestModel.toJson()}");
                        },
                      ),
                      SizedBox(
                        height: ground.grounditems.length * constraints.maxHeight * 0.3,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.ground.grounditems.length,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: ListTile(
                                    title: Text("Item ${index + 1}", style: Get.textTheme.headlineMedium),
                                    tileColor: CustomTheme.borderColor,
                                    trailing: InkWell(
                                        onTap: () {
                                          /* numberOfAddons.removeAt(index);
                                          numberOfAddons.refresh();
                                          addonFormsData.removeAt(index);
                                          addAddonsToAllGrounds(addons: addonFormsData, sportName: element.name); */
                                        },
                                        child: const Icon(Icons.close, size: 32.0)),
                                  ),
                                ),
                                AddonFormWidget(
                                  index: index,
                                  addonOldData: ground.grounditems[index],
                                  addonData: (value) => updateAddonData(index, req.AddOn.fromJson(value.toJson())),
                                ),
                              ],
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 20.0),
                      // time selection
                      Padding(padding: const EdgeInsets.all(8.0), child: Text("Ground availability", style: Get.textTheme.displayMedium)),
                      Padding(padding: const EdgeInsets.all(8.0), child: Text("Ante meridiem (AM)", style: Get.textTheme.displaySmall)),

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
                                requestModel.ground.morningAvailability = val;
                                log("updated request data: ${requestModel.toJson()}");

                                // addAvailabilityTimigs(isMorning: true, sportName: widget.selectedSport.name, timings: val);
                                // profile.addGroundFormsList[profile.addGroundFormSelectedGround.value].value.morningTiming = val;
                              },
                            )),
                      ),

                      Padding(padding: const EdgeInsets.all(8.0), child: Text("Post meridiem (PM)", style: Get.textTheme.displaySmall)),

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
                                requestModel.ground.eveningAvailability = val;
                                log("updated request data: ${requestModel.toJson()}");
                                // addAvailabilityTimigs(isMorning: false, sportName: widget.selectedSport.name, timings: val);
                              },
                            )),
                      ),
                      Center(
                        child: MyButton(
                          text: "Update",
                          onPressed: () async {
                            loading.value = true;
                            try {
                              profile.venueService.updateGround(profile.bearer, requestModel).then((value) {
                                if (value != null) {
                                  Get.back();
                                  profile.updateVenueData();
                                  Constants.showSnackbar("Result", value.message);
                                }

                                loading.value = false;
                              });
                            } catch (e) {
                              log(" updateground error");
                              loading.value = false;
                            }
                          },
                          width: constraints.maxWidth * 0.7,
                        ),
                      ),
                      const SizedBox(height: 24.0)
                    ],
                  ),
                ),
              ),
              Obx(() {
                return loading.value
                    ? Container(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                        color: Colors.white54,
                        child: Center(child: CircularProgressIndicator(color: CustomTheme.appColor)),
                      )
                    : const SizedBox();
              })
            ],
          );
        }),
      ),
    );
  }

  updateAddonData(int index, req.AddOn value) {
    requestModel.ground.addOns[index].itemName = value.itemName.isEmpty ? ground.grounditems[index].itemName ?? "N/A" : value.itemName;
    requestModel.ground.addOns[index].rentPrice = value.rentPrice.isEmpty ? ground.grounditems[index].rentPrice ?? "1.0" : value.rentPrice;
    requestModel.ground.addOns[index].quality = value.quality.isEmpty ? "${ground.grounditems[index].quality}" : value.quality;
  }

  void initData() {
    requestModel = req.UpdateGroundRequestModel(
        ground: req.Ground(
            addOns: ground.grounditems.map((e) => req.AddOn(itemName: e.itemName ?? "Item", rentPrice: e.rentPrice ?? "0", quality: "${e.quality}")).toList(),
            groundId: ground.id,
            venueId: ground.venueId,
            groundSize: ground.groundSize ?? "",
            groundType: ground.groundType ?? "indoor",
            hourlyRent: double.parse(ground.hourlyRent ?? "1.0"),
            name: ground.name ?? "Ground name",
            sportsId: ground.sportsId,
            unit: ground.unit ?? "1",
            eveningAvailability: ground.eveningAvailability,
            morningAvailability: ground.morningAvailability));

    log("New request $requestModel");
  }
}
