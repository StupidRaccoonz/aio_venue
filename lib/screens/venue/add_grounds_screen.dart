import 'dart:developer';

import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/models/add_ground_req_model.dart';
import 'package:aio_sport/models/form_info.dart';
import 'package:aio_sport/models/venue_details_model.dart';
import 'package:aio_sport/screens/authentication/wrapper.dart';
import 'package:aio_sport/screens/venue/venue_main_page.dart';
import 'package:aio_sport/services/server_urls.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/ground_info_widget.dart';
import 'package:aio_sport/widgets/image_widget.dart';
import 'package:aio_sport/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

class AddGroundsScreen extends StatefulWidget {
  const AddGroundsScreen({super.key});

  @override
  State<AddGroundsScreen> createState() => _AddGroundsScreenState();
}

class _AddGroundsScreenState extends State<AddGroundsScreen> with TickerProviderStateMixin {
  final pageController = PageController();
  final profileController = Get.find<ProfileController>();
  bool isValidForm = false;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () {
      profileController.addGroundFormsList.add(Rx(FormInfo(
        sportId: 1,
        groundName: "",
        groundSize: "",
        groundUnits: "1",
        hourlyRent: "",
        morningTiming: [],
        eveningTiming: [],
        isIndoor: true,
        // addOn: [AddOn(itemName: "", quality: "", rentPrice: "")],
      )));
    });
    if (getStorage.read<bool>(Constants.isNewAccount) ?? false) {
      getStorage.write(Constants.lastPage, "AddGroundsScreen");
    }

    if (profileController.currentVenue.value != null && profileController.sportsList.isNotEmpty) {
      for (Sport element1 in profileController.currentVenue.value!.data!.venue.sports!) {
        profileController.selectedSportsList.add(profileController.sportsList.firstWhere((element) => element!.id == element1.id)!);
      }
      if (profileController.addGroundFormsList.isNotEmpty) {
        profileController.addGroundFormsList.first.value.sportId = profileController.selectedSportsList[profileController.addFormSelectedSport.value].id;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/background.jpg'), fit: BoxFit.cover)),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(backgroundColor: CustomTheme.bocLightBackground),
        body: Obx(() {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text("Add Grounds", style: Get.textTheme.titleLarge),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "Let us know how many grounds you have for each sport",
                        style: Get.textTheme.displaySmall,
                      ),
                    ),
                    SizedBox(height: 15.rh),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SizedBox(
                        height: 75.rh,
                        child: GetX<ProfileController>(builder: (controller) {
                          // log("SportsList data: ${controller.currentVenue.value!.data?.venue.sports}");
                          return ListView.builder(
                            itemCount: controller.selectedSportsList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GetX<ProfileController>(builder: (controller) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: CircleAvatar(
                                        radius: 21.5.rh,
                                        backgroundColor: index == controller.addFormSelectedSport.value ? CustomTheme.iconColor : Colors.white,
                                        // foregroundColor: index != selectedSport ? CustomTheme.iconColor : Colors.white,
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.addFormSelectedSport.value = index;
                                            profileController.addGroundFormsList[controller.addGroundFormSelectedGround.value].value.groundSize =
                                                profileController.selectedSportsList[profileController.addFormSelectedSport.value].sportsizes.first.size;
                                            if (profileController.selectedSportsList.isNotEmpty) {
                                              profileController.addGroundFormsList.assignAll(profileController.addGroundFormsList.map((element) {
                                                element.value.sportId = profileController.selectedSportsList[profileController.addFormSelectedSport.value].id;
                                                log("updated sportId for grounds ${element.toJson()}");
                                                return element;
                                              }).toList());
                                            }
                                          },
                                          child: ImageWidget(
                                            // controller.selectedSports[index].sportImage,
                                            imageurl: "${ServerUrls.mediaUrl}sports/${controller.selectedSportsList[index].image}",
                                            height: 40.rh,
                                            width: 40.rh,
                                            radius: 21.5.rh,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text(
                                        controller.selectedSportsList[index].name,
                                        style: controller.addFormSelectedSport.value == index ? Get.textTheme.bodySmall : Get.textTheme.displaySmall,
                                      ),
                                    )
                                  ],
                                );
                              });
                            },
                          );
                        }),
                      ),
                    ),
                    Divider(color: CustomTheme.textColorLight.withOpacity(0.5), height: 2.0),
                    SizedBox(
                      height: 45.rh,
                      child: Row(
                        children: [
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: ListView.builder(
                              itemCount: profileController.addGroundFormNumberOfGrounds,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return GetX<ProfileController>(builder: (controller) {
                                  return Container(
                                    decoration: controller.addGroundFormSelectedGround.value == index
                                        ? BoxDecoration(border: Border(bottom: BorderSide(width: 1.5, color: CustomTheme.textColorLight)))
                                        : null,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: InkWell(
                                        onTap: () {
                                          if (controller.addGroundFormSelectedGround.value != index) {
                                            controller.addGroundFormSelectedGround.value = index;
                                            pageController.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.ease);
                                          }
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text("Ground ${index + 1}", style: Get.textTheme.labelMedium),
                                            controller.addGroundFormSelectedGround.value == index
                                                ? InkWell(
                                              onTap: () {
                                                if (controller.addGroundFormSelectedGround.value > 0) {
                                                  controller.addGroundFormSelectedGround.value--;
                                                  controller.addGroundFormsList.removeAt(index);
                                                  controller.addGroundFormsList.refresh();
                                                }
                                              },
                                              child: Icon(Icons.close, size: 20.rh),
                                            )
                                                : const SizedBox()
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Material(
                            color: CustomTheme.iconColor,
                            elevation: 4.0,
                            borderRadius: const BorderRadius.horizontal(left: Radius.circular(16.0)),
                            child: InkWell(
                              borderRadius: const BorderRadius.horizontal(left: Radius.circular(16.0)),
                              onTap: () => profileController.addGroundFormsList.add(
                                Rx(FormInfo(
                                  sportId: profileController.selectedSportsList[profileController.addFormSelectedSport.value].id,
                                  groundName: "",
                                  groundSize: profileController.selectedSportsList[profileController.addFormSelectedSport.value].sportsizes.first.size,
                                  groundUnits: "1",
                                  hourlyRent: "",
                                  morningTiming: [],
                                  eveningTiming: [],
                                  isIndoor: true,
                                  // addOn: [AddOn(quality: "", itemName: '', rentPrice: "")],
                                )),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Icon(Icons.add, size: 25.rh, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: CustomTheme.textColorLight.withOpacity(0.5), height: 2.0),
                    Expanded(
                      child: PageView.builder(
                        controller: pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: profileController.addGroundFormNumberOfGrounds,
                        itemBuilder: (context, index) {
                          return GroundInfoWidget(index: profileController.addGroundFormSelectedGround.value);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: MyButton(
                        text: "Start Earning",
                        onPressed: () async {
                          // profileController.addGroundsFormSubmitted.value = true;
                          // Get.to(() => const CongratulationScreen());
                          // log("Form validation data ${validateFormData()}");
                          if (validateFormData()) {
                            profileController.loading.value = true;
                            final result = await profileController.venueService.addGround(
                                profileController.bearer,
                                AddGroundRequestModel.fromJson(
                                  {
                                    "venue_id": profileController.venueId,
                                    "grounds": profileController.addGroundFormsList.map((element) => element.toJson()).toList(),
                                  },
                                ));
                            if (result != null && result.httpCode == 200) {
                              log("is this user new?  ${getStorage.read<bool>(Constants.isNewAccount)}");
                              log("result from add ground screen ${result.toJson()}");
                              if (getStorage.read<bool>(Constants.isNewAccount) ?? false) {}
                              getStorage.write(Constants.lastPage, "/");
                              Get.off(() => const VenueMainPage());
                              // Get.off(() => const VenueMainPage());
                            }
                            profileController.loading.value = false;
                            profileController.loading.refresh();
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              profileController.loading.value
                  ? Container(
                color: Colors.white54,
                child: Center(child: CircularProgressIndicator(color: CustomTheme.appColor)),
              )
                  : const SizedBox(),
            ],
          );
        }),
      ),
    );
  }

  bool validateFormData() {
    int ground = 1;
    for (Rx<FormInfo> formInfo in profileController.addGroundFormsList) {
      if (formInfo.value.groundName.isEmpty) {
        Constants.showSnackbar("Error", "Ground $ground name field is missing");
        return false;
      }
      if (formInfo.value.groundSize.isEmpty) {
        Constants.showSnackbar("Error", "Ground $ground ground size is missing");
        return false;
      }
      if (formInfo.value.hourlyRent.isEmpty) {
        Constants.showSnackbar("Error", "Ground $ground rent field is missing");
        return false;
      }
      if (formInfo.value.morningTiming.isEmpty) {
        Constants.showSnackbar("Error", "Ground $ground select morning time");
        return false;
      }
      if (formInfo.value.eveningTiming.isEmpty) {
        Constants.showSnackbar("Error", "Ground $ground select evening time");
        return false;
      }
      /* if (formInfo.value.addOn.isNotEmpty &&
          formInfo.value.addOn.any((element) => element.itemName.isEmpty || element.quality.isEmpty || element.rentPrice.isEmpty)) {
        Constants.showSnackbar("Error", "Ground $ground Add-on fields are required");
        return false;
      } */
      ground = ground + 1;
    }
    return true;
  }
}
