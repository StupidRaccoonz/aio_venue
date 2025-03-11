import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/models/player/player_my_matches_response_model.dart';
import 'package:aio_sport/services/server_urls.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/image_widget.dart';
import 'package:aio_sport/widgets/my_text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

class PlayerMyMatchWidget extends StatefulWidget {
  final double height, width;
  final BoxFit? fit;
  final double? radius;
  final bool isPast;
  final Match matchModel;
  final void Function() onPressed;

  const PlayerMyMatchWidget({
    super.key,
    required this.height,
    required this.width,
    this.fit,
    required this.matchModel,
    this.radius,
    required this.onPressed,
    required this.isPast,
  });

  @override
  State<PlayerMyMatchWidget> createState() => _PlayerMyMatchWidgetState();
}

class _PlayerMyMatchWidgetState extends State<PlayerMyMatchWidget> {
  final profileController = Get.find<ProfileController>();
  // late Sport sport;
  bool isFriendly = false;
  @override
  void initState() {
    // sport = profileController.sportsList.firstWhere((element) => element.id == widget.activityModel.sportId)

    isFriendly = widget.matchModel.matchType.toLowerCase().startsWith("friendly");
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
            "assets/images/rectangle_player.png",
            width: widget.width,
            height: widget.height,
            fit: BoxFit.fill,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SizedBox(
                width: widget.width,
                height: widget.height,
                child: Column(
                  children: [
                    // Teams row
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0, right: 2.0, top: 0.0, bottom: 2.0),
                      child: Material(
                        color: Colors.white,
                        elevation: 0.0,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12.br)),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 40.0, bottom: 8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: widget.matchModel.teams.isEmpty
                                          ? Text("No team", style: Get.textTheme.headlineMedium)
                                          : Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ImageWidget(
                                                    imageurl: profileController.myTeams.first.logo != null
                                                        ? '${ServerUrls.mediaUrl}team/${profileController.myTeams.first.logo}'
                                                        : null,
                                                    fit: BoxFit.cover,
                                                    radius: 15.0,
                                                    width: 30.0,
                                                    height: 30),
                                                const SizedBox(width: 8.0),
                                                Expanded(
                                                    child: Text(profileController.myTeams.first.name,
                                                        style: Get.textTheme.bodySmall!
                                                            .copyWith(color: CustomTheme.appColor))),
                                              ],
                                            )),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("|", style: Get.textTheme.bodySmall!.copyWith(color: CustomTheme.grey)),
                                      Text("vs", style: Get.textTheme.bodySmall!.copyWith(color: CustomTheme.grey)),
                                      Text("|", style: Get.textTheme.bodySmall!.copyWith(color: CustomTheme.grey)),
                                    ],
                                  ),
                                  Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: widget.matchModel.teams.length < 2
                                          ? widget.isPast
                                              ? Text("No team joined",
                                                  textAlign: TextAlign.end, style: Get.textTheme.headlineMedium)
                                              : Center(
                                                  child: MyTextButton(
                                                    width: 120,
                                                    height: 35,
                                                    onPressed: () {},
                                                    //=> Get.to(() => InviteteamScreen(match: widget.matchModel)),
                                                    text: "Invite team",
                                                    textStyle: Get.textTheme.bodySmall!.copyWith(
                                                        color: CustomTheme.iconColor, fontWeight: FontWeight.w400),
                                                    borderColor: CustomTheme.iconColor,
                                                    textColor: CustomTheme.iconColor,
                                                  ),
                                                )
                                          : Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  child: Text(widget.matchModel.teams[1].name ?? 'N/A',
                                                      textAlign: TextAlign.right,
                                                      style: Get.textTheme.bodySmall!
                                                          .copyWith(color: CustomTheme.appColor)),
                                                ),
                                                const SizedBox(width: 8.0),
                                                ImageWidget(
                                                    imageurl: widget.matchModel.teams[1].logo != null
                                                        ? '${ServerUrls.mediaUrl}team/${widget.matchModel.teams[1].logo}'
                                                        : null,
                                                    radius: 15.0,
                                                    width: 30.0,
                                                    fit: BoxFit.cover,
                                                    height: 30),
                                              ],
                                            )),
                                ],
                              ),
                              widget.isPast
                                  ? Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: MyTextButton(
                                          width: 150,
                                          height: 40,
                                          onPressed: () {},
                                          text: "Repeat match",
                                          borderColor: CustomTheme.iconColor,
                                          textColor: CustomTheme.iconColor,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.repeat_rounded, color: CustomTheme.iconColor),
                                              Text(
                                                "Repeat match",
                                                style: Get.textTheme.bodySmall!.copyWith(
                                                    color: CustomTheme.iconColor, fontWeight: FontWeight.w600),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                              const Divider(
                                height: 4.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 3,
                                      fit: FlexFit.tight,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("${widget.matchModel.sport.name} match", style: Get.textTheme.bodySmall),
                                          Text("${Constants.getFormattedDate(widget.matchModel.date)} ${getTime()}",
                                              style: Get.textTheme.bodySmall!
                                                  .copyWith(color: CustomTheme.iconColor, fontSize: 10.0.rfs)),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              double.parse(widget.matchModel.splitCost ?? '0') > 0
                                                  ? 'OMR ${widget.matchModel.splitCost}'
                                                  : 'Free',
                                              textAlign: TextAlign.right,
                                              style: Get.textTheme.bodySmall!.copyWith(color: CustomTheme.green)),
                                          Text("per head",
                                              textAlign: TextAlign.right,
                                              style: Get.textTheme.bodySmall!
                                                  .copyWith(color: CustomTheme.textColorLight, fontSize: 10.0.rfs)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.matchModel.bookingStatus == "pending" ? 'Venue not booked' : 'Venue booked',
                            style: Get.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w400),
                          ),
                          Text(
                            widget.matchModel.activityAccess,
                            style: Get.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Material(
              color: isFriendly ? Colors.blue : Colors.brown,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(12.br)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  isFriendly ? "Friendly match" : "Challange match",
                  style: Get.textTheme.displaySmall!.copyWith(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  String getTime() {
    String time = "AM";
    if (widget.matchModel.morningAvailability.isNotEmpty) {
      time =
          "${widget.matchModel.morningAvailability.first.split("-").first} to ${widget.matchModel.morningAvailability.last.split("-").last} AM";
    }
    if (widget.matchModel.eveningAvailability.isNotEmpty) {
      time =
          "${widget.matchModel.eveningAvailability.first.split("-").first} to ${widget.matchModel.eveningAvailability.last.split("-").last} AM";
    }
    return time;
  }
}
