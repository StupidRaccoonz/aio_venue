import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/controllers/veneue_manager_controller.dart';
import 'package:aio_sport/models/sports_data_model.dart';
import 'package:aio_sport/models/venue_create_activity_req_model.dart';
import 'package:aio_sport/models/venue_details_model.dart' as venue;
import 'package:aio_sport/screens/common/thaiwan_pay_screen.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/app_bar_widget.dart';
import 'package:aio_sport/widgets/input_field_widget.dart';
import 'package:aio_sport/widgets/my_button.dart';
import 'package:aio_sport/widgets/select_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:scaled_size/scaled_size.dart';
import 'package:table_calendar/table_calendar.dart';

class VenueCreateActivityScreen extends StatefulWidget {
  const VenueCreateActivityScreen({super.key});

  @override
  State<VenueCreateActivityScreen> createState() => _VenueCreateActivityScreenState();
}

class _VenueCreateActivityScreenState extends State<VenueCreateActivityScreen> {
  DateTime dateTime = DateTime.now();
  DateTime dateTimeNow = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  final CalendarFormat _calendarFormat = CalendarFormat.month;

  // Using a `LinkedHashSet` is recommended due to equality comparison override
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );
  final venueController = Get.find<ProfileController>();
  final manager = Get.find<VenueManagerController>();
  final registrationFeeC = TextEditingController();
  final winningPriceC = TextEditingController();
  final rulesC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> selectedSlots = [];

  RxList<String> rules = <String>[].obs;
  late Rx<venue.Ground> selectedGroundData;
  Rx<bool> isAM = true.obs;
  late Sport sport;

  // final registrationFeeC = TextEditingController();
  late VenueCreateActivityRequestModel requestModel;

  @override
  void initState() {
    manager.selectedSport = Rx(venueController.selectedSportsList.first.name);
    sport = venueController.selectedSportsList.first;
    selectedGroundData = venueController.currentVenue.value!.data!.venue.grounds.firstWhere((element) => element.sportsId == sport.id).obs;

    manager.selectedDate.value = dateTime.day;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.maxFinite, 10.vh),
          child: AppbarWidget(
            title: "Create Activity",
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          )),
      body: LayoutBuilder(builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          child: Obx(() {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Select date", style: Get.textTheme.displayMedium),
                            const Spacer(),
                            InkWell(
                              onTap: () async {
                                final datePicked = await showDatePicker(context: context, initialDate: dateTime, firstDate: DateTime.now(), lastDate: DateTime(2030, 12, 31));
                                if (datePicked != null) {
                                  dateTime = datePicked;
                                  manager.selectedDate.value = dateTime.day;
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.calendar_month_rounded, color: CustomTheme.iconColor),
                                    const SizedBox(width: 8.0),
                                    Text(Constants.monthToString(dateTime.month), style: Get.textTheme.headlineSmall),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Date selections start
                        // SizedBox(height: constraints.maxHeight * 0.15, child: CalenderWidget(selectedDate: dateTime)),
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
                        // date selection end

                        // time seletion start
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Select time", style: Get.textTheme.displayMedium),
                            const Spacer(),
                            Material(
                              color: isAM.value ? CustomTheme.iconColor : Colors.white,
                              child: InkWell(
                                onTap: () => isAM.value = true,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("AM",
                                      style: Get.textTheme.headlineSmall!.copyWith(
                                        color: isAM.value ? Colors.white : CustomTheme.iconColor,
                                      )),
                                ),
                              ),
                            ),
                            Material(
                              color: isAM.value ? Colors.white : CustomTheme.iconColor,
                              child: InkWell(
                                onTap: () => isAM.value = false,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("PM",
                                      style: Get.textTheme.headlineSmall!.copyWith(
                                        color: isAM.value ? CustomTheme.iconColor : Colors.white,
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        isAM.value
                            ? SizedBox(
                                height: constraints.maxHeight * 0.24,
                                child: SelectTimeWidget(
                                  itemCount: 6,
                                  startingIndexValue: 6,
                                  removingZeroAtIndex: 4,
                                  callback: (val) {
                                    selectedSlots = val;
                                    log("selected time slots $selectedSlots");
                                  },
                                ),
                              )
                            : SizedBox(
                                height: constraints.maxHeight * 0.24,
                                child: SelectTimeWidget(
                                  itemCount: 10,
                                  startingIndexValue: 0,
                                  removingZeroAtIndex: 10,
                                  callback: (val) {
                                    selectedSlots = val;
                                    log("selected time slots $selectedSlots");
                                  },
                                ),
                              ),
                        // time seletion end

                        const SizedBox(height: 16.0),
                        Text("Select sport", style: Get.textTheme.displayMedium),
                        const SizedBox(height: 16.0),
                        Material(
                          color: Colors.white,
                          elevation: 1,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0), side: BorderSide(width: 0.5, color: CustomTheme.borderColor)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: DropdownButton<String>(
                              value: manager.selectedSport.value,
                              isExpanded: true,
                              underline: const SizedBox(),
                              icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 30.0),
                              items: venueController.selectedSportsList.map<DropdownMenuItem<String>>((e) => DropdownMenuItem(value: e.name, child: Text(e.name))).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  manager.selectedSport.value = value;
                                  sport = venueController.selectedSportsList.firstWhere((element) => element.name == value);
                                  if (venueController.currentVenue.value!.data!.venue.grounds.any((element) => element.sportsId == sport.id)) {
                                    selectedGroundData.value = venueController.currentVenue.value!.data!.venue.grounds.firstWhere((element) => element.sportsId == sport.id);
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Text("Select ground", style: Get.textTheme.displayMedium),
                        const SizedBox(height: 16.0),
                        Material(
                          color: Colors.white,
                          elevation: 1,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0), side: BorderSide(width: 0.5, color: CustomTheme.borderColor)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: DropdownButton<venue.Ground>(
                              value: selectedGroundData.value,
                              isExpanded: true,
                              underline: const SizedBox(),
                              icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 30.0),
                              items: venueController.currentVenue.value!.data!.venue.grounds.where((element) => element.sportsId == sport.id).map<DropdownMenuItem<venue.Ground>>((e) => DropdownMenuItem<venue.Ground>(value: e, child: Text("${e.name}"))).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  selectedGroundData.value = value;
                                  // sport = venueController.selectedSportsList.firstWhere((element) => element.name == value);
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),

                        Text("Team required ?", style: Get.textTheme.displayMedium),
                        const SizedBox(height: 16.0),
                        Material(
                          color: Colors.white,
                          elevation: 1,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0), side: BorderSide(width: 0.5, color: CustomTheme.borderColor)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                RadioListTile(
                                  value: false,
                                  groupValue: manager.teamChallange.value,
                                  onChanged: (value) {
                                    if (value != null) {
                                      manager.teamChallange.value = value;
                                    }
                                  },
                                  title: Text("No, Single player challenge", style: Get.textTheme.bodySmall),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                  child: Divider(),
                                ),
                                RadioListTile(
                                  value: true,
                                  groupValue: manager.teamChallange.value,
                                  onChanged: (value) {
                                    if (value != null) {
                                      manager.teamChallange.value = value;
                                    }
                                  },
                                  title: Text("Yes, Team challenge", style: Get.textTheme.bodySmall),
                                ),
                                Obx(() {
                                  return manager.teamChallange.value
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Material(
                                            elevation: 1,
                                            color: CustomTheme.bocLightBackground,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0), side: BorderSide(width: 0.5, color: CustomTheme.borderColor)),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                                              child: Row(
                                                children: [
                                                  Expanded(child: Text("How many players in each team?", style: TextStyle(color: Color(0xff6E6F73), fontSize: 16, fontWeight: FontWeight.bold))),
                                                  //  Get.textTheme.displaySmall,
                                                  const SizedBox(width: 8.0),
                                                  Material(
                                                      color: Colors.white,
                                                      elevation: 2.0,
                                                      borderRadius: BorderRadius.circular(4.0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          if (manager.numberOfPlayers.value > 0) {
                                                            manager.numberOfPlayers.value--;
                                                          }
                                                        },
                                                        child: const Padding(
                                                          padding: EdgeInsets.all(6.0),
                                                          child: Icon(Icons.remove),
                                                        ),
                                                      )),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text("${manager.numberOfPlayers.value}", style: Get.textTheme.bodySmall),
                                                  ),
                                                  Material(
                                                      color: Colors.white,
                                                      elevation: 2.0,
                                                      borderRadius: BorderRadius.circular(4.0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          manager.numberOfPlayers.value++;
                                                        },
                                                        child: const Padding(
                                                          padding: EdgeInsets.all(6.0),
                                                          child: Icon(Icons.add),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox();
                                }),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 20.0),
                        Text("Entry fees", style: Get.textTheme.displayMedium),
                        const SizedBox(height: 16.0),
                        Material(
                            color: Colors.white,
                            elevation: 1,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0), side: BorderSide(width: 0.5, color: CustomTheme.borderColor)),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Material(
                                color: CustomTheme.bocLightBackground,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0), side: BorderSide(width: 0.5, color: CustomTheme.borderColor)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                                  child: Row(
                                    children: [
                                      SizedBox(width: constraints.maxWidth * 0.5, child: Text("Registration fees for each team.", style: TextStyle(color: Color(0xff6E6F73), fontSize: 16, fontWeight: FontWeight.bold))),
                                      const SizedBox(width: 10.0),
                                      Expanded(
                                        flex: 2,
                                        child: InputFieldWidget(
                                          textStyle: TextStyle(fontWeight: FontWeight.bold, color: CustomTheme.green),
                                          textEditingController: registrationFeeC,
                                          inputType: TextInputType.number,
                                          prefixText: "OMR",
                                          // textColor: CustomTheme.green,
                                          hint: "25",
                                          validate: (value) {
                                            if (value == null || value.isEmpty) {
                                              return "fields is required";
                                            }
                                            return null;
                                          },
                                          onChange: (p0) {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                        const SizedBox(height: 20.0),
                        Text("Winning price", style: Get.textTheme.displayMedium),
                        const SizedBox(height: 16.0),
                        Material(
                            color: Colors.white,
                            elevation: 1.5,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0), side: BorderSide(width: 0.5, color: CustomTheme.borderColor)),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Material(
                                color: CustomTheme.bocLightBackground,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0), side: BorderSide(width: 0.5, color: CustomTheme.borderColor)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                                  child: Row(
                                    children: [
                                      SizedBox(width: constraints.maxWidth * 0.5, child: Text("Winning amount must be higher then registration fees.", style: TextStyle(color: Color(0xff6E6F73), fontSize: 16, fontWeight: FontWeight.bold))),
                                      const SizedBox(width: 10.0),
                                      Expanded(
                                        flex: 2,
                                        child: InputFieldWidget(
                                          textStyle: TextStyle(fontWeight: FontWeight.bold, color: CustomTheme.green),
                                          textEditingController: winningPriceC,
                                          inputType: TextInputType.number,
                                          prefixText: "OMR",
                                          hint: "100",
                                          // textColor: CustomTheme.green,
                                          validate: (value) {
                                            if (value == null || value.isEmpty) {
                                              return "fields is required";
                                            }
                                            return null;
                                          },
                                          onChange: (p0) {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                        const SizedBox(height: 20.0),
                        Text("Define rules", style: Get.textTheme.displayMedium),
                        const SizedBox(height: 16.0),
                        Material(
                          color: Colors.white,
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            side: BorderSide(width: 0.5, color: CustomTheme.borderColor),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: InputFieldWidget(
                                        textEditingController: rulesC,
                                        label: "Write rules here",
                                        inputAction: TextInputAction.done,
                                        textStyle: TextStyle(color: Color(0xff6E6F73), fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                    // IconButton(
                                    //     onPressed: () {
                                    //       if (rulesC.text.isNotEmpty) {
                                    //         rules.add(rulesC.text);
                                    //         rulesC.clear();
                                    //         rules.refresh();
                                    //       }
                                    //     },
                                    //     padding: const EdgeInsets.all(16.0),
                                    //     icon: const Icon(Icons.add))
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: rules
                                      .map((element) => Column(
                                            children: [
                                              ListTile(
                                                title: Text(element),
                                                onTap: () {},
                                                trailing: IconButton(
                                                  icon: const Icon(Icons.delete_outline_outlined),
                                                  onPressed: () {
                                                    rules.removeWhere((value) => element == value);
                                                    rules.refresh();
                                                  },
                                                ),
                                              ),
                                              const Divider(),
                                            ],
                                          ))
                                      .toList(),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: InkWell(
                                    onTap: () {
                                      print("vivek test ===========================>");
                                      if (rulesC.text.isNotEmpty) {
                                        rules.add(rulesC.text);
                                        rulesC.clear();
                                        rules.refresh();
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("+Add one more", style: Get.textTheme.headlineSmall),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        MyButton(
                          text: "Create Activity",
                          height: constraints.maxHeight * 0.05,
                          onPressed: () {
                            validateDataAndCreateActivity();
                          },
                        ),
                        const SizedBox(height: 40.0),
                      ],
                    ),
                  ),
                ),
                manager.loading.value ? Container(color: Colors.white54, child: Center(child: CircularProgressIndicator(color: CustomTheme.appColor))) : const SizedBox(),
              ],
            );
          }),
        );
      }),
    );
  }

  Future<void> validateDataAndCreateActivity() async {
    manager.loading.value = true;
    if (_formKey.currentState!.validate()) {
      if (selectedSlots.isEmpty) {
        manager.loading.value = false;
        Constants.showSnackbar("Error", "select time slot first");
        return;
      }
      final list = venueController.currentVenue.value!.data!.venue.grounds.where((element) => element.sportsId == sport.id).toList();
      if (list.isEmpty) {
        Constants.showSnackbar("Error", "no ground available for ${manager.selectedSport}");
        manager.loading.value = false;
        return;
      }

      bool hasPaid = await createThawaniSession();

      if (hasPaid) {
        Constants.showSnackbar("Success", "Your payment has been successful.");
        final ground = list.first;
        requestModel = VenueCreateActivityRequestModel(date: _selectedDays.isEmpty ? _focusedDay : _selectedDays.first, numberOfPlayers: manager.numberOfPlayers.value, sportId: sport.id, morningAvailability: ground.morningAvailability, eveningAvailability: ground.eveningAvailability, bookedSlots: selectedSlots, rules: rules, entryFees: registrationFeeC.text, venueId: manager.selectedVenue.value.data!.venue.id, teamRequired: manager.teamChallange.value ? "yes" : "no", winningPrice: winningPriceC.text, createdBy: 'venue');

        final result = await manager.venueService.createVenueActivity(venueController.bearer, requestModel);
        if (result != null && result.httpCode == 200) {
          venueController.getVenueActivities(getNewData: true);

          Get.back();
          Constants.showSnackbar("Result", result.message);
          manager.loading.value = false;
        }
      }
    }
    manager.loading.value = false;
  }

  Future<bool> createThawaniSession() async {
    final url = Uri.parse("https://uatcheckout.thawani.om/api/v1/checkout/session");
    final body = jsonEncode({
      "client_reference_id": 'AIO_Ref_' + sport.id.toString(),
      "products": [
        {
          "name": "AIO Winning Price Payment",
          "unit_amount": int.parse(winningPriceC.text) * 1000,
          "quantity": 1,
        }
      ],
      "success_url": "https://yourapp.com/success",
      "cancel_url": "https://yourapp.com/cancel",
      "metadata": {
        "customer_name": "John Doe",
        "customer_email": "johndoe@example.com",
      }
    });
    final headers = {
      "Content-Type": "application/json",
      "thawani-api-key": "rRQ26GcsZzoEhbrP2HZvLYDbn9C9et",
    };

    log("Body: $body");
    log("Headers: $headers");
    log("Url: $url");

    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final status = await Get.to(() => ThaiwanPayScreen(url: 'https://uatcheckout.thawani.om/pay/${data['data']['session_id']}?key=HGvTMLDssJghr9tlN9gr4DVYt0qyBy', targetUrl: "https://yourapp.com/success"));
      print('Payment status: $status');
      if (status != null && status == 'success') {
        return true;
      }
    } else {
      log("Error: ${response.body}");
      return false;
    }
    return false;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
      // Update values in a Set
      if (_selectedDays.contains(selectedDay)) {
        _selectedDays.remove(selectedDay);
      } else {
        _selectedDays.assign(selectedDay);
      }
      log("_onDaySelected: ${_selectedDays.join(",")}");
    });
  }
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}
