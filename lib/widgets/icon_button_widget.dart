import 'package:aio_sport/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:scaled_size/scaled_size.dart';

class IconButtonWidget extends StatefulWidget {
  final IconData icon;
  final Color? iconColor;
  final Color? buttonColor;
  final Color? borderColor;
  final void Function() onPressed;
  const IconButtonWidget({super.key, required this.icon, required this.onPressed, this.iconColor, this.buttonColor, this.borderColor});

  @override
  State<IconButtonWidget> createState() => _IconButtonWidgetState();
}

class _IconButtonWidgetState extends State<IconButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.buttonColor,
      shape: RoundedRectangleBorder(side: BorderSide(color: widget.borderColor ?? CustomTheme.borderColor), borderRadius: BorderRadius.circular(25.br)),
      child: InkWell(
        onTap: widget.onPressed,
        splashColor: CustomTheme.borderColor,
        borderRadius: BorderRadius.circular(25.br),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          child: Icon(
            widget.icon,
            color: widget.iconColor ?? CustomTheme.appColorSecondary,
          ),
        ),
      ),
    );
  }
}
