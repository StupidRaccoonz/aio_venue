import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/models/player/player_nearby_matches_response.dart';
import 'package:aio_sport/services/server_urls.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

class PlayerMatchDetailsWidget extends StatefulWidget {
  final double height, width;
  final BoxFit? fit;
  final double? radius;
  final Match matchModel;
  final void Function() onPressed;

  const PlayerMatchDetailsWidget({
    super.key,
    required this.height,
    required this.width,
    this.fit,
    required this.matchModel,
    this.radius,
    required this.onPressed,
  });

  @override
  State<PlayerMatchDetailsWidget> createState() => _PlayerMatchDetailsWidgetState();
}

class _PlayerMatchDetailsWidgetState extends State<PlayerMatchDetailsWidget> {
  final profileController = Get.find<ProfileController>();
  // late Sport sport;
  late bool isVenueActivity;
  bool isFriendly = false;
  @override
  void initState() {
    // sport = profileController.sportsList.firstWhere((element) => element.id == widget.activityModel.sportId)
    isVenueActivity = widget.matchModel.createdBy == "venue";
    isFriendly = widget.matchModel.matchType.toLowerCase() != "challenge match";
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
          Center(
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
                      elevation: 4.0,
                      borderRadius: BorderRadius.circular(12.br),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 40.0, bottom: 8.0),
                        child: Column(
                          children: [
                            Center(child: Text("${widget.matchModel.sport.name} match", style: Get.textTheme.bodySmall)),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: widget.matchModel.teams.isEmpty
                                        ? Text("No team joined", style: Get.textTheme.headlineMedium)
                                        : Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ImageWidget(
                                                  imageurl: widget.matchModel.teams[0].logo != null
                                                      ? '${ServerUrls.mediaUrl}team/${widget.matchModel.teams[0].logo}'
                                                      : null,
                                                  fit: BoxFit.cover,
                                                  radius: 15.0,
                                                  width: 30.0,
                                                  height: 30),
                                              const SizedBox(width: 8.0),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(widget.matchModel.teams[0].name ?? "N/A",
                                                      style: Get.textTheme.bodySmall!.copyWith(color: CustomTheme.appColor)),
                                                  isVenueActivity
                                                      ? const SizedBox()
                                                      : Text("Venue Challenge", style: Get.textTheme.displaySmall!.copyWith(fontSize: 10.rfs)),
                                                ],
                                              ),
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
                                        ? Text("No team joined", textAlign: TextAlign.right, style: Get.textTheme.headlineMedium)
                                        : Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(widget.matchModel.teams[1].name ?? 'N/A',
                                                      style: Get.textTheme.bodySmall!.copyWith(color: CustomTheme.appColor)),
                                                  isVenueActivity
                                                      ? const SizedBox()
                                                      : Text(
                                                          "Opponent",
                                                          style: Get.textTheme.displaySmall!.copyWith(fontSize: 10.rfs),
                                                        ),
                                                ],
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Material(
              color: isVenueActivity
                  ? CustomTheme.appColorSecondary
                  : isFriendly
                      ? Colors.blue
                      : Colors.brown,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(12.br)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  isVenueActivity
                      ? "Venue Challange"
                      : isFriendly
                          ? "Friendly match"
                          : "Challange match",
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
