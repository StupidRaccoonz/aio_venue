import 'package:aio_sport/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

class InputFieldWidget extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? initalValue;
  final Widget? leadingIcon, trailingIcon;
  final String? prefixText, suffixText;
  final void Function(String)? onChange;
  final String? Function(String?)? validate;
  final TextEditingController? textEditingController;
  final void Function()? onTap;
  final void Function()? onTrailingTap;
  final TextInputType? inputType;
  final TextStyle? textStyle;
  final bool? readOnly;
  final int? maxlength;
  final bool? obsecureText;
  final Color? textColor;
  final TextCapitalization? capitalization;
  final TextInputAction? inputAction;

  const InputFieldWidget(
      {super.key,
      this.label,
      this.hint,
      this.leadingIcon,
      this.trailingIcon,
      this.onChange,
      this.validate,
      this.textStyle,
      this.textEditingController,
      this.onTrailingTap,
      this.onTap,
      this.readOnly,
      this.initalValue,
      this.inputType,
      this.textColor,
      this.obsecureText,
      this.prefixText,
      this.suffixText,
      this.maxlength,
      this.capitalization,
      this.inputAction});

  @override
  State<InputFieldWidget> createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  bool obsecure = false;
  @override
  void initState() {
    super.initState();
    obsecure = widget.obsecureText ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChange,
      validator: widget.validate,
      controller: widget.textEditingController,
      style: widget.textStyle ??
          Get.textTheme.headlineLarge!
              .copyWith(color: widget.textColor ?? CustomTheme.appColor, fontWeight: FontWeight.w500),
      onTap: widget.onTap,
      textCapitalization: widget.capitalization ?? TextCapitalization.sentences,
      keyboardType: widget.inputType,
      readOnly: widget.readOnly ?? false,
      maxLength: widget.maxlength,
      obscureText: obsecure,
      initialValue: widget.initalValue,
      textInputAction: widget.inputAction ?? TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: widget.leadingIcon,
          hintText: widget.hint,
          contentPadding: EdgeInsets.only(bottom: 10),
          prefixIconConstraints: BoxConstraints(minWidth: 20.rh, maxWidth: 20.rh, minHeight: 15.rh, maxHeight: 15.rh),
          // prefix: Padding(
          //   padding: const EdgeInsets.only(right: 8.0),
          //   child: SizedBox(width: 20.rh, height: 15.rh, child: widget.leadingIcon),
          // ),
          prefixIconColor: CustomTheme.textColor,
          suffixIconConstraints: BoxConstraints(
            minWidth: 25.rh,
            maxWidth: 25.rh,
            minHeight: 20.rh,
            maxHeight: 20.rh,
          ),
          floatingLabelStyle: Get.textTheme.labelSmall,
          labelStyle: Get.textTheme.displaySmall,
          hintStyle: Get.textTheme.displaySmall,
          prefixText: "${widget.prefixText ?? ''} ",
          prefixStyle: widget.textStyle ??
              Get.textTheme.headlineLarge!
                  .copyWith(color: widget.textColor ?? CustomTheme.textColor2, fontWeight: FontWeight.w500),
          suffixText: widget.suffixText,
          suffixStyle: widget.textStyle ?? Get.textTheme.bodyLarge!.copyWith(color: widget.textColor),
          border: border,
          enabledBorder: border,
          focusedBorder: border,
          labelText: widget.label,
          suffixIcon: widget.trailingIcon != null
              ? Center(
                  child: InkWell(
                    onTap: widget.onTrailingTap ??
                        () {
                          obsecure = !obsecure;
                          setState(() {});
                        },
                    child: widget.trailingIcon,
                  ),
                )
              : null,
          counter: const SizedBox()),
    );
  }

  final border = UnderlineInputBorder(borderSide: BorderSide(width: 2.0, color: CustomTheme.borderColor));
}
