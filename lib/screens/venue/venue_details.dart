import 'dart:developer';
import 'dart:io';

import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/controllers/auth_controller.dart';
import 'package:aio_sport/controllers/home_controller.dart';
import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/models/add_venue_details_request_model.dart';
import 'package:aio_sport/models/sports_data_model.dart';
import 'package:aio_sport/models/venue_details_model.dart' as venue;
import 'package:aio_sport/screens/authentication/login_screen.dart';
// import 'package:aio_sport/screens/authentication/login_screen.dart';
import 'package:aio_sport/screens/authentication/wrapper.dart';
import 'package:aio_sport/screens/common/upload_media_screen.dart';
import 'package:aio_sport/screens/venue/sports_bottom_sheet.dart';
import 'package:aio_sport/screens/venue/venue_place_picker_screen.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/input_field_widget.dart';
import 'package:aio_sport/widgets/my_button.dart';
import 'package:aio_sport/widgets/selection_chip_widget.dart';
import 'package:aio_sport/widgets/working_day_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scaled_size/scaled_size.dart';

import '../authentication/signup_screen.dart';

class VenueDetails extends StatefulWidget {
  final bool addAnotherVenue;

  const VenueDetails({super.key, required this.addAnotherVenue});

  @override
  State<VenueDetails> createState() => _VenueDetailsState();
}

class _VenueDetailsState extends State<VenueDetails> {
  final venueController = TextEditingController();
  final addressController = TextEditingController();
  final openingController = TextEditingController();
  final closingController = TextEditingController();
  final selectSportsController = TextEditingController();

  final numberOfGroundC = TextEditingController();
  final discountC = TextEditingController();
  final homeController = Get.find<HomeController>();
  final profileController = Get.find<ProfileController>();
  List<WorkingDay> workingDays = Constants.workingDays;
  File? image;
  AddVenueDetailsRequestModel? requestModel;
  final _formKey = GlobalKey<FormState>();
  RxList<Sport> selectedSports = <Sport>[].obs;
  AuthController controllerr = AuthController();
  final GlobalKey<TooltipState> tooltipKey = GlobalKey<TooltipState>();

  final _mapKey = "AIzaSyDGo_UDxr84Zu4hwTuUsO7C5U5p9RSuqqE";

