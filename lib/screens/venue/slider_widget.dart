import 'package:aio_sport/models/venue_booking_response.dart' as book;
import 'package:aio_sport/services/server_urls.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SliderWidget extends StatefulWidget {
  final double width, height;
  final book.BookingData bookingModel;
  const SliderWidget({super.key, required this.width, required this.height, required this.bookingModel});

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  late book.BookingData booking;

  @override
  void initState() {
    booking = widget.bookingModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Image.asset(
          "assets/images/rectangle_box.png",
          height: widget.height,
          width: widget.width,
          fit: BoxFit.fill,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${booking.sportsName} - ${booking.groundName}",
                    style: Get.textTheme.headlineLarge,
                  ),
                  IconButton(
                    onPressed: () {},
                    alignment: Alignment.center,
                    // padding: const EdgeInsets.all(16.0),
                    icon: const Icon(Icons.share_outlined),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.access_time,
                    color: CustomTheme.grey,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    booking.slots.isEmpty ? "" : booking.slots.first.time.first,
                    style: Get.textTheme.displaySmall?.copyWith(color: CustomTheme.textColorLight),
                  )
                ],
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CachedNetworkImage(
                    imageUrl: "${ServerUrls.mediaUrl}player/${booking.playerPicture}",
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => CircularProgressIndicator(color: CustomTheme.appColor),
                    errorWidget: (context, error, stackTrace) {
                      return Icon(Icons.image_not_supported_rounded, color: CustomTheme.appColor);
                    },
                  ),
                ),
                title: Text("booked by", style: Get.textTheme.displaySmall),
                subtitle: Text(booking.playerName, style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w400)),
              ),
              const SizedBox(height: 10.0),
              const Divider(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: booking.groundData
                        .map((e) => Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      height: 8.0,
                                      width: 8.0,
                                      child: Material(
                                        color: CustomTheme.textColorLight,
                                        borderRadius: BorderRadius.circular(4.0),
                                      )),
                                  Text("\t${e.itemName}", style: Get.textTheme.labelSmall),
                                ],
                              ),
                            ))
                        .toList()),
              )
            ],
          ),
        ),
      ],
    );
  }
}
