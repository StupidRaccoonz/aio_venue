import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/models/venue_booking_details_model.dart';
import 'package:aio_sport/models/venue_booking_response.dart' as book;
import 'package:aio_sport/services/server_urls.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/app_bar_widget.dart';
import 'package:aio_sport/widgets/my_text_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scaled_size/scaled_size.dart';

class VenueBookingDetailsScreen extends StatefulWidget {
  final bool isLongterm;
  final book.BookingData bookingData;

  const VenueBookingDetailsScreen({super.key, required this.isLongterm, required this.bookingData});

  @override
  State<VenueBookingDetailsScreen> createState() => _VenueBookingDetailsScreenState();
}

class _VenueBookingDetailsScreenState extends State<VenueBookingDetailsScreen> {
  final profile = Get.find<ProfileController>();
  Rx<bool> loading = true.obs;
  VenueBookingDetailsModel? details;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
      details = await profile.venueService.getVenueBookingDetails(profile.bearer, "${widget.bookingData.id}");
      if (details == null) {
        print("No details found for the booking.");
      }
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      loading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Details ============>");
    // print(details!.data);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 10.vh),
        child: AppbarWidget(
            title: "Booking details",
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
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.br), side: BorderSide(color: CustomTheme.borderColor, width: 1)),
                  color: Colors.white,
                  elevation: 2.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: CachedNetworkImage(
                                imageUrl: "${ServerUrls.mediaUrl}player/${widget.bookingData.playerPicture}",
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => CircularProgressIndicator(color: CustomTheme.appColor),
                                errorWidget: (context, error, stackTrace) {
                                  return Icon(Icons.image_not_supported_rounded, color: CustomTheme.appColor);
                                },
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.bookingData.playerName,
                                  // details!.data.playerName,
                                  style: Get.textTheme.headlineLarge,
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  "OMR ${widget.bookingData.totalAmount}",
                                  style: Get.textTheme.headlineLarge!.copyWith(color: CustomTheme.green),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Material(
                                color: CustomTheme.bocLightBackground,
                                borderRadius: BorderRadius.circular(5.br),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Sport",
                                        style: Get.textTheme.displaySmall,
                                      ),
                                      Text(
                                        widget.bookingData.sportsName,
                                        style: Get.textTheme.headlineLarge,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Material(
                                color: CustomTheme.bocLightBackground,
                                borderRadius: BorderRadius.circular(5.br),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Ground",
                                        style: Get.textTheme.displaySmall,
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        widget.bookingData.groundName,
                                        style: Get.textTheme.headlineLarge,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Material(
                                color: CustomTheme.bocLightBackground,
                                borderRadius: BorderRadius.circular(5.br),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Date",
                                        style: Get.textTheme.displaySmall,
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        // widget.bookingData.,
                                        Constants.getFormattedDate(widget.bookingData.bookingDate),
                                        style: Get.textTheme.headlineLarge,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Material(
                                color: CustomTheme.bocLightBackground,
                                borderRadius: BorderRadius.circular(5.br),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Date & Time",
                                        style: Get.textTheme.displaySmall,
                                      ),
                                      const SizedBox(height: 2.0),
                                      InkWell(
                                        onTap: () {
                                          Get.bottomSheet(
                                            Container(
                                              height: Get.height * 0.5, // Half the screen height
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: CustomTheme.borderColor))),
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 16.0),
                                                          child: Text(
                                                            "Timing",
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        Align(
                                                          alignment: Alignment.topRight,
                                                          child: IconButton(
                                                            icon: Icon(Icons.close, size: 28),
                                                            onPressed: () => Get.back(),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Column(
                                                    children: widget.bookingData!.slots.map((slot) {
                                                      return Container(
                                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                                        decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: CustomTheme.borderColor))),
                                                        child: Row(children: [
                                                          Text(
                                                            DateFormat("d MMM, y EEE").format(slot.date),
                                                            style: TextStyle(fontSize: 14.rfs),
                                                          ),
                                                          const Spacer(),
                                                          Column(
                                                            children: slot.time.map((t) => Text(t, style: TextStyle(fontSize: 14.rfs))).toList(),
                                                          )
                                                        ]),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            isScrollControlled: true, // Allows setting height
                                          );
                                        },
                                        // child: Text(
                                        //   widget.isLongterm
                                        //       ? "View date & time"
                                        //       : widget.bookingData.slots.isEmpty
                                        //           ? ""
                                        //           : widget.bookingData.slots.first.time.first,
                                        //   style: Get.textTheme.headlineLarge!.copyWith(color: CustomTheme.iconColor),
                                        // ),
                                        child: Text(
                                          "View date & time",
                                          style: Get.textTheme.headlineLarge!.copyWith(color: CustomTheme.iconColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Material(
                                color: CustomTheme.bocLightBackground,
                                borderRadius: BorderRadius.circular(5.br),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Booking ID",
                                        style: Get.textTheme.displaySmall,
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        "${widget.bookingData.id}",
                                        style: Get.textTheme.headlineLarge,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            const Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: SizedBox(),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Text("Booked on: ${Constants.getFormattedDateWithTime(widget.bookingData.bookingDate)}", style: Get.textTheme.displaySmall),
                          ),
                        ),
                        Center(
                          child: MyTextButton(
                            height: 40.rh,
                            width: double.maxFinite,
                            onPressed: () {},
                            text: "Cancel",
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.br),
                    side: const BorderSide(width: 0.5, color: Colors.teal),
                  ),
                  child: SizedBox(
                    width: constraints.maxWidth * 0.9,
                    height: 30.rh,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Cancellation is only allow till 8 Nov", style: Get.textTheme.displaySmall),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                Text("Add ons", style: Get.textTheme.displayMedium),
                const SizedBox(height: 16.0),
                widget.bookingData.groundData.isEmpty
                    ? const SizedBox()
                    : Material(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.br),
                          side: const BorderSide(width: 0.5, color: Colors.teal),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: widget.bookingData.groundData
                                .map((e) => Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(e.itemName, style: Get.textTheme.headlineLarge),
                                          Text(e.quality.toString(), style: Get.textTheme.headlineLarge),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                const SizedBox(height: 30.0),
                Text("Athlete Information", style: Get.textTheme.displayMedium),
                const SizedBox(height: 16.0),
                Obx(() {
                  return loading.value
                      ? Center(
                          child: CircularProgressIndicator(color: CustomTheme.appColor),
                        )
                      : details == null
                          ? const SizedBox()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Material(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.br),
                                    side: const BorderSide(width: 0.5, color: Colors.teal),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("Address", style: Get.textTheme.displaySmall),
                                        Text('2001 Blvd Robert-Bourassa, Montréal, QC H3A 3H9', overflow: TextOverflow.ellipsis, style: Get.textTheme.titleSmall, maxLines: 2),
                                        const Divider(height: 20.0),
                                        Text("Phone", style: Get.textTheme.displaySmall),
                                        Text(details!.data.playerPhone, overflow: TextOverflow.ellipsis, style: Get.textTheme.titleSmall),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30.0),
                                Text("Payment summary", style: Get.textTheme.displayMedium),
                                const SizedBox(height: 16.0),
                                Material(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.br),
                                    side: const BorderSide(width: 0.5, color: Colors.teal),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text("Ground price:", overflow: TextOverflow.ellipsis, style: Get.textTheme.titleSmall, maxLines: 2),
                                                Text("${details!.data.slots.isEmpty ? "" : (details!.data.slots.first.time.length)} x OMR ${details!.data.groundHourlyRent}/hr", style: Get.textTheme.displaySmall),
                                              ],
                                            ),
                                            Text("+OMR ${(double.parse(details!.data.groundHourlyRent.isNotEmpty ? details!.data.groundHourlyRent : "0") * (details!.data.slots.isEmpty ? 0 : details!.data.slots.first.time.length))}", overflow: TextOverflow.ellipsis, style: Get.textTheme.titleSmall, maxLines: 2),
                                          ],
                                        ),
                                        const SizedBox(height: 16.0),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: details!.data.groundData
                                              .map((e) => Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Text("${e.itemName}:", overflow: TextOverflow.ellipsis, style: Get.textTheme.titleSmall, maxLines: 2),
                                                          Text("${e.quality} x OMR ${e.price}/hr", style: Get.textTheme.displaySmall),
                                                        ],
                                                      ),
                                                      Text(
                                                        "+OMR ${double.parse((e.price.isNotEmpty ? e.price : "0")) * int.parse((e.quality.isNotEmpty ? e.quality : "0"))}",
                                                        overflow: TextOverflow.ellipsis,
                                                        style: Get.textTheme.titleSmall,
                                                        maxLines: 2,
                                                      ),
                                                    ],
                                                  ))
                                              .toList(),
                                        ),
                                        const SizedBox(height: 16.0),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text("Tax:", overflow: TextOverflow.ellipsis, style: Get.textTheme.titleSmall, maxLines: 2),
                                                Text("${details!.data.taxPercentage ?? 0}", style: Get.textTheme.displaySmall),
                                              ],
                                            ),
                                            Text("+OMR ${details!.data.tax ?? 0}", overflow: TextOverflow.ellipsis, style: Get.textTheme.titleSmall, maxLines: 2),
                                          ],
                                        ),
                                        const SizedBox(height: 16.0),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text("Other charges:", overflow: TextOverflow.ellipsis, style: Get.textTheme.titleSmall, maxLines: 2),
                                                Text("Convenience Fee", style: Get.textTheme.displaySmall),
                                              ],
                                            ),
                                            Text("+OMR ${details!.data.otherCharges ?? 0}", overflow: TextOverflow.ellipsis, style: Get.textTheme.titleSmall, maxLines: 2),
                                          ],
                                        ),
                                        const SizedBox(height: 16.0),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text("Coupen discount:", overflow: TextOverflow.ellipsis, style: Get.textTheme.titleSmall, maxLines: 2),
                                                Text(details!.data.couponCode ?? 'n/a', style: Get.textTheme.displaySmall),
                                              ],
                                            ),
                                            Text("-OMR ${details!.data.couponDiscount ?? 0}", overflow: TextOverflow.ellipsis, style: Get.textTheme.titleSmall, maxLines: 2),
                                          ],
                                        ),
                                        const Divider(height: 30.0),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Grand total:", overflow: TextOverflow.ellipsis, style: Get.textTheme.titleSmall),
                                            Text("OMR ${widget.bookingData.totalAmount}",
                                                overflow: TextOverflow.ellipsis,
                                                style: Get.textTheme.titleSmall!.copyWith(
                                                  color: CustomTheme.appColorSecondary,
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                }),
                const SizedBox(height: 40.0),
              ],
            ),
          ),
        );
      }),
    );
  }

// void getData() async {d
//   details = await profile.venueService.getVenueBookingDetails(profile.bearer, "${widget.bookingData.id}");
//   loading.value = false;
// }
}
