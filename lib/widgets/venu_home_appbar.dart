import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/screens/venue/venue_list_bottombar.dart';
import 'package:aio_sport/screens/venue/venue_notification_screen.dart';
import 'package:aio_sport/services/server_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

import 'image_widget.dart';

class VenueHomeAppBar extends StatelessWidget {
  final String? title, subtitle, image;
  VenueHomeAppBar({super.key, required this.title, this.subtitle, required this.image});

  final profile = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title!.capitalize!,
                overflow: TextOverflow.ellipsis,
                style: Get.textTheme.labelLarge!.copyWith(color: Colors.white),
              ),
              subtitle == null
                  ? const SizedBox()
                  : Text(
                      subtitle!,
                      style: Get.textTheme.labelSmall!.copyWith(color: Colors.white54, fontWeight: FontWeight.w300),
                    ),
            ],
          ),
        ),
        Material(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(25.br),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VenueNotificationScreen(),
                  ));
            },
            borderRadius: BorderRadius.circular(25.br),
            focusColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset("assets/icons/notification.png", color: Colors.white, height: 30.0, width: 30.0),
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        InkWell(
          onTap: () {
            Get.bottomSheet(const VenueListBottomSheet());
          },
          child: Container(
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 2.5, color: Colors.white12)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.br),
              child: ImageWidget(
                imageurl: '${ServerUrls.mediaUrl}venue/${profile.currentVenue.value?.data?.venue.profilePicture}',
                height: 50.0,
                width: 50.0,
                radius: 20.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
      ],
    );
  }
}
