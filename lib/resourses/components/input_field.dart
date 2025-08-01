import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../app_colors/app_colors.dart';

class InputField extends StatelessWidget {
  final String? hintText;
  final double paddingLeft;
  final double paddingTop;
  final double paddingRight;
  final double paddingBottom;
  final bool obscureText;
  final double width;
  final int limit;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double prefixIconWidth;
  final double contentPadding;
  final double placeholderSize;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Color fillColor;
  final bool enableBorder;
  final bool isDense;
  final String? labelText;
  final String? initialValue;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final int? maxLines;
  final bool? readOnly;
  final void Function(String?)? onSaved;
  final Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final Color? errorcolor;
  final void Function(String)? onChanged;

  const InputField({
    super.key,
    this.onSaved,
    this.hintText,
    this.paddingLeft = 0.0,
    this.paddingTop = 0.0,
    this.paddingRight = 0.0,
    this.paddingBottom = 0.0,
    this.obscureText = false,
    this.width = double.infinity,
    this.limit = 255,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixIconWidth = 35,
    this.contentPadding = 18,
    this.placeholderSize = 16,
    this.controller,
    this.validator,
    this.fillColor = const Color(0xFF2A2D3E), // Updated background
    this.enableBorder = true,
    this.isDense = false,
    this.labelText,
    this.initialValue,
    this.textStyle,
    this.labelStyle,
    this.maxLines = 1,
    this.readOnly,
    this.onTap,
    this.inputFormatters,
    this.errorcolor,
    this.keyboardType,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: paddingLeft,
          top: paddingTop,
          right: paddingRight,
          bottom: paddingBottom),
      width: width,
      child: TextFormField(
        validator: validator,
        controller: controller,
        maxLength: limit,
        inputFormatters: inputFormatters,
        onTap: onTap,
        onChanged: onChanged,
        onSaved: onSaved,
        keyboardType: keyboardType ?? TextInputType.text,
        readOnly: readOnly ?? false,
        style: textStyle ?? TextStyle(color: AppColors.black),
        maxLines: maxLines,
        decoration: InputDecoration(
          errorStyle: TextStyle(color: errorcolor ?? Colors.redAccent),
          prefixIcon: prefixIcon != null
              ? Padding(
            padding: const EdgeInsets.only(left: 10, right: 5),
            child: prefixIcon,
          )
              : null,
          suffixIcon: suffixIcon != null
              ? Padding(
            padding: const EdgeInsets.only(left: 10, right: 5),
            child: suffixIcon,
          )
              : null,
          isDense: isDense,
          prefixIconConstraints: BoxConstraints(maxWidth: prefixIconWidth),
          hintText: hintText,
          labelText: labelText,
          hintStyle: TextStyle(
            fontSize: placeholderSize,
            color: Colors.black45,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: enableBorder ? AppColors.accentColor : AppColors.primaryColor,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColors.accentColor,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: fillColor.withOpacity(0.8), // Soft Transparent Background
          contentPadding: EdgeInsets.all(contentPadding),
          border: OutlineInputBorder(),
          counterText: '',
          labelStyle: labelStyle ?? TextStyle(color: Colors.white),
        ),
        initialValue: initialValue,
        obscureText: obscureText,
      ),
    );
  }
}