  @override
  void initState() {
    selectSportsController.text = "Select Sports";
    discountC.text = "0";
    if (!widget.addAnotherVenue && (getStorage.read<bool>(Constants.isNewAccount) ?? false)) {
      getStorage.write(Constants.lastPage, Get.currentRoute);
    }
    super.initState();
    checkForPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/background.jpg'), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(builder: (context, constraints) {
          return GetX<ProfileController>(builder: (controller) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5.rh),
                      Expanded(
                        child: Form(
                          key: _formKey,
                          child: ListView(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        String? lastPage = getStorage.read<String>(Constants.lastPage);
                                        print("kajal hereee ${profileController.isLoggedIn.value}");
                                        if (!profileController.isLoggedIn.value) {
                                          Get.to(() => SignupScreen());
                                        } else {
                                          Get.to(() => LoginScreen());
                                        }
                                      },
                                      icon: Icon(Icons.arrow_back_rounded, color: CustomTheme.appColor)),
                                ],
                              ),
                              SizedBox(height: 10.rh),
                              Text("Venue details", style: Get.textTheme.titleLarge),
                              Text("Provide your personal information.", style: Get.textTheme.displaySmall),
                              SizedBox(height: 15.rh),
                              Row(
                                children: [
                                  // InkWell(
                                  //   borderRadius: BorderRadius.circular(30.br),
                                  //   onTap: () async {
                                  //     List<File> files =
                                  //         await Constants.pickImage();
                                  //     if (files.isNotEmpty) {
                                  //       // await controller.uploadMedia(files);
                                  //       image = files.first;
                                  //       setState(() {});
                                  //     }
                                  //   },
                                  //   child: image == null
                                  //       ? Image.asset(
                                  //           "assets/icons/add_image.png",
                                  //           height: constraints.maxHeight * 0.1,
                                  //           fit: BoxFit.cover)
                                  //       : CircleAvatar(
                                  //           foregroundImage: FileImage(image!),
                                  //           radius: 20.br),
                                  // ),
                                  InkWell(
                                    borderRadius: BorderRadius.circular(30.br),
                                    onTap: () async {
                                      if (image != null) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              contentPadding: EdgeInsets.all(10),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(15)),
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(15),
                                                      child: Image.file(
                                                        image!,
                                                        height: 200,
                                                        width: 200,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      List<File> files = await Constants.pickImage();
                                                      if (files.isNotEmpty) {
                                                        setState(() {
                                                          image = files.first;
                                                        });
                                                      }
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Edit Image"),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        // If no image, let the user select a new image
                                        List<File> files = await Constants.pickImage();
                                        if (files.isNotEmpty) {
                                          setState(() {
                                            image = files.first;
                                          });
                                        }
                                      }
                                    },
                                    child: image == null
                                        ? Image.asset(
                                            "assets/icons/add_image.png",
                                            height: constraints.maxHeight * 0.1,
                                            fit: BoxFit.cover,
                                          )
                                        : CircleAvatar(
                                            foregroundImage: FileImage(image!),
                                            radius: 20.br,
                                          ),
                                  ),

                                  const SizedBox(width: 16.0),
                                  Expanded(child: Text("Upload profile photo of venue", style: Get.textTheme.bodyLarge)),
                                ],
                              ),
                              SizedBox(height: 5.rh),
                              InputFieldWidget(
                                label: "Venue Name",
                                validate: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "venue name is required";
                                  }
                                  if (value.contains(RegExp(r'[0-9]'))) {
                                    return "venue name should not contain any number";
                                  }
                                  return null;
                                },
                                textEditingController: venueController,
                                leadingIcon: Image.asset('assets/icons/stadium.png'),
                              ),
                              SizedBox(height: 5.rh),
                              InputFieldWidget(
                                label: "Address",
                                validate: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "address field is required";
                                  }

                                  return null;
                                },
                                textEditingController: addressController,
                                onTrailingTap: () async {
                                  Get.to(PlacePickerScreen())!.then((value) {
                                    addressController.text = value;
                                  });

                                  //  = "${address.name ?? ''}, ${address.formattedAddress ?? ""}";
                                },
                                trailingIcon: Image.asset("assets/icons/gps.png", width: 25.0),
                                leadingIcon: Image.asset('assets/icons/location.png'),
                              ),
                              SizedBox(height: 5.rh),
                              InputFieldWidget(
                                label: "Number of grounds",
                                validate: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "number of ground is required";
                                  }

                                  return null;
                                },
                                inputType: TextInputType.number,
                                textEditingController: numberOfGroundC,
                                leadingIcon: Image.asset('assets/icons/football.png'),
                              ),
                              SizedBox(height: 5.rh),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: InputFieldWidget(
                                      label: "Opening hours",
                                      validate: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "opening hours field is required";
                                        }

                                        return null;
                                      },
                                      onTap: () async {
                                        TimeOfDay? time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                                        if (time != null) {
                                          openingController.text = Constants.getFormattedTime(time);
                                        }
                                      },
                                      textEditingController: openingController,
                                      readOnly: true,
                                      trailingIcon: Icon(Icons.access_time, color: CustomTheme.iconColor),
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Flexible(
                                    flex: 1,
                                    child: InputFieldWidget(
                                      label: "Closing hours",
                                      readOnly: true,
                                      validate: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "closing hours field is required";
                                        }

                                        return null;
                                      },
                                      onTap: () async {
                                        TimeOfDay? time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                                        if (time != null) {
                                          closingController.text = Constants.getFormattedTime(time);
                                        }
                                      },
                                      textEditingController: closingController,
                                      trailingIcon: Icon(Icons.access_time, color: CustomTheme.iconColor),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.rh),
                              Text("Select working days", style: Get.textTheme.displaySmall),
                              SizedBox(height: 10.rh),
                              SizedBox(
                                  height: 6.5.mv,
                                  child: WorkingDayWidget(
                                    callback: (data) => workingDays = data,
                                  )),
                              SizedBox(height: 10.rh),
                              InputFieldWidget(
                                readOnly: true,
                                onTap: () async {
                                  /*  TimeOfDay? time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                                      if (time != null) {
                                        closingController.text = "${time.hourOfPeriod}:${time.minute} ${time.period.name.toUpperCase()}";
                                      } */

                                  List<Sport>? list = await Get.bottomSheet<List<Sport>?>(
                                    Padding(
                                      padding: EdgeInsets.only(top: 50.rh),
                                      child: SportsBottomSheet(selectedList: selectedSports),
                                    ),
                                    enableDrag: true,
                                    isScrollControlled: true,
                                    ignoreSafeArea: false,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10.br))),
                                  );

                                  if (list != null) {
                                    selectedSports.assignAll(list);
                                    selectedSports.refresh();
                                  }
                                  log("Selected sportsList $list");
                                },
                                textEditingController: selectSportsController,
                                leadingIcon: Image.asset('assets/icons/football.png'),
                                trailingIcon: Icon(Icons.keyboard_arrow_down_sharp, color: CustomTheme.textColorLight),
                              ),
                              const SizedBox(height: 4.0),
                              Text("Select the sport you want to coach", style: Get.textTheme.displaySmall!.copyWith(color: CustomTheme.textColor2)),
                              const SizedBox(height: 16.0),
                              Obx(() {
                                return SizedBox(
                                  height: Constants.getheight(selectedSports.length),
                                  child: GridView.builder(
                                    itemCount: selectedSports.length,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return SelectionChip(
                                        isAdded: true,
                                        index: index,
                                        sportModel: selectedSports[index],
                                        onRemove: () {
                                          selectedSports.removeAt(index);
                                          selectedSports.refresh();
                                        },
                                      );
                                    },
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 3 / 4,
                                      mainAxisExtent: 40.rh,
                                      mainAxisSpacing: 8.0,
                                      crossAxisSpacing: 4.0,
                                    ),
                                  ),
                                );
                              }),
                              const SizedBox(height: 24.0),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: CustomTheme.borderColor),
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Material(
                                  color: Colors.white,
                                  elevation: 4,
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text("Long term booking", style: Get.textTheme.labelMedium),
                                              const SizedBox(width: 5),
                                              Tooltip(
                                                margin: EdgeInsets.only(left: 20, right: 20),
                                                key: tooltipKey,
                                                message: 'This is a suggestion text.',
                                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                                textStyle: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.black.withOpacity(0.7),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                preferBelow: false,
                                                child: InkWell(
                                                  onTap: () {
                                                    tooltipKey.currentState?.ensureTooltipVisible();
                                                  },
                                                  child: const Icon(
                                                    CupertinoIcons.exclamationmark_circle_fill,
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                              const Spacer(),
                                              Obx(() {
                                                return Switch(
                                                  value: profileController.isLongTerm.value,
                                                  activeTrackColor: CustomTheme.green,
                                                  onChanged: (value) {
                                                    profileController.isLongTerm.value = value;
                                                  },
                                                );
                                              }),
                                            ],
                                          ),
                                        ),
                                        Material(
                                            borderOnForeground: true,
                                            borderRadius: BorderRadius.circular(8.0),
                                            color: CustomTheme.bocLightBackground,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text("Long term booking discount", style: Get.textTheme.labelMedium),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: SizedBox(
                                                      width: constraints.maxWidth * 0.15,
                                                      child: Obx(() {
                                                        return InputFieldWidget(
                                                          hint: "0",
                                                          suffixText: "%",
                                                          readOnly: !profileController.isLongTerm.value,
                                                          maxlength: 2,
                                                          inputType: TextInputType.number,
                                                          textColor: CustomTheme.green,
                                                          textEditingController: discountC,
                                                          onChange: (value) {
                                                            if (value.isNotEmpty && double.parse(value) > 40) {
                                                              discountC.text = "40";
                                                              Get.dialog(Center(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                                                                  child: Material(
                                                                    borderRadius: BorderRadius.circular(16.0),
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(20.0),
                                                                      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                                                        Text("You can't add discount more than 40% ", style: Get.textTheme.labelMedium),
                                                                        const SizedBox(height: 16.0),
                                                                        Divider(color: CustomTheme.borderColor),
                                                                        InkWell(
                                                                          onTap: () => Get.back(),
                                                                          child: Row(
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                                                                child: Text("OK", style: Get.textTheme.headlineSmall),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ]),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ));
                                                            }
                                                          },
                                                        );
                                                      }),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24.0),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                                child: MyButton(
                                  text: "Next",
                                  // onPressed: () => Get.to(() => const UploadMediaScreen()),
                                  onPressed: () async {
                                    if (image == null) {
                                      Constants.showSnackbar("Error", "Select profile picture");

                                      return;
                                    }
                                    if (_formKey.currentState!.validate()) {
                                      controller.loading.value = true;
                                      requestModel = AddVenueDetailsRequestModel(
                                          name: venueController.text,
                                          address: addressController.text,
                                          openingHour: openingController.text,
                                          closingHour: closingController.text,
                                          workingDays: "${workingDays.map((x) => x.toJson()).toList()}",
                                          sports: selectedSports.map((element) => element.id).toList().join(","),
                                          longTermBooking: homeController.isLongTerm.value ? "1" : "0",
                                          numberOfGrounds: numberOfGroundC.text,
                                          ratings: "0",
                                          wishlist: "1");
                                      venue.VenueDetailsModel? value = await controller.venueService
                                          .addVenueDetails(image!, controller.loginDataModel.value!.data!.user.token, requestModel!, addNewVenue: widget.addAnotherVenue);
                                      if (value != null && value.data != null && value.httpCode == 200) {
                                        venueController.clear();
                                        addressController.clear();
                                        openingController.clear();
                                        closingController.clear();
                                        selectedSports.clear();
                                        workingDays.clear();
                                        numberOfGroundC.clear();
                                        // controller.currentVenue.value ??= value;
                                        venue.VenueDetailsModel? newVenueData = await controller.venueService.getVenueDetails(profileController.bearer, "${value.data!.venue.id}");
                                        controller.getVenuesListData();
                                        log("results from venue details: ${value.toJson()}");
                                        Constants.showSnackbar("Success", value.message);

                                        if (!widget.addAnotherVenue) {
                                          controller.currentVenue.value = newVenueData;
                                          controller.currentVenue.refresh();
                                        }

                                        if (!widget.addAnotherVenue) {
                                          Get.to(() => const UploadMediaScreen());
                                        } else {
                                          if (Get.isSnackbarOpen) {
                                            Get.back();
                                          }
                                          Future.delayed(
                                            const Duration(seconds: 1),
                                            () {
                                              Get.back();
                                            },
                                          );
                                        }
                                      } else if (value != null) {
                                        Constants.showSnackbar("Error", value.message);
                                      }
                                      print("${numberOfGroundC.text}");
                                      controller.loading.value = false;
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: constraints.maxHeight * 0.2)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                controller.loading.value
                    ? Container(
                        color: Colors.white54,
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                        child: const Center(child: CircularProgressIndicator()),
                      )
                    : const SizedBox(),
              ],
            );
          });
        }),
      ),
    );
  }

  void checkForPermissions() async {
    final permissionStatus = await Permission.locationWhenInUse.status;
    if (!permissionStatus.isGranted) {
      final status = await Permission.locationWhenInUse.request();
      if (!status.isGranted) {
        Constants.showSnackbar("Permission Error", "Location permissions should be granted in order to continue with address");
      }
    }
  }
}
