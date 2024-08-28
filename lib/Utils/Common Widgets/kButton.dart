import 'package:flutter/material.dart';

import '../colors.dart';
import '../commons.dart';

class KButton {
  static Widget full({
    required void Function()? onPressed,
    String? label,
    Color? backgroundColor,
    double? fontSize,
  }) =>
      ElevatedButton(
        onPressed: onPressed,
        child: SizedBox(
          width: double.infinity,
          child: Text(
            label ?? "label",
            textAlign: TextAlign.center,
          ),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: backgroundColor ?? kSecondaryColor,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          shape: RoundedRectangleBorder(
            borderRadius: kRadius(5),
          ),
          alignment: Alignment.center,
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: 'Jakarta',
            fontSize: fontSize,
          ),
        ),
      );

  static Widget outlined({
    required void Function()? onPressed,
    String? label,
    Color? borderColor,
    Color? textColor,
  }) =>
      MaterialButton(
        onPressed: onPressed,
        color: Colors.transparent,
        elevation: 0,
        highlightElevation: 0,
        disabledElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: kRadius(5),
          side: BorderSide(
            color: borderColor ?? Colors.white,
          ),
        ),
        visualDensity: VisualDensity.compact,
        child: Text(
          label ?? "label",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontWeight: FontWeight.w600,
            fontFamily: 'Jakarta',
            fontSize: 12,
          ),
        ),
      );

  static Widget regular({
    required void Function()? onPressed,
    String? label,
    Color? backgroundColor,
    double? fontSize,
  }) =>
      ElevatedButton(
        onPressed: onPressed ?? () {},
        child: Text(
          label ?? "label",
          textAlign: TextAlign.center,
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: backgroundColor ?? kPrimaryColor,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          shape: RoundedRectangleBorder(
            borderRadius: kRadius(5),
          ),
          alignment: Alignment.center,
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: 'Jakarta',
            fontSize: fontSize,
          ),
        ),
      );

  static Widget icon({
    required void Function()? onPressed,
    String? label,
    Color? backgroundColor,
    double? fontSize,
    Widget? icon,
    EdgeInsetsGeometry? padding,
    Color? textColor,
  }) =>
      ElevatedButton(
        onPressed: onPressed ?? () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label ?? "label",
              textAlign: TextAlign.center,
            ),
            icon ?? SizedBox.shrink(),
          ],
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: backgroundColor ?? kPrimaryColor,
          foregroundColor: textColor ?? Colors.white,
          padding:
              padding ?? EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          shape: RoundedRectangleBorder(
            borderRadius: kRadius(5),
          ),
          alignment: Alignment.center,
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: 'Jakarta',
            fontSize: fontSize,
            // color: textColor,
          ),
        ),
      );

  static Widget pill({
    required void Function()? onPressed,
    required String label,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: kRadius(100),
          ),
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 15)),
      child: Text(label),
    );
  }

  static Widget thickPill({
    required void Function()? onPressed,
    required String label,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: kRadius(100),
        ),
        backgroundColor: kSecondaryColor,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
      child: Text(label),
    );
  }
}
