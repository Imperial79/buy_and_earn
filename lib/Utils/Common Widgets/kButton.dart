import 'package:flutter/material.dart';

import '../colors.dart';
import '../commons.dart';

class KButton {
  static Widget full({
    required void Function()? onPressed,
    String? label,
    Color? backgroundColor,
    Color? textColor,
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
          foregroundColor: textColor ?? Colors.white,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          shape: RoundedRectangleBorder(
            borderRadius: kRadius(5),
          ),
          alignment: Alignment.center,
          textStyle: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontFamily: 'Jakarta',
            fontSize: fontSize,
          ),
        ),
      );

  static Widget outlinedFull({
    required void Function()? onPressed,
    String label = "Label",
    Color? color,
    Widget? icon,
    double fontSize = 17,
  }) =>
      ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          side: BorderSide(
            color: color ?? kPrimaryColor,
          ),
          foregroundColor: color ?? kPrimaryColor,
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        child: SizedBox(
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: icon,
                ),
              Text(
                label,
                style:
                    TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
  static Widget outlinedRegular({
    required void Function()? onPressed,
    String label = "Label",
    Color? color,
    Widget? icon,
    double fontSize = 17,
  }) =>
      ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          side: BorderSide(
            color: color ?? kPrimaryColor,
          ),
          foregroundColor: color ?? kPrimaryColor,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          padding: EdgeInsets.symmetric(
            horizontal: 15,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: icon,
              ),
            Text(
              label,
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ],
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

  static Widget thickPill(
      {required void Function()? onPressed,
      required String label,
      Color? backgroundColor,
      double? fontSize = 15,
      EdgeInsetsGeometry? padding}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: kRadius(100),
        ),
        backgroundColor: backgroundColor ?? kSecondaryColor,
        foregroundColor: Colors.white,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 20, vertical: 17),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }
}
