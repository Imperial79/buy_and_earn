import 'package:flutter/material.dart';

import '../colors.dart';
import '../commons.dart';

class KButton {
  final void Function()? onPressed;
  final String label;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double fontSize;
  final Widget? icon;
  final EdgeInsetsGeometry? padding;
  final ButtonStyle? customStyle;

  KButton({
    required this.onPressed,
    this.label = "Label",
    this.backgroundColor = Light.primary,
    this.foregroundColor = Colors.white,
    this.fontSize = 15,
    this.icon,
    this.padding,
    this.customStyle,
  });

  // Helper method for common button styles
  ButtonStyle _buttonStyle({
    Color? backgroundColor,
    Color? foregroundColor,
    BorderSide? side,
    EdgeInsetsGeometry? padding,
    double borderRadius = 15,
    double elevation = 0,
  }) =>
      ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        side: side,
        padding: padding ??
            this.padding ??
            const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        shape: RoundedRectangleBorder(
          borderRadius: kRadius(borderRadius),
        ),
        elevation: elevation,
        alignment: Alignment.center,
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          fontFamily: 'Jakarta',
        ),
      );

  // Full-width button
  Widget get full => ElevatedButton(
        onPressed: onPressed,
        style: customStyle ??
            _buttonStyle(
              backgroundColor: backgroundColor ?? Light.secondary,
              foregroundColor: foregroundColor ?? Colors.white,
            ),
        child: SizedBox(
          width: double.infinity,
          child: Text(
            label,
            textAlign: TextAlign.center,
          ),
        ),
      );

  // Outlined full-width button
  Widget get outlinedFull => ElevatedButton(
        onPressed: onPressed,
        style: customStyle ??
            _buttonStyle(
              side: BorderSide(color: backgroundColor ?? Light.primary),
              backgroundColor: Light.scaffold,
              foregroundColor: backgroundColor ?? Light.primary,
            ),
        child: SizedBox(
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Padding(padding: const EdgeInsets.only(right: 10), child: icon),
              Text(
                label,
                style:
                    TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      );

  // Outlined regular button
  Widget get outlinedRegular => ElevatedButton(
        onPressed: onPressed,
        style: customStyle ??
            _buttonStyle(
              side: BorderSide(color: backgroundColor ?? Light.primary),
              backgroundColor: Colors.transparent,
              foregroundColor: backgroundColor ?? Light.primary,
              padding: const EdgeInsets.symmetric(horizontal: 15),
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(padding: const EdgeInsets.only(right: 10), child: icon),
            Text(
              label,
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );

  // Regular button
  Widget get regular => ElevatedButton(
        onPressed: onPressed,
        style: customStyle ??
            _buttonStyle(
              backgroundColor: backgroundColor ?? Light.primary,
              foregroundColor: foregroundColor ?? Colors.white,
            ),
        child: Text(
          label,
          textAlign: TextAlign.center,
        ),
      );

  // Icon button
  Widget get withIcon => ElevatedButton(
        onPressed: onPressed,
        style: customStyle ??
            _buttonStyle(
              backgroundColor: backgroundColor ?? Light.primary,
              foregroundColor: foregroundColor ?? Colors.white,
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              textAlign: TextAlign.center,
            ),
            icon ?? const SizedBox.shrink(),
          ],
        ),
      );

  // Pill button
  Widget get pill => TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: kRadius(100),
          ),
          backgroundColor: backgroundColor ?? Light.primary,
          foregroundColor: Colors.white,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 15),
        ),
        child: Text(label),
      );

  // Thick pill button
  Widget get thickPill => ElevatedButton(
        onPressed: onPressed,
        style: customStyle ??
            _buttonStyle(
              backgroundColor: backgroundColor ?? Light.secondary,
              foregroundColor: foregroundColor ?? Colors.white,
              padding: padding ??
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
              borderRadius: 100,
            ),
        child: Text(
          label,
          style: TextStyle(fontSize: fontSize),
        ),
      );
}
