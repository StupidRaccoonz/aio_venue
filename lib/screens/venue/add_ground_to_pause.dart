import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/controllers/veneue_manager_controller.dart';
import 'package:aio_sport/models/pause_ground_request_model.dart';
import 'package:aio_sport/models/sports_data_model.dart' as sport_data;
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/app_bar_widget.dart';
import 'package:aio_sport/widgets/my_button.dart';
import 'package:aio_sport/widgets/my_text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../models/venue_details_model.dart';

class AddGroundToPauseScreen extends StatefulWidget {
  const AddGroundToPauseScreen({super.key});

  @override
  State<AddGroundToPauseScreen> createState() => _AddGroundToPauseScreenState();
}

class _AddGroundToPauseScreenState extends State<AddGroundToPauseScreen> {
  final manager = Get.find<VenueManagerController>();
  final profileController = Get.find<ProfileController>();
  late sport_data.Sport sport;
  late Ground ground;
  PauseGroundRequestModel? requestModel;
  List<sport_data.Sport> get sportsList => profileController.selectedSportsList;

  // Using a `LinkedHashSet` is recommended due to equality comparison override

  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  // Using a `LinkedHashSet` is recommended due to equality comparison override
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  @override
  void dispose() {
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
      // Update values in a Set
      if (_selectedDays.contains(selectedDay)) {
        _selectedDays.remove(selectedDay);
      } else {
        _selectedDays.add(selectedDay);
      }
      log("_onDaySelected: ${_selectedDays.join(",")}");
    });
  }

  @override
  void initState() {
    super.initState();
    if (profileController.venueSports.isNotEmpty) {
      sport = profileController.venueSports.first!;
      ground = manager.selectedVenue.value.data!.venue.grounds.first;
      setState(() {});
    } else {
      Get.back();
      Constants.showSnackbar("Sorry", "no selected sport found in this venue");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Constants.backgroundDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size(double.maxFinite, 10.vh),
          child: AppbarWidget(
              title: "Add to pause list",
              leading: IconButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xff303345)),
                    shape: MaterialStateProperty.all(CircleBorder()),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ))),
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          return Obx(() {
            // manager.selectedVenue.value.data!.venue.grounds.where((element) => element.sportsId == sport.id).toList());

            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Select Sport", style: Get.textTheme.displayMedium),
                        const SizedBox(height: 10.0),
                        Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              side: const BorderSide(width: 0.5, color: Colors.teal)),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                            child: DropdownButton<sport_data.Sport>(
                              value: sport,
                              isExpanded: true,
                              underline: const SizedBox(),
                              icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 30.0),
                              items: profileController.venueSports
                                  .map<DropdownMenuItem<sport_data.Sport>>(
                                      (e) => DropdownMenuItem<sport_data.Sport>(value: e, child: Text("${e?.name}")))
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  sport = value;
                                  setState(() {});
                                  // sport = profileController.selectedSportsList.firstWhere((element) => element.name == value);
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Text("Select Ground", style: Get.textTheme.displayMedium),
                        const SizedBox(height: 10.0),
                        Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              side: const BorderSide(width: 0.5, color: Colors.teal)),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                            child: DropdownButton<Ground>(
                              value: ground,
                              isExpanded: true,
                              underline: const SizedBox(),
                              icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 30.0),
                              items: manager.selectedVenue.value.data!.venue.grounds
                                  .map<DropdownMenuItem<Ground>>(
                                      (e) => DropdownMenuItem<Ground>(value: e, child: Text(e.name ?? "Name N/A")))
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  ground = value;
                                  setState(() {});
                                  // sport = profileController.selectedSportsList.firstWhere((element) => element.name == value);
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        TableCalendar(
                          firstDay: DateTime.now(),
                          lastDay: DateTime.utc(2030, 12, 31),
                          focusedDay: _focusedDay,
                          calendarFormat: _calendarFormat,
                          onDaySelected: _onDaySelected,
                          daysOfWeekHeight: 40,
                          onFormatChanged: (format) {},
                          /* calendarStyle: CalendarStyle(
                                    selectedTextStyle: Get.textTheme.bodySmall!.copyWith(color: Colors.white),
                                    defaultDecoration: BoxDecoration(
                                      color: CustomTheme.cherryRed,
                                      borderRadius: BorderRadius.circular(12),
                                    )), */
                          selectedDayPredicate: (day) {
                            // Use values from Set to mark multiple days as selected
                            return _selectedDays.contains(day);
                          },
                        ),
                        const SizedBox(height: 60.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Center(
                              child: MyTextButton(
                                width: constraints.maxWidth * 0.4,
                                height: 60.0,
                                onPressed: () {
                                  _selectedDays.clear();
                                  setState(() {});
                                },
                                text: "Reset",
                              ),
                            ),
                            Center(
                              child: MyButton(
                                text: "Pause ground",
                                textStyle: Get.textTheme.titleSmall!.copyWith(color: Colors.white),
                                width: constraints.maxWidth * 0.4,
                                height: 60.0,
                                onPressed: () async {
                                  manager.loading.value = true;
                                  List<Map<String, dynamic>> selectedDatesJson =
                                      _selectedDays.map((e) => AvailabilitiesData(date: e).toJson()).toList();

                                  final data = await manager.venueService.addGroundToPausing(
                                      profileController.bearer,
                                      PauseGroundRequestModel(
                                          venueId: "${ground.venueId}",
                                          sportsId: "${sport.id}",
                                          groundId: "${ground.id}",
                                          availabilitiesData: jsonEncode(selectedDatesJson)));
                                  await manager.venueService.getPausedGrounds();
                                  manager.loading.value = false;
                                  if (data?.httpCode == 200) {
                                    Constants.showSnackbar("Result", data!.message);
                                    Get.back();
                                  }
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                manager.loading.value
                    ? Container(
                        color: Colors.white54,
                        child: Center(child: CircularProgressIndicator(color: CustomTheme.appColor)),
                      )
                    : const SizedBox(),
              ],
            );
          });
        }),
      ),
    );
  }
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}
