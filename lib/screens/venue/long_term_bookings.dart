import 'dart:developer';

import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/models/booking_filter_model.dart';
import 'package:aio_sport/models/venue_details_model.dart';
import 'package:aio_sport/screens/venue/venue_bookings_filters.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/booking_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

class LongTermBookings extends StatefulWidget {
  const LongTermBookings({super.key});

  @override
  State<LongTermBookings> createState() => _LongTermBookingsState();
}

class _LongTermBookingsState extends State<LongTermBookings> with AutomaticKeepAliveClientMixin {
  late BookingFilterModel filterModel;
  final profileController = Get.find<ProfileController>();

  @override
  void initState() {
    filterModel = BookingFilterModel(sport: Sport(), date: 1);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      filterModel = BookingFilterModel(sport: profileController.currentVenue.value!.data!.venue.sports!.first, date: 1);
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: [
            // Filters list
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => applyFilters(0),
                    child: Chip(
                      label: Text(filterModel.sport.name ?? "", style: Get.textTheme.labelMedium),
                      deleteIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                      onDeleted: () {
                        applyFilters(0);
                      },
                      backgroundColor: Colors.white,
                      side: BorderSide(color: CustomTheme.borderColor),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.br)),
                    ),
                  ),
                  const SizedBox(width: 13.0),
                  GestureDetector(
                    onTap: () => applyFilters(1),
                    child: Chip(
                      label: Text(Constants.intToString(filterModel.date, true), style: Get.textTheme.labelMedium),
                      deleteIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                      onDeleted: () {
                        applyFilters(1);
                      },
                      backgroundColor: Colors.white,
                      side: BorderSide(color: CustomTheme.borderColor),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.br)),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Obx(() {
                var longBookings = profileController.venueBookings.value?.bookings!.data.where((element) {
                      return element.longTermBooking > 0 && element.sportsName.toLowerCase() == filterModel.sport.name?.toLowerCase();
                    }).toList() ??
                    [];
                longBookings = Constants.filterBookingsByDate(longBookings, filterModel.date);

                return longBookings.isEmpty
                    ? Center(
                        child: Text("No booking available", style: Get.textTheme.headlineMedium),
                      )
                    : ListView.builder(
                        itemCount: longBookings.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: BookingCardWidget(
                              height: constraints.maxHeight * 0.3,
                              longterm: true,
                              onPressed: () {},
                              bookingData: longBookings[index],
                              width: constraints.maxWidth * 0.9,
                            ),
                          );
                        },
                      );
              }),
            )
          ],
        );
      }),
    );
  }

  Future<void> applyFilters(int filterIndex) async {
    BookingFilterModel? bookingFilters = await Get.bottomSheet<BookingFilterModel>(
      VenueBookingFilters(
        filterModel: filterModel,
        isBooking: true,
        filterIndex: filterIndex,
      ),
      enableDrag: false,
      isScrollControlled: false,
    );
    if (bookingFilters != null) {
      filterModel = bookingFilters;
      setState(() {});
    }
    log("bookingFilters applied: $bookingFilters");
  }

  @override
  bool get wantKeepAlive => true;
}
