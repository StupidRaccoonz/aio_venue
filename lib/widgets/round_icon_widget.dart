import 'package:aio_sport/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:scaled_size/scaled_size.dart';

class RoundIconButtonWidget extends StatefulWidget {
  final IconData icon;
  final Color? iconColor;
  final Color? buttonColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  final void Function() onPressed;
  const RoundIconButtonWidget(
      {super.key, required this.icon, required this.onPressed, this.iconColor, this.buttonColor, this.borderColor, this.width, this.height});

  @override
  State<RoundIconButtonWidget> createState() => _RoundIconButtonWidgetState();
}

class _RoundIconButtonWidgetState extends State<RoundIconButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 5.vh,
      height: widget.height ?? 5.vh,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: widget.buttonColor ?? Colors.white24,
        border: Border.all(color: widget.borderColor ?? Colors.transparent),
        borderRadius: BorderRadius.circular(25.br),
      ),
      child: InkWell(
        onTap: widget.onPressed,
        splashColor: CustomTheme.borderColor,
        borderRadius: BorderRadius.circular(25.br),
        child: Icon(
          widget.icon,
          color: widget.iconColor ?? CustomTheme.appColorSecondary,
          size: 2.5.vh,
        ),
      ),
    );
  }
}
