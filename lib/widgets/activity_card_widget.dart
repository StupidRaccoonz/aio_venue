import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/models/venue_create_activity_reponse.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

import '../screens/venue/venue_activity_details_screen.dart';

class ActivityCardWidget extends StatefulWidget {
  final double height, width;
  final BoxFit? fit;
  final double? radius;
  final CreateActivityMatch activityModel;
  final void Function() onPressed;
  final bool fromActivity;
  const ActivityCardWidget({super.key, required this.height, required this.width, this.fit, required this.activityModel, this.radius, required this.onPressed, required this.fromActivity});

  @override
  State<ActivityCardWidget> createState() => _ActivityCardWidgetState();
}

class _ActivityCardWidgetState extends State<ActivityCardWidget> {
  final profileController = Get.find<ProfileController>();
  // late Sport sport;
  late bool isVenueActivity;
  @override
  void initState() {
    // sport = profileController.sportsList.firstWhere((element) => element.id == widget.activityModel.sportId)
    isVenueActivity = widget.activityModel.type == "venue";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            "assets/images/rectangle_box.png",
            width: widget.width,
            height: widget.height,
            fit: widget.fit ?? BoxFit.fill,
          ),
          GestureDetector(
            onTap: () {
              Get.to(VenueActivityDetailsScreen());
            },
            child: Center(
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
                        padding: const EdgeInsets.only(left: 2.0, right: 2.0, top: 2.0, bottom: 2.0),
                        child: Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(12.br)),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 25.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: widget.activityModel.teams.isEmpty
                                        ? Text("No team joined", style: Get.textTheme.headlineMedium)
                                        : Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset("assets/icons/venue_sample.png", height: 30),
                                              const SizedBox(width: 8.0),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(widget.activityModel.teams[0].name ?? 'N/A', style: Get.textTheme.bodySmall!.copyWith(color: CustomTheme.appColor)),
                                                  isVenueActivity ? const SizedBox() : Text("Host", style: Get.textTheme.displaySmall!.copyWith(fontSize: 10.rfs)),
                                                ],
                                              ),
                                            ],
                                          )),
                                const Text("vs"),
                                Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: widget.activityModel.teams.length < 2
                                        ? Text("No team joined", textAlign: TextAlign.right, style: Get.textTheme.headlineMedium)
                                        : Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text("${widget.activityModel.teams[1].name}", style: Get.textTheme.bodySmall!.copyWith(color: CustomTheme.appColor)),
                                                  isVenueActivity
                                                      ? const SizedBox()
                                                      : Text(
                                                          "Opponent",
                                                          style: Get.textTheme.displaySmall!.copyWith(fontSize: 10.rfs),
                                                        ),
                                                ],
                                              ),
                                              const SizedBox(width: 8.0),
                                              Image.asset("assets/icons/venue_sample.png", height: 30),
                                            ],
                                          )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    widget.activityModel.type == "venue"
                        ? Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                              child: Material(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                          flex: 1,
                                          fit: FlexFit.tight,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(widget.activityModel.sport.name, style: Get.textTheme.titleSmall),
                                              const SizedBox(height: 8.0),
                                              Text(Constants.getFormattedDateWithTime(widget.activityModel.date), style: Get.textTheme.headlineSmall!.copyWith(fontSize: 10.rfs)),
                                            ],
                                          )),
                                      Flexible(
                                          flex: 1,
                                          fit: FlexFit.tight,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text("OMR ${widget.activityModel.winningPrice}", style: Get.textTheme.titleSmall!.copyWith(color: CustomTheme.appColorSecondary)),
                                              const SizedBox(height: 8.0),
                                              Text("Winning price", style: Get.textTheme.displaySmall!.copyWith(fontSize: 10.rfs)),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),

                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: isVenueActivity
                            ? widget.fromActivity
                                ? Text("Registration fees: OMR ${widget.activityModel.entryFees}", style: Get.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w400))
                                : Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(widget.activityModel.venue.name, style: Get.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w400)),
                                      const Spacer(),
                                      Text("Registration fees: OMR ${widget.activityModel.entryFees}", style: Get.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w400)),
                                    ],
                                  )
                            : Center(child: Text(Constants.getFormattedDateWithTime(widget.activityModel.date), style: Get.textTheme.labelMedium)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: isVenueActivity ? 0 : 20,
            child: Material(
              color: isVenueActivity ? CustomTheme.appColorSecondary : CustomTheme.cherryRed,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(12.br)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  isVenueActivity ? "Venue Challange" : "Challange match",
                  style: Get.textTheme.displaySmall!.copyWith(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
