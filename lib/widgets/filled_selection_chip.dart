import 'package:aio_sport/controllers/home_controller.dart';
import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/controllers/veneue_manager_controller.dart';
import 'package:aio_sport/models/sports_data_model.dart';
import 'package:aio_sport/services/server_urls.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

class FilledSelectionChip extends StatefulWidget {
  final bool isSelected;
  final Sport sportModel;
  final double? radius;
  final int? index;
  const FilledSelectionChip({super.key, required this.isSelected, this.radius, required this.sportModel, this.index});

  @override
  State<FilledSelectionChip> createState() => _FilledSelectionChipState();
}

class _FilledSelectionChipState extends State<FilledSelectionChip> {
  final homeController = Get.find<HomeController>();
  final profileController = Get.find<ProfileController>();
  final manager = Get.find<VenueManagerController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          color: manager.selectedGroundSportId.value == widget.sportModel.id ? CustomTheme.iconColor : Colors.white,
          borderRadius: BorderRadius.circular(widget.radius ?? 25.br),
          border: Border.all(color: CustomTheme.iconColor, width: 1.0),
        ),
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
                  width: 50,
                  height: 50,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
                child: Text(widget.sportModel.name,
                    style: Get.textTheme.headlineSmall
                        ?.copyWith(color: manager.selectedGroundSportId.value == widget.sportModel.id ? Colors.white : CustomTheme.iconColor))),
          ],
        ),
      );
    });
  }
}
