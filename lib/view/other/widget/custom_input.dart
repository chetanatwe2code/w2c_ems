import 'package:attendance/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? textController;
  final String? hintText;
  final String? labelText;
  final int? maxLength;
  final bool obscureText;
  final bool enabled;
  final int maxLine;
  final Color? textColor;
  final Color? fillColor;
  final double horizontalPadding;
  final double borderRadius;
  final double fontSize;
  final bool border;
  final TextInputType? keyboardType;
  final Function(String string)? onTextChanged;

  const CustomInput({
    Key? key,
    this.suffixIcon,
    this.prefixIcon,
    this.textController,
    this.hintText,
    this.labelText,
    this.obscureText = false,
    this.enabled = true,
    this.maxLine = 1,
    this.textColor,
    this.fillColor,
    this.maxLength,
    this.border = true,
    this.borderRadius = 10,
    this.horizontalPadding = 10.0,
    this.fontSize = 14,
    this.keyboardType,
    this.onTextChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLine,
      maxLength: maxLength,
      keyboardType: keyboardType,
      controller: textController,
      autofocus: false,
      onChanged: onTextChanged,
      obscureText: obscureText,
      enabled: enabled,
      style: TextStyle(
        fontSize: fontSize,
        color: textColor ?? AppColors.textColor(),
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor ?? AppColors.whiteColor(),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hintText,
        hintStyle: TextStyle(fontSize: fontSize),
        labelStyle: TextStyle(fontSize: fontSize),
        labelText: labelText,
        counterText: "",
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: horizontalPadding),
        focusedBorder: !border ? null : OutlineInputBorder(
          borderSide: const BorderSide(
            //width: 1,
            color: AppColors.primaryDark,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 0.5,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
    return TextField(
      maxLines: maxLine,
      maxLength: maxLength,
      keyboardType: keyboardType,
      controller: textController,
      autofocus: false,
      onChanged: onTextChanged,
      obscureText: obscureText,
      enabled: enabled,
      style: TextStyle(
          fontSize: 14,
          color: textColor ?? AppColors.textColor()
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor ?? AppColors.whiteColor(),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hintText,
        hintStyle: const TextStyle(
            fontSize: 14
        ),
        labelStyle: const TextStyle(
            fontSize: 14
        ),
        labelText: labelText,
        counterText: "",
        contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: Colors.green)),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: Colors.grey)),
      ),
    );
  }
}
