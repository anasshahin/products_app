import 'package:flutter/material.dart';

import '../utils/styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.backgroundColor,
    required this.textColor,
    required this.text,
    required this.onPressed,
    this.horizontalPadding,
    this.fontSize,
    this.borderRadius,
    this.elevation,
  });

  final String text;
  final Color backgroundColor;
  final Color textColor;
  final BorderRadius ? borderRadius;
  final double ? fontSize;
  final double ?horizontalPadding;
  final double? elevation;

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.0,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          elevation: elevation,
          padding:  EdgeInsets.symmetric(horizontal: horizontalPadding??8),
          backgroundColor: backgroundColor,
          //  padding: const EdgeInsets.symmetric(horizontal: double.maxFinite),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(
              16,
            ),
          ),
        ),
        child: Text(
          text,
          style: Styles.textStyle18.copyWith(
            color: textColor,
            fontWeight: FontWeight.w700,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
