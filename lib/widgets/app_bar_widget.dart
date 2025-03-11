import 'package:aio_sport/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

class AppbarWidget extends StatelessWidget {
  final String title;
  final bool? bottomRound;
  final double? height;
  final TextStyle? textStyle;
  final Widget? leading;
  final Widget? bottomWidget;
  final Widget? actionIcon;
  const AppbarWidget(
      {super.key,
      required this.title,
      this.leading,
      this.actionIcon,
      this.bottomRound,
      this.height,
      this.bottomWidget,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: height ?? 14.vh,
      child: Material(
        color: CustomTheme.appColor,
        shape: (bottomRound ?? true)
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(13.br),
                ),
              )
            : null,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 12.0),
                  Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: leading != null
                          ? CircleAvatar(backgroundColor: Colors.grey.withOpacity(0.7), child: leading)
                          : const SizedBox()),
                  Flexible(
                    flex: 5,
                    fit: FlexFit.tight,
                    child: Center(
                      child: Text(
                        title,
                        style: textStyle ??
                            TextStyle(
                                fontSize: 20.rfs, color: Colors.white, fontWeight: FontWeight.w400, letterSpacing: 1.2),
                      ),
                    ),
                  ),
                  Flexible(flex: 1, fit: FlexFit.tight, child: actionIcon ?? const SizedBox()),
                ],
              ),
              bottomWidget ?? const SizedBox()
            ],
          ),
        )),
      ),
    );
  }
}
