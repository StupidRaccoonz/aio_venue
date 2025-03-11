import 'dart:developer';

import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/models/venue_booking_response.dart' as book;
import 'package:aio_sport/screens/venue/venue_booking_details_screen.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:scaled_size/scaled_size.dart';

class BookingCardWidget extends StatefulWidget {
  final double height, width;
  final BoxFit? fit;
  final double? radius;
  final bool longterm;
  final book.BookingData bookingData;
  final void Function() onPressed;
  const BookingCardWidget({super.key, required this.height, required this.width, this.fit, this.radius, required this.onPressed, required this.longterm, required this.bookingData});

  @override
  State<BookingCardWidget> createState() => _BookingCardWidgetState();
}

class _BookingCardWidgetState extends State<BookingCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: GestureDetector(
        onTap: () {
          log("BookingCardWidget -> GestureDetector clicked");
          Get.to(() => VenueBookingDetailsScreen(isLongterm: widget.longterm, bookingData: widget.bookingData));
        },
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            border: Border.all(color: CustomTheme.borderColor, width: 1),
            borderRadius: BorderRadius.circular(10.br),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                widget.longterm ? "assets/images/match_rectangle.png" : "assets/images/rectangle_box.png",
                width: widget.width,
                height: widget.height,
                fit: widget.fit ?? BoxFit.fill,
              ),
              Center(
                child: SizedBox(
                  width: widget.width,
                  height: widget.height,
                  child: Column(
                    children: [
                      // Teams row
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Row(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.bookingData.groundName, style: Get.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold)),
                                  // Text(widget.bookingData.slots.isNotEmpty ? widget.bookingData.slots.first.time.first : "",
                                  //     style: Get.textTheme.headlineLarge!.copyWith(
                                  //       fontSize: 10.rfs,
                                  //       fontWeight: FontWeight.w400,
                                  //     )),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(widget.longterm ? 'Long Term' : "Short Term",
                                      style: Get.textTheme.headlineLarge!.copyWith(
                                        fontSize: 12.rfs,
                                        fontWeight: FontWeight.w400,
                                      )),
                                ],
                              ),
                              const Spacer(),
                              Text("OMR ${widget.bookingData.totalAmount}", style: TextStyle(color: CustomTheme.green, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        fit: FlexFit.tight,
                        child: Material(
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.br)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Booked by", style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500)),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(widget.bookingData.playerName, style: Get.textTheme.headlineLarge),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Booking start date", style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500)),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(Constants.getFormattedDate(widget.bookingData.date.first), style: Get.textTheme.headlineLarge),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "Booked on: ${Constants.getFormattedDateTimeInShort(widget.bookingData.bookingDate)}",
                                  style: TextStyle(color: Colors.grey, fontSize: 12.rfs),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
