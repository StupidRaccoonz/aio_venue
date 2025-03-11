import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/models/venue_details_model.dart' as venue_details;
import 'package:aio_sport/models/sports_data_model.dart' as sport;
import 'package:aio_sport/screens/venue/venue_place_picker_screen.dart';
import 'package:aio_sport/services/server_urls.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/app_bar_widget.dart';
import 'package:aio_sport/widgets/image_widget.dart';
import 'package:aio_sport/widgets/input_field_widget.dart';
import 'package:aio_sport/widgets/my_button.dart';
import 'package:aio_sport/widgets/selection_chip_widget.dart';
import 'package:aio_sport/widgets/working_venue_days.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

import '../../models/venue_details_model.dart';

class ShowVenueDetailsScreen extends StatefulWidget {
  const ShowVenueDetailsScreen({super.key});

  @override
  State<ShowVenueDetailsScreen> createState() => _ShowVenueDetailsScreenState();
}

class _ShowVenueDetailsScreenState extends State<ShowVenueDetailsScreen> {
  final addressController = TextEditingController();

  final venueController = TextEditingController();

  final selectSportsController = TextEditingController();

  final openingController = TextEditingController();

  final closingController = TextEditingController();
  final noOfGroundsController = TextEditingController();

  List<WorkingDay> workingDays = [
    WorkingDay.fromJson({"day": "Monday", "status": "false"}),
    WorkingDay.fromJson({"day": "Tuesday", "status": "false"}),
    WorkingDay.fromJson({"day": "Wednesday", "status": "false"}),
    WorkingDay.fromJson({"day": "Thursday", "status": "false"}),
    WorkingDay.fromJson({"day": "Friday", "status": "false"}),
    WorkingDay.fromJson({"day": "Saturday", "status": "false"}),
    WorkingDay.fromJson({"day": "Sunday", "status": "false"})
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomTheme.bocLightBackground,
      appBar: PreferredSize(
          preferredSize: Size(double.maxFinite, 10.vh),
          child: AppbarWidget(
              title: "Venue details",
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back_rounded, color: Colors.white), onPressed: () => Get.back()))),
      body: LayoutBuilder(builder: (context, constraints) {
        return GetX<ProfileController>(builder: (controller) {
          venue_details.Venue venue = controller.currentVenue.value!.data!.venue;
          if (venue.workingDays != null && venue.workingDays!.isNotEmpty) {
            workingDays = venue.workingDays!;
          }

          addressController.text = venue.address;
          venueController.text = venue.name;
          openingController.text = venue.openingHour;
          closingController.text = venue.closingHour;
          noOfGroundsController.text = venue.numberOfGrounds.toString();
          print("kajal hereee ${venue.latitude}");
          //   calenderController.text = ;
          DateTime dateTime = DateTime.parse(venue.createdAt.toIso8601String());
          DateTime localDateTime = dateTime.toLocal();

          // Manually format the date to yyyy-MM-dd
          String formattedDate =
              "${localDateTime.year}-${localDateTime.month.toString().padLeft(2, '0')}-${localDateTime.day.toString().padLeft(2, '0')}";

          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5.rh),
                    Expanded(
                      child: ListView(
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(constraints.maxHeight * 0.1),
                                child: ImageWidget(
                                  imageurl:
                                      "${ServerUrls.mediaUrl}venue/${controller.currentVenue.value?.data?.venue.profilePicture}",
                                  height: constraints.maxHeight * 0.15,
                                  width: constraints.maxHeight * 0.15,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                          SizedBox(height: 5.rh),
                          InputFieldWidget(
                            label: "Venue Name",
                            //  initalValue: venue.name,
                            //readOnly: true,
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return "venue name is required";
                              }
                              return null;
                            },
                            textEditingController: venueController,
                            leadingIcon: Image.asset('assets/icons/stadium.png'),
                          ),
                          SizedBox(height: 5.rh),
                          InputFieldWidget(
                            label: "Address",
                            //   initalValue: venue.address ?? "",
                            //  readOnly: true,
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return "address field is required";
                              }
                              return null;
                            },
                            textEditingController: addressController,
                            trailingIcon: InkWell(
                                onTap: () {
                                  Get.to(PlacePickerScreen())!.then((value) {
                                    addressController.text = value;
                                  });
                                },
                                child: Image.asset('assets/icons/location.png')),
                            leadingIcon: Image.asset('assets/icons/location.png'),
                          ),
                          SizedBox(height: 5.rh),
                          InputFieldWidget(
                            readOnly: true,
                            onTap: () async {},
                            leadingIcon: Image.asset('assets/icons/calender.png'),
                            initalValue: "${formattedDate}",
                            //   trailingIcon: Icon(Icons.calendar_month, color: CustomTheme.iconColor),
                          ),
                          SizedBox(height: 5.rh),
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: InputFieldWidget(
                                  label: "Opening hours",
                                  //   initalValue: venue.openingHour,
                                  validate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "opening hours field is required";
                                    }
                                    return null;
                                  },
                                  onTap: () async {
                                    TimeOfDay? time =
                                        await showTimePicker(context: context, initialTime: TimeOfDay.now());
                                    if (time != null) {
                                      openingController.text =
                                          "${time.hourOfPeriod}:${time.minute} ${time.period.name.toUpperCase()}";
                                    }
                                  },
                                  leadingIcon: Icon(Icons.access_time, color: CustomTheme.iconColor),
                                  textEditingController: openingController,
                                  readOnly: true,
                                  //trailingIcon: Icon(Icons.access_time, color: CustomTheme.iconColor),
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              Flexible(
                                flex: 1,
                                child: InputFieldWidget(
                                  label: "Closing hours",
                                  //  initalValue: venue.closingHour,
                                  readOnly: true,
                                  validate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "closing hours field is required";
                                    }
                                    return null;
                                  },
                                  onTap: () async {
                                    TimeOfDay? time =
                                        await showTimePicker(context: context, initialTime: TimeOfDay.now());
                                    if (time != null) {
                                      closingController.text =
                                          "${time.hourOfPeriod}:${time.minute} ${time.period.name.toUpperCase()}";
                                    }
                                  },
                                  textEditingController: closingController,
                                  leadingIcon: Icon(Icons.access_time, color: CustomTheme.iconColor),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.rh),
                          InputFieldWidget(
                            label: "Number of grounds",
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return "number of ground is required";
                              }

                              return null;
                            },
                            inputType: TextInputType.number,
                            textEditingController: noOfGroundsController,
                            leadingIcon: Image.asset('assets/icons/football.png'),
                          ),
                          SizedBox(height: 10.rh),
                          Text("Select working days", style: Get.textTheme.displaySmall),
                          SizedBox(height: 10.rh),
                          SizedBox(
                              height: 6.5.mv,
                              child: WorkingDayWidget(
                                callback: (data) => workingDays = data,
                                venueWorkingDays: workingDays,
                              )),
                          SizedBox(height: 10.rh),
                          InputFieldWidget(
                            readOnly: true,
                            onTap: () async {},
                            onTrailingTap: () async {},
                            //textEditingController: selectSportsController,
                            leadingIcon: Image.asset('assets/icons/football.png'),
                            initalValue: "Selected sports",
                            trailingIcon: Icon(Icons.keyboard_arrow_down_sharp, color: CustomTheme.textColorLight),
                          ),
                          const SizedBox(height: 4.0),
                          Text("Select the sport you want to coach", style: Get.textTheme.displaySmall),
                          const SizedBox(height: 16.0),
                          SizedBox(
                            height: Constants.getheight(venue.sports?.length ?? 0),
                            child: GridView.builder(
                              itemCount: venue.sports?.length ?? 0,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return SelectionChip(
                                    isAdded: true,
                                    index: index,
                                    sportModel: sport.Sport.fromJson(venue.sports![index].toJson()));
                              },
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 3 / 4,
                                mainAxisExtent: 40.rh,
                                mainAxisSpacing: 8.0,
                                crossAxisSpacing: 4.0,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24.0),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: CustomTheme.textColorLight),
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
                                          Text("Long term booking", style: Get.textTheme.bodyMedium),
                                          const Spacer(),
                                          Switch(
                                              activeTrackColor: CustomTheme.green,
                                              value: true,
                                              onChanged: (value) {
                                                // profileController.isLongTerm.value = value;
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
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child:
                                                  Text("Long term booking discount", style: Get.textTheme.labelMedium),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                  "${controller.currentVenue.value?.data?.venue.longTermBooking}%",
                                                  style: Get.textTheme.labelMedium!.copyWith(color: CustomTheme.green)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                            child: MyButton(
                              text: "Save changes",
                              // onPressed: () => Get.to(() => const UploadMediaScreen()),
                              onPressed: () async {
                                controller.loading.value = true;
                                /* requestModel = AddVenueDetailsRequestModel(
                                    name: venueController.text,
                                    address: addressController.text,
                                    openingHour: openingController.text,
                                    closingHour: closingController.text,
                                    workingDays: workingDays.map((x) => x.toJson()).toList().toString(),
                                    sports: profileController.selectedSportsList.map((element) => element.id).toList().join(","),
                                    longTermBooking: homeController.isLongTerm.value ? "1" : "0",
                                    numberOfGrounds: numberOfGroundC.text,
                                    ratings: "0",
                                    wishlist: "1");
                                venue_details.VenueDetailsModel? value =
                                    await controller.venueService.addVenueDetails(image!, controller.loginDataModel.value!.data!.user.token, requestModel!);
                                if (value != null && value.data != null && value.httpCode == 200) {
                                  controller.currentVenue.value ??= value;
                                  venue.VenueDetailsModel? newVenueData =
                                      await controller.venueService.getVenueDetails(profileController.bearer, "${value.data!.venue.id}");
                                  controller.getVenuesListData();
                                  log("results from venue details: ${value.toJson()}");
                                  Constants.showSnackbar("Success", value.message);
                                  controller.currentVenue.value = newVenueData;

                                  controller.currentVenue.refresh(); 

                                  // Get.to(() => const UploadMediaScreen());
                                } else if (value != null) {
                                  Constants.showSnackbar("Error", value.message);
                                }
                                  */

                                await controller.venueService
                                    .updateVenueDetails(controller.loginDataModel.value!.data!.user.token, {
                                  "name": venueController.text,
                                  "address": addressController.text,
                                  "opening_hour": openingController.text,
                                  "closing_hour": closingController.text,
                                  "venue_id": venue.id,
                                  "numberOfGrounds": noOfGroundsController.text,
                                  "working_days": workingDays.map((x) => x.toJson()).toList(),
                                  "sports": venue.sports!.map((element) => element.id).toList().join(","),
                                });
                                await controller.venueService.getVenueDetails(controller.bearer, venue.id.toString());
                                controller.update();
                                controller.loading.value = false;
                                setState(() {});
                              },
                            ),
                          )
                        ],
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
    );
  }
}
