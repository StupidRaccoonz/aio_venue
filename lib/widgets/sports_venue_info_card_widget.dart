import 'package:aio_sport/models/player/sports_venue_list_model.dart';
import 'package:aio_sport/services/server_urls.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

class SportsVenueInfoCardWidget extends StatefulWidget {
  final Venue venueData;
  final double? height, width;
  final Function() onPressed;
  const SportsVenueInfoCardWidget({super.key, required this.venueData, this.height, this.width, required this.onPressed});

  @override
  State<SportsVenueInfoCardWidget> createState() => _SportsVenueInfoCardWidgetState();
}

class _SportsVenueInfoCardWidgetState extends State<SportsVenueInfoCardWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Material(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: CustomTheme.borderColor),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: LayoutBuilder(builder: (context, constaints) {
              return InkWell(
                borderRadius: BorderRadius.circular(16.0),
                onTap: widget.onPressed,
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
                        child: ImageWidget(
                          imageurl: widget.venueData.profilePicture == null ? null : '${ServerUrls.mediaUrl}venue/${widget.venueData.profilePicture}',
                          width: widget.width ?? constaints.maxWidth,
                          height: constaints.maxHeight * 0.4,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(flex: 2, fit: FlexFit.tight, child: Text(widget.venueData.name, style: Get.textTheme.titleSmall)),
                                  Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          widget.venueData.grounds.isNotEmpty
                                              ? Text("OMR ${widget.venueData.grounds.first.hourlyRent ?? '0'}",
                                                  style: Get.textTheme.titleSmall!.copyWith(color: CustomTheme.green))
                                              : const SizedBox(),
                                          Text("/h", style: Get.textTheme.headlineSmall!.copyWith(color: CustomTheme.grey, fontSize: 10.0.rfs))
                                        ],
                                      )),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: widget.venueData.sports
                                      .map((e) => Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text("${e.name}", style: Get.textTheme.headlineSmall!.copyWith(color: CustomTheme.grey, fontSize: 10.0.rfs)),
                                              const SizedBox(width: 4.0),
                                              Icon(
                                                Icons.circle,
                                                color: CustomTheme.borderColor,
                                                size: 10.0,
                                              ),
                                              const SizedBox(width: 6.0)
                                            ],
                                          ))
                                      .toList(),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("${widget.venueData.distance} Km ;",
                                      style: Get.textTheme.headlineSmall!.copyWith(color: CustomTheme.grey, fontSize: 10.0.rfs)),
                                  Text(widget.venueData.name, style: Get.textTheme.headlineSmall!.copyWith(color: CustomTheme.grey, fontSize: 10.0.rfs)),
                                ],
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              );
            })),
      ),
    );
  }
}
