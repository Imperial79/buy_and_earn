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
            borderRadius: kRadius(12),
          ),
          alignment: Alignment.center,
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
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
      ElevatedButton(
        onPressed: onPressed,
        child: Text(
          label ?? "label",
          textAlign: TextAlign.center,
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: textColor ?? Colors.white,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          visualDensity: VisualDensity.compact,
          shape: RoundedRectangleBorder(
            borderRadius: kRadius(7),
            side: BorderSide(
              color: borderColor ?? Colors.white,
            ),
          ),
          alignment: Alignment.center,
          textStyle: TextStyle(
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
            borderRadius: kRadius(12),
          ),
          alignment: Alignment.center,
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
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
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          shape: RoundedRectangleBorder(
            borderRadius: kRadius(12),
          ),
          alignment: Alignment.center,
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
            fontSize: fontSize,
          ),
        ),
      );
}
