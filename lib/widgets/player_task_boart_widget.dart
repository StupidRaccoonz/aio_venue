import 'package:aio_sport/controllers/player_manager_controller.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

class PlayerTaskBoardWidget extends StatefulWidget {
  final double? height, width;
  const PlayerTaskBoardWidget({super.key, this.height, this.width});

  @override
  State<PlayerTaskBoardWidget> createState() => _PlayerTaskBoardWidgetState();
}

class _PlayerTaskBoardWidgetState extends State<PlayerTaskBoardWidget> {
  final manager = Get.find<PlayerManagerController>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Stack(
        children: [
          Image.asset("assets/images/rectangle_player.png", height: widget.height ?? 200, fit: BoxFit.fill),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Create a friendly match", style: Get.textTheme.bodySmall),
                Text("40 pts", style: Get.textTheme.bodySmall!.copyWith(color: CustomTheme.textColorLight, fontSize: 10.0.rfs)),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 2.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: LinearProgressIndicator(
                      backgroundColor: CustomTheme.grey.withAlpha(50),
                      color: CustomTheme.iconColor,
                      minHeight: 12.0,
                      value: 0.1,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(child: Text("Weekly task", style: Get.textTheme.bodySmall!.copyWith(color: CustomTheme.textColorLight, fontSize: 10.0.rfs))),
                    Text("0/3", style: Get.textTheme.bodySmall!.copyWith(color: CustomTheme.textColorLight, fontSize: 10.0.rfs)),
                  ],
                ),
                const Spacer(),
                Center(
                    child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                    child: Text("View all", style: Get.textTheme.bodySmall!.copyWith(color: CustomTheme.iconColor, fontSize: 10.0.rfs)),
                  ),
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
