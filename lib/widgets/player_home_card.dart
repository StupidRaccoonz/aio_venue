import 'package:aio_sport/widgets/icon_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayerHomeCardWidget extends StatefulWidget {
  final double? width, height;
  final String asset, title;
  final Function() onTap;
  const PlayerHomeCardWidget({super.key, this.width, this.height, required this.asset, required this.title, required this.onTap});

  @override
  State<PlayerHomeCardWidget> createState() => _PlayerHomeCardWidgetState();
}

class _PlayerHomeCardWidgetState extends State<PlayerHomeCardWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Material(
          child: InkWell(
        onTap: widget.onTap,
        child: Stack(
          children: [
            Image.asset(
              "assets/icons/${widget.asset}",
              width: double.maxFinite,
              height: widget.height,
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              child: SizedBox(
                width: (widget.width ?? 200) / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(widget.title, style: Get.textTheme.bodySmall),
                    IconButtonWidget(icon: Icons.arrow_forward_rounded, onPressed: widget.onTap),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
