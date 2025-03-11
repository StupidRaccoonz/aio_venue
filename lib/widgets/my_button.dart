import 'package:aio_sport/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

class MyButton extends StatefulWidget {
  final void Function()? onPressed;
  final String text;
  final TextStyle? textStyle;
  final double? width;
  final double? height;
  final double? radius;
  final double? verticalPadding;
  final double? horizontalPadding;
  final Color? bgColor;
  const MyButton(
      {super.key,
      this.onPressed,
      required this.text,
      this.textStyle,
      this.width,
      this.radius,
      this.height,
      this.bgColor,
      this.verticalPadding,
      this.horizontalPadding});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.bgColor ?? CustomTheme.appColorSecondary,
        foregroundColor: Colors.white,
        minimumSize: widget.height == null ? Size(widget.width ?? 200, 50.0) : Size(widget.width ?? double.maxFinite, widget.height!),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.radius ?? 25.br)),
        elevation: 5.0,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: widget.verticalPadding ?? 12.0, horizontal: widget.horizontalPadding ?? 12.0),
        child: Text(widget.text, style: widget.textStyle ?? Get.textTheme.labelMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
