import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/models/booking_filter_model.dart';
import 'package:aio_sport/models/venue_details_model.dart';
import 'package:aio_sport/screens/venue/venue_bookings_screen.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

import '../../controllers/veneue_manager_controller.dart';

class VenueBookingFilters extends StatefulWidget {
  final BookingFilterModel filterModel;
  final bool isBooking;
  final int filterIndex;
  const VenueBookingFilters({super.key, required this.filterModel, required this.isBooking, required this.filterIndex});

  @override
  State<VenueBookingFilters> createState() => _VenueBookingFiltersState();
}

class _VenueBookingFiltersState extends State<VenueBookingFilters> {
  late BookingFilterModel filterModel;
  final profileController = Get.find<ProfileController>();
  final manager = Get.find<VenueManagerController>();
  int selectedTile = 0;

  @override
  void initState() {
    filterModel = widget.filterModel;
    selectedTile = widget.filterIndex;
    super.initState();
  }

  String selectedBooking = "Today's bookings";
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Material(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.br)),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 16.0),
              ListTile(
                title: Text("Filter", style: Get.textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w400)),
                onTap: () {},
              ),
              const Divider(),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              selectedTile = 0;
                              setState(() {});
                            },
                            child: Row(
                              children: [
                                Container(
                                  decoration: selectedTile == 0
                                      ? BoxDecoration(
                                          border: Border(left: BorderSide(width: 3, color: CustomTheme.iconColor)))
                                      : null,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Sport", style: Get.textTheme.bodySmall),
                                        const SizedBox(height: 4.0),
                                        Text(filterModel.sport.name??
                                        "", style: Get.textTheme.displaySmall),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          InkWell(
                            onTap: () {
                              selectedTile = 1;
                              setState(() {});
                            },
                            child: Row(
                              children: [
                                Container(
                                  decoration: selectedTile == 1
                                      ? BoxDecoration(
                                          border: Border(left: BorderSide(width: 3, color: CustomTheme.iconColor)))
                                      : null,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(widget.isBooking ? "Booking" : "Activity", style: Get.textTheme.bodySmall),
                                        const SizedBox(height: 4.0),
                                        Text(Constants.intToString(filterModel.date, widget.isBooking ? true : false),
                                            style: Get.textTheme.displaySmall!.copyWith(fontSize: 10.rfs)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(color: CustomTheme.borderColor, width: 2.0),
                    Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: SingleChildScrollView(
                        child: Column(
                          children: selectedTile == 0
                              ? profileController.currentVenue.value!.data!.venue.sports!
                                  .map(
                                    (e) => RadioListTile<Sport>(
                                      value: e,
                                      groupValue: filterModel.sport,
                                      activeColor: CustomTheme.iconColor,
                                      onChanged: (value) {
                                        if (value != null) {
                                          filterModel.sport = value;
                                          setState(() {});
                                        }
                                      },
                                      title: Text(e.name??
                                      "",
                                          style: Get.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500)),
                                    ),
                                  )
                                  .toList()
                              : (widget.isBooking)
                                  ? Constants.bookingTimeList
                                      .map(
                                        (e) => RadioListTile(
                                          value: e,
                                          activeColor: CustomTheme.iconColor,
                                          groupValue: Constants.bookingTimeList[filterModel.date - 1],
                                          onChanged: (value) {
                                            if (value != null) {
                                              filterModel.date = Constants.stringToInt(value);
                                              print("selectedBooking =====>");
                                              print(filterModel.date);
                                              setState(() {});
                                            }
                                          },
                                          title: Text(e,
                                              style: Get.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500)),
                                        ),
                                      )
                                      .toList()
                                  : Constants.activityTimeList
                                      .map(
                                        (e) => RadioListTile(
                                          value: e,
                                          activeColor: CustomTheme.iconColor,
                                          groupValue: Constants.activityTimeList[filterModel.date - 1],
                                          onChanged: (value) {
                                            if (value != null) {
                                              filterModel.date = Constants.activityTimeToInt(value);
                                              print("selectedBooking =====>");
                                              print(filterModel.date);
                                              setState(() {});
                                            }
                                          },
                                          title: Text(e,
                                              style: Get.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500)),
                                        ),
                                      )
                                      .toList(),
                          // Constants.bookingTimeList
                          //         .map(
                          //           (e) => RadioListTile(
                          //             value: e,
                          //             activeColor: CustomTheme.iconColor,
                          //             groupValue: Constants.dateToString(filterModel.date, widget.isBooking),
                          //             onChanged: (value) {
                          //               if (value != null) {
                          //                 filterModel.date = Constants.stringToDate(value);
                          //                 print("INDEX =====>");
                          //                 // print(index);
                          //                 print(e);
                          //                 setState(() {});
                          //               }
                          //             },
                          //             title: Text(e, style: Get.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500)),
                          //           ),
                          //         )
                          //         .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Material(
                      color: Colors.white,
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: SizedBox(
                          width: double.maxFinite,
                          height: 45.rh,
                          child: Center(
                            child: Text(
                              "Clear All",
                              style: Get.textTheme.bodyMedium!.copyWith(color: CustomTheme.appColorSecondary),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Material(
                      color: CustomTheme.appColorSecondary,
                      child: InkWell(
                        onTap: () {
                          profileController.venueService.getVenuesBookings(
                              profileController.bearer,
                              profileController.venueId.toString(),
                              "short",
                              "${manager.selectedGroundSportId}",
                              "${filterModel.date}");
                          selectedBooking = selectedIndex.toString();
                          print("=======AB=======");
                          print(selectedBooking);
                          Get.back(result: filterModel);
                        },
                        child: SizedBox(
                          width: double.maxFinite,
                          height: 45.rh,
                          child: Center(
                            child: Text("Apply", style: Get.textTheme.bodyMedium!.copyWith(color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ));
    });
  }
}
