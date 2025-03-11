import 'package:aio_sport/services/server_urls.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VenueListWidget extends StatefulWidget {
  final String imageUrl, venueName, venueCity;
  final int index;
  final int selectedVenue;
  final void Function(int?) onChanged;
  const VenueListWidget(
      {super.key,
      required this.imageUrl,
      required this.venueName,
      required this.venueCity,
      required this.index,
      required this.onChanged,
      required this.selectedVenue});

  @override
  State<VenueListWidget> createState() => _VenueListWidgetState();
}

class _VenueListWidgetState extends State<VenueListWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => widget.onChanged(widget.index),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: ImageWidget(
                  imageurl: "${ServerUrls.mediaUrl}venue/${widget.imageUrl}",
                  height: 50.0,
                  width: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.venueName,
                      style: Get.textTheme.labelSmall!.copyWith(color: CustomTheme.appColor),
                    ),
                    Text(
                      widget.venueCity,
                      style: Get.textTheme.displaySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Radio(value: widget.index, groupValue: widget.selectedVenue, onChanged: widget.onChanged)
            ],
          ),
        ),
      ),
    );
  }
}
