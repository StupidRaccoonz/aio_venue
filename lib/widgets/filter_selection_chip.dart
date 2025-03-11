import 'package:aio_sport/controllers/veneue_manager_controller.dart';
import 'package:aio_sport/models/sports_data_model.dart';
import 'package:aio_sport/services/server_urls.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

class FilterSelectionChip extends StatefulWidget {
  final Sport sportModel;
  final double? radius;
  final int index;
  final int? selectedIndex;
  final bool isVenueActivity;
  final void Function()? onPressed;
  const FilterSelectionChip(
      {super.key,
      this.radius,
      required this.sportModel,
      required this.index,
      this.selectedIndex,
      this.onPressed,
      required this.isVenueActivity});

  @override
  State<FilterSelectionChip> createState() => _FilterSelectionChipState();
}

class _FilterSelectionChipState extends State<FilterSelectionChip> {
  final manager = Get.find<VenueManagerController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      int selectedIndex = widget.isVenueActivity
          ? manager.selectedSportForVenueActivityIndex.value
          : manager.selectedSportForOtherActivityIndex.value;
      return Material(
        child: Container(
          decoration: BoxDecoration(
            color: widget.index == selectedIndex ? CustomTheme.iconColor : Colors.white,
            borderRadius: BorderRadius.circular(widget.radius ?? 25.br),
            border: Border.all(color: CustomTheme.borderColor, width: 1.0),
          ),
          child: InkWell(
            onTap: widget.isVenueActivity
                ? widget.onPressed
                : () {
                    if (widget.isVenueActivity) {
                      manager.selectedSportForVenueActivityIndex.value = widget.index;
                      manager.selectedSportForVenueActivityIndex.refresh();
                    } else {
                      manager.selectedSportForOtherActivityIndex.value = widget.index;
                      manager.selectedSportForOtherActivityIndex.refresh();
                    }
                  },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.br),
                    child: CachedNetworkImage(
                      imageUrl: "${ServerUrls.mediaUrl}sports/${widget.sportModel.image}",
                      width: 40,
                      height: 40,
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 4.0),
                Text(
                  widget.sportModel.name,
                  style: Get.textTheme.headlineSmall?.copyWith(
                    color: widget.index != selectedIndex ? CustomTheme.textColor : Colors.white,
                  ),
                ),
                const SizedBox(width: 16.0),
              ],
            ),
          ),
        ),
      );
    });
  }
}
