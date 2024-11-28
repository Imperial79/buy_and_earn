import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';

class Label {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final int? maxLines;
  Label(
    this.text, {
    this.color,
    this.fontSize,
    this.fontWeight,
    this.maxLines,
  });

  Widget get title => Text(
        text,
        style: TextStyle(
          fontSize: fontSize ?? 20,
          color: color,
          fontWeight: fontWeight ?? FontWeight.w600,
        ),
        maxLines: maxLines,
        overflow: maxLines != null ? TextOverflow.ellipsis : null,
      );
  Widget get subtitle => Text(
        text,
        style: TextStyle(
          fontSize: fontSize ?? 12,
          color: color,
          fontWeight: fontWeight ?? FontWeight.w500,
        ),
        maxLines: maxLines,
        overflow: maxLines != null ? TextOverflow.ellipsis : null,
      );

  Widget get spread => Center(
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            letterSpacing: 3,
            wordSpacing: 5,
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: color ?? Colors.grey.shade600,
          ),
        ),
      );

  Widget get regular => Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: color,
          fontSize: fontSize,
        ),
      );
  Widget get withDivider => Row(
        children: [
          Text(
            text.toUpperCase(),
            style: TextStyle(
              letterSpacing: .7,
              fontSize: fontSize,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
          width5,
          const Expanded(child: Divider())
        ],
      );
}
