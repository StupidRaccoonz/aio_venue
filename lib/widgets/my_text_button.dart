import 'package:aio_sport/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

class MyTextButton extends StatefulWidget {
  final double width, height;
  final void Function() onPressed;
  final String text;
  final Color? textColor, borderColor;
  final Widget? child;
  final TextStyle? textStyle;
  const MyTextButton({
    super.key,
    required this.width,
    required this.height,
    required this.onPressed,
    required this.text,
    this.textStyle,
    this.textColor,
    this.borderColor,
    this.child,
  });

  @override
  State<MyTextButton> createState() => _MyTextButtonState();
}

class _MyTextButtonState extends State<MyTextButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.br), side: BorderSide(width: 1.0, color: widget.borderColor ?? CustomTheme.borderColor)),
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: InkWell(
          onTap: widget.onPressed,
          borderRadius: BorderRadius.circular(20.br),
          child: Center(
              child: widget.child ??
                  Text(
                    widget.text,
                    style: widget.textStyle ??
                        Get.textTheme.titleSmall!.copyWith(color: widget.textColor ?? CustomTheme.appColorSecondary, fontWeight: FontWeight.w600),
                  )),
        ),
      ),
    );
  }
}
