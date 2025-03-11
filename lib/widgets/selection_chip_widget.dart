import 'package:aio_sport/controllers/home_controller.dart';
import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/models/sports_data_model.dart';
import 'package:aio_sport/services/server_urls.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';
import 'image_widget.dart';

typedef MyCallback = void Function(bool val);

class SelectionChip extends StatefulWidget {
  final bool isAdded;
  final Sport sportModel;
  final double? radius;
  final int? index;
  final MyCallback? callBack;
  final Function()? onRemove;
  final bool? isSelected;
  const SelectionChip({super.key, required this.isAdded, this.radius, required this.sportModel, this.index, this.callBack, this.onRemove, this.isSelected});

  @override
  State<SelectionChip> createState() => _SelectionChipState();
}

class _SelectionChipState extends State<SelectionChip> {
  bool selected = false;
  final homeController = Get.find<HomeController>();
  final profileController = Get.find<ProfileController>();

  @override
  void initState() {
    selected = widget.isSelected ?? false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isAdded
          ? null
          : () {
              selected = !selected;
              if (widget.callBack != null) {
                widget.callBack!(selected);
              }
              setState(() {});
            },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius ?? 25.br),
          border: Border.all(
              color: selected
                  ? CustomTheme.iconColor
                  : widget.isAdded
                      ? CustomTheme.iconColor
                      : CustomTheme.borderColor,
              width: widget.isAdded ? 1.0 : 2.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.br),
                child: ImageWidget(imageurl: "${ServerUrls.mediaUrl}sports/${widget.sportModel.image}", height: 40.0, width: 40.0, fit: BoxFit.cover),
              ),
            ),
            Text(
              widget.sportModel.name,
              style: Get.textTheme.headlineSmall?.copyWith(color: selected ? CustomTheme.iconColor : CustomTheme.textColor),
            ),
            const Spacer(),
            widget.isAdded
                ? GestureDetector(
                    onTap: () {
                      widget.onRemove!();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.close, size: 15.rh),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
