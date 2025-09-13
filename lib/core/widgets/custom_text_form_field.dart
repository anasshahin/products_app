import 'package:flutter/material.dart';

import '../utils/app_color.dart';
class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool enabled;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final bool autofocus;
  final TextCapitalization textCapitalization;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final Color? fillColor;
  final bool filled;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final TextStyle? errorStyle;
  final Color? cursorColor;
  final double? cursorHeight;
  final double? cursorWidth;
  final bool showCursor;
  final bool readOnly;
  final void Function()? onTap;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final AutovalidateMode? autovalidateMode;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.initialValue,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.onFieldSubmitted,
    this.focusNode,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.none,
    this.contentPadding,
    this.border,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.fillColor,
    this.filled = false,
    this.labelStyle,
    this.hintStyle,
    this.textStyle,
    this.errorStyle,
    this.cursorColor,
    this.cursorHeight,
    this.cursorWidth,
    this.showCursor = true,
    this.readOnly = false,
    this.onTap,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.autovalidateMode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: border ?? _defaultBorder(),
        enabledBorder: border ?? _defaultBorder(),
        focusedBorder: focusedBorder ?? _focusedBorder(),
        errorBorder: errorBorder ?? _errorBorder(),
        focusedErrorBorder: focusedErrorBorder ?? _focusedErrorBorder(),
        fillColor: fillColor ?? (filled ? AppColor.whiteColor : null),
        filled: filled,
        labelStyle: labelStyle ??
            const TextStyle(
              color: AppColor.darkGreyColor,
              fontSize: 14,
            ),
        hintStyle: hintStyle ??
            const TextStyle(
              color: AppColor.greyColor,
              fontSize: 14,
            ),
        errorStyle: errorStyle ??
            const TextStyle(
              color: AppColor.redColor,
              fontSize: 12,
            ),
        counterStyle: const TextStyle(
          color: AppColor.greyColor,
          fontSize: 12,
        ),
      ),
      style: textStyle ??
          const TextStyle(
            color: AppColor.blackColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
      initialValue: initialValue,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      enabled: enabled,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      focusNode: focusNode,
      autofocus: autofocus,
      textCapitalization: textCapitalization,
      cursorColor: cursorColor ?? AppColor.primaryColor,
      cursorHeight: cursorHeight,
      cursorWidth: cursorWidth ?? 2.0,
      showCursor: showCursor,
      readOnly: readOnly,
      onTap: onTap,
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      autovalidateMode: autovalidateMode,
    );
  }

  InputBorder _defaultBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: AppColor.transGreyColor,
        width: 1.5,
      ),
    );
  }

  InputBorder _focusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: AppColor.primaryColor,
        width: 2.0,
      ),
    );
  }

  InputBorder _errorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: AppColor.redColor,
        width: 1.5,
      ),
    );
  }

  InputBorder _focusedErrorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: AppColor.redColor,
        width: 2.0,
      ),
    );
  }
}