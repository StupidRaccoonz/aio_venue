import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

class PlayerHomeAppBar extends StatelessWidget {
  final String? title, subtitle, image;
  PlayerHomeAppBar({super.key, required this.title, this.subtitle, required this.image});

  final profile = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Row(
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
              onTap: () {},
              borderRadius: BorderRadius.circular(25.br),
              focusColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset("assets/icons/notification.png", color: Colors.white, height: 30.0, width: 30.0),
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          Material(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(25.br),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(25.br),
              focusColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset("assets/icons/create_team.png", height: 30.0, width: 30.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
