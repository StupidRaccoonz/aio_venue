import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/models/pause_ground_request_model.dart';
import 'package:aio_sport/screens/venue/venue_create_activity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scaled_size/scaled_size.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_button.dart';

class EditPauseSettingScreen extends StatefulWidget {
  const EditPauseSettingScreen({super.key});

  @override
  State<EditPauseSettingScreen> createState() => _EditPauseSettingScreenState();
}

class _EditPauseSettingScreenState extends State<EditPauseSettingScreen> {
  int _selectedYear = DateTime.now().year;
  int _selectedMonth = DateTime.now().month;

  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  // Using a `LinkedHashSet` is recommended due to equality comparison override

  Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );
  final profileController = Get.find<ProfileController>();

  late int pausedGroundId;
  // DateTime _focusedDay = DateTime.now();
  // DateTime? _selectedDay;

  @override
  void dispose() {
    super.dispose();
  }

  bool isLeapYear(int year) {
    if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) {
      return true; // Leap year
    }
    return false; // Not a leap year
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      pausedGroundId = Get.arguments;
      var pausedGroundDetails = await profileController.venueService.getPausedGroundsDetails(pausedGroundId);
      Set<DateTime> pausedDates = pausedGroundDetails!.data.pausedbooking
          .map((booking) => DateTime(booking.date.year, booking.date.month, booking.date.day))
          .toSet();
      _selectedDays.addAll(pausedDates);
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 10.vh),
        child: AppbarWidget(
            title: "Pause Booking",
            leading: IconButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xff303345)),
                  shape: MaterialStateProperty.all(CircleBorder()),
                ),
                onPressed: () async {
                  await profileController.venueService.getPausedGrounds();
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ))),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Paused grounds", style: Get.textTheme.displayLarge),
                  const SizedBox(height: 20.0),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffE9E8EB)), borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Month",
                                    style: TextStyle(color: Color(0xff6E6F73), fontSize: screenHeight * 0.025),
                                  ),
                                  DropdownButton<int>(
                                    value: _selectedMonth,
                                    items: List.generate(12, (index) => index + 1)
                                        .map((month) => DropdownMenuItem(
                                              value: month,
                                              child: Text(DateFormat.MMMM().format(DateTime(0, month)),
                                                  style: TextStyle(
                                                      color: Color(0xff15192C), fontSize: screenHeight * 0.03)),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedMonth = value!;
                                        // Adjust for the selected year and month
                                        _focusedDay = DateTime(_selectedYear, _selectedMonth, 1);
                                      });
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Year",
                                    style: TextStyle(color: Color(0xff6E6F73), fontSize: screenHeight * 0.025),
                                  ),
                                  DropdownButton<int>(
                                    value: _selectedYear,
                                    items: List.generate(10, (index) => DateTime.now().year + index)
                                        .map((year) => DropdownMenuItem(
                                              value: year,
                                              child: Text(year.toString(),
                                                  style: TextStyle(
                                                      color: Color(0xff15192C), fontSize: screenHeight * 0.03)),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedYear = value!;
                                        // Adjust for the selected month
                                        _focusedDay = DateTime(_selectedYear, _selectedMonth, 1);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // TableCalendar(
                        //   firstDay: DateTime.utc(2020, 1, 1),
                        //   lastDay: DateTime.utc(2030, 12, 31),
                        //   focusedDay: _focusedDay,
                        //   selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                        //   onDaySelected: (selectedDay, focusedDay) {
                        //     setState(() {
                        //       _selectedDay = selectedDay;
                        //       _focusedDay = focusedDay;
                        //     });
                        //   },
                        //   startingDayOfWeek: StartingDayOfWeek.monday, // Start week from Monday
                        //   daysOfWeekVisible: true, // Display week names
                        //   // daysOfWeekStyle: DaysOfWeekStyle(
                        //     // decoration: const BoxDecoration(color: Colors.white),
                        //     // weekdayStyle: const TextStyle(
                        //     //   color: Colors.black,
                        //     //   fontWeight: FontWeight.bold,
                        //     //   fontSize: 14,
                        //     // ),
                        //     // weekendStyle: const TextStyle(
                        //     //   color: Colors.red,
                        //     //   fontWeight: FontWeight.bold,
                        //     //   fontSize: 14,
                        //     // ),
                        //   // ),
                        //   calendarStyle: CalendarStyle(
                        //     todayDecoration: BoxDecoration(
                        //       color: Colors.grey.shade200,
                        //       shape: BoxShape.circle,
                        //     ),
                        //     selectedDecoration: BoxDecoration(
                        //       color: Colors.red,
                        //       shape: BoxShape.circle,
                        //     ),
                        //     defaultTextStyle: const TextStyle(color: Colors.black),
                        //     weekendTextStyle: const TextStyle(color: Colors.black),
                        //   ),
                        //   headerVisible: false, // Hide default header
                        // ),
                        TableCalendar(
                          headerVisible: false,
                          firstDay: DateTime.now(),
                          lastDay: DateTime.utc(2030, 12, 31),
                          focusedDay: _focusedDay,
                          calendarFormat: _calendarFormat,
                          onDaySelected: _onDaySelected,
                          daysOfWeekHeight: 40,
                          onPageChanged: (focusedDay) {
                            setState(() {
                              _focusedDay = focusedDay;
                              _selectedMonth = _focusedDay.month;
                              _selectedYear = _focusedDay.year;
                            });
                          },
                          onFormatChanged: (format) {},
                          /* calendarStyle: CalendarStyle(
                                      selectedTextStyle: Get.textTheme.bodySmall!.copyWith(color: Colors.white),
                                      defaultDecoration: BoxDecoration(
                                        color: CustomTheme.cherryRed,
                                        borderRadius: BorderRadius.circular(12),
                                      )), */
                          startingDayOfWeek: StartingDayOfWeek.monday, // Start week from Monday
                          daysOfWeekVisible: true,
                          calendarStyle: CalendarStyle(
                            todayDecoration: BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                            ),
                            selectedDecoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            defaultTextStyle: const TextStyle(color: Colors.black),
                            weekendTextStyle: const TextStyle(color: Colors.black),
                          ),
                          selectedDayPredicate: (day) {
                            // Use values from Set to mark multiple days as selected
                            return _selectedDays.contains(day);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      LegendItem(color: Colors.red, text: 'Paused date'),
                      LegendItem(color: Colors.black, text: 'Don\'t have any booking'),
                      LegendItem(color: Colors.grey, text: 'Can\'t be paused on this date'),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: MyTextButton(
                          width: constraints.maxWidth * 0.4,
                          height: 60.0,
                          onPressed: () {
                            _selectedDays = LinkedHashSet<DateTime>(
                              equals: isSameDay,
                              hashCode: getHashCode,
                            );
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
                              List<Map<String, dynamic>> selectedDatesJson =
                                  _selectedDays.map((e) => AvailabilitiesData(date: e).toJson()).toList();
                              final data = await profileController.venueService.addGroundToPausing(
                                profileController.bearer,
                                PauseGroundRequestModel(
                                    venueId: "${profileController.venueId}",
                                    sportsId: "${profileController.venueSports.first!.id}",
                                    groundId: "${pausedGroundId}",
                                    availabilitiesData: jsonEncode(selectedDatesJson)),
                              );
                            }),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
