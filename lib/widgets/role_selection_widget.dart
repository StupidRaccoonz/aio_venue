import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/controllers/home_controller.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

class RoleSelectionWidget extends StatefulWidget {
  final Function(int value) roleTypeSelected;
  const RoleSelectionWidget({super.key, required this.roleTypeSelected});

  @override
  State<RoleSelectionWidget> createState() => _RoleSelectionWidgetState();
}

class _RoleSelectionWidgetState extends State<RoleSelectionWidget> {
  final homeController = Get.find<HomeController>();
  int selected = 3;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 27.vw,
          width: 27.vw,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(
              width: 1.0,
              color: selected == 1 ? CustomTheme.appColorSecondary : CustomTheme.grey,
            ),
          ),
          child: InkWell(
            onTap: () {
              selected = 1;
              homeController.accountType.value = Constants.acountTypeCoach;
              widget.roleTypeSelected(selected);
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/icons/coach.png',
                    height: 15.vw,
                    color: selected == 1 ? CustomTheme.appColorSecondary : null,
                  ),
                  Text(
                    "Coach",
                    style: Get.textTheme.bodySmall!.copyWith(color: selected == 1 ? CustomTheme.appColorSecondary : CustomTheme.grey),
                  )
                ],
              ),
            ),
          ),
        ),
        const Spacer(),
        Container(
          height: 27.vw,
          width: 27.vw,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(
              width: 1.0,
              color: selected == 2 ? CustomTheme.appColorSecondary : CustomTheme.grey,
            ),
          ),
          child: InkWell(
            onTap: () {
              selected = 2;
              homeController.accountType.value = Constants.acountTypePlayer;
              widget.roleTypeSelected(selected);
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/icons/player.png',
                    height: 15.vw,
                    color: selected == 2 ? CustomTheme.appColorSecondary : null,
                  ),
                  Text(
                    "Player",
                    style: Get.textTheme.bodySmall!.copyWith(color: selected == 2 ? CustomTheme.appColorSecondary : CustomTheme.grey),
                  )
                ],
              ),
            ),
          ),
        ),
        const Spacer(),
        Container(
          height: 27.vw,
          width: 27.vw,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(
              width: 1.0,
              color: selected == 3 ? CustomTheme.appColorSecondary : CustomTheme.grey,
            ),
          ),
          child: InkWell(
            onTap: () {
              selected = 3;
              homeController.accountType.value = Constants.acountTypeVenue;
              widget.roleTypeSelected(selected);
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/icons/venue.png',
                    height: 15.vw,
                    width: 15.vw,
                    fit: BoxFit.fitWidth,
                    color: selected == 3 ? CustomTheme.appColorSecondary : null,
                  ),
                  Text(
                    "Venue",
                    style: Get.textTheme.bodySmall!.copyWith(color: selected == 3 ? CustomTheme.appColorSecondary : CustomTheme.grey),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
