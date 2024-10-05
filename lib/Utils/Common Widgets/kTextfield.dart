// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:buy_and_earn/Utils/Common%20Widgets/kButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../colors.dart';
import '../commons.dart';

class KTextfield {
  static const double kFontSize = 17;
  static const double kTextHeight = 1.5;

  static TextStyle kFieldTextstyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: kFontSize,
    letterSpacing: .5,
    height: kTextHeight,
  );

  static TextStyle kHintTextstyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: kFontSize,
    height: kTextHeight,
    color: Colors.grey.shade600,
  );
  static Widget regular(
    BuildContext context, {
    bool showRequiredStar = true,
    bool autoFocus = false,
    void Function()? onTap,
    bool? readOnly,
    TextEditingController? controller,
    String? hintText,
    TextInputType? keyboardType,
    String? prefixText,
    Widget? prefix,
    Widget? suffix,
    Color? fieldColor,
    Color? borderColor,
    bool? obscureText,
    int? maxLength,
    int? maxLines = 1,
    FocusNode? focusNode,
    String? label,
    double? fontSize = kFontSize,
    Widget? labelIcon,
    TextCapitalization textCapitalization = TextCapitalization.words,
    List<TextInputFormatter>? inputFormatters,
    void Function(String)? onChanged,
    String? Function(String?)? validator,
  }) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label != null
              ? Padding(
                  padding: EdgeInsets.only(bottom: 7.0),
                  child: Row(
                    children: [
                      labelIcon != null
                          ? Padding(
                              padding: EdgeInsets.only(right: 10.0),
                              child: labelIcon,
                            )
                          : SizedBox.shrink(),
                      Text(
                        label,
                        style: TextStyle(fontSize: 15),
                      ),
                      validator != null && showRequiredStar
                          ? Padding(
                              padding: EdgeInsets.only(left: 3.0),
                              child: Text(
                                "*",
                                style: TextStyle(color: Colors.red),
                              ),
                            )
                          : SizedBox()
                    ],
                  ),
                )
              : SizedBox.shrink(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: TextFormField(
                  autofocus: autoFocus,
                  onTap: onTap,
                  focusNode: focusNode,
                  controller: controller,
                  textCapitalization: textCapitalization,
                  style: kFieldTextstyle.copyWith(
                    fontSize: fontSize,
                  ),
                  readOnly: readOnly ?? false,
                  obscureText: obscureText ?? false,
                  keyboardType: keyboardType,
                  maxLength: maxLength,
                  maxLines: maxLines,
                  minLines: maxLines,
                  inputFormatters: inputFormatters,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: fieldColor ?? kCardColor,
                    counterText: '',
                    prefixIconConstraints:
                        BoxConstraints(minHeight: 0, minWidth: 0),
                    suffixIconConstraints:
                        BoxConstraints(minHeight: 0, minWidth: 0),
                    prefixIcon: prefixText != null
                        ? Container(
                            padding: EdgeInsets.only(left: 12, right: 5),
                            child: Text(
                              prefixText,
                              style: kFieldTextstyle.copyWith(
                                fontSize: fontSize,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : prefix != null
                            ? Padding(
                                padding: EdgeInsets.only(left: 12, right: 5),
                                child: prefix,
                              )
                            : SizedBox(
                                width: 12,
                              ),
                    suffixIcon: suffix != null
                        ? Padding(
                            padding: EdgeInsets.only(left: 12, right: 5),
                            child: suffix,
                          )
                        : SizedBox(
                            width: 12,
                          ),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: kRadius(10),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: kRadius(10),
                      borderSide: BorderSide(color: Colors.red.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: kRadius(10),
                      borderSide: BorderSide(color: Colors.grey.shade500),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: kRadius(10),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    hintText: hintText,
                    hintStyle: kHintTextstyle.copyWith(
                      fontSize: fontSize,
                    ),
                  ),
                  onChanged: onChanged,
                  validator: validator,
                ),
              ),
            ],
          ),
        ],
      );

  static Widget otp(
    BuildContext context, {
    void Function()? onTap,
    bool dismissKeyboardOnTapOutside = false,
    bool? readOnly,
    TextEditingController? controller,
    String? hintText,
    TextInputType? keyboardType,
    String? prefixText,
    Widget? prefix,
    Color? fieldColor,
    Color? borderColor,
    bool? obscureText,
    int? maxLength,
    int? maxLines = 1,
    double fontSize = kFontSize,
    String? label,
    Widget? labelIcon,
    TextCapitalization textCapitalization = TextCapitalization.none,
    List<TextInputFormatter>? inputFormatters,
    void Function(String)? onChanged,
    String? Function(String?)? validator,
  }) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label != null
              ? Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    children: [
                      labelIcon != null
                          ? Padding(
                              padding: EdgeInsets.only(right: 10.0),
                              child: labelIcon,
                            )
                          : SizedBox.shrink(),
                      Text(
                        label,
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox.shrink(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              prefixText != null && prefix == null
                  ? Container(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.only(right: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: kRadius(10),
                      ),
                      child: Text(
                        prefixText,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : prefixText == null && prefix != null
                      ? Container(
                          margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.all(12),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: kSecondaryColor,
                            borderRadius: kRadius(10),
                          ),
                          child: prefix,
                        )
                      : SizedBox(),
              Flexible(
                child: TextFieldTapRegion(
                  onTapOutside: (event) {
                    if (dismissKeyboardOnTapOutside)
                      FocusScope.of(context).unfocus();
                  },
                  child: TextFormField(
                    controller: controller,
                    textCapitalization: textCapitalization,
                    style: kFieldTextstyle.copyWith(
                      fontSize: fontSize,
                    ),
                    textAlign: TextAlign.center,
                    readOnly: readOnly ?? false,
                    obscureText: obscureText ?? false,
                    keyboardType: keyboardType,
                    maxLength: maxLength,
                    maxLines: maxLines,
                    minLines: maxLines,
                    inputFormatters: inputFormatters,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: kCardColor,
                      counterText: '',
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: kRadius(10),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: kRadius(10),
                        borderSide: BorderSide(color: Colors.red.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: kRadius(10),
                        borderSide: BorderSide(color: Colors.grey.shade500),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: kRadius(10),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      hintText: hintText,
                      hintStyle: kHintTextstyle.copyWith(
                        fontSize: fontSize,
                      ),
                    ),
                    onChanged: onChanged,
                    validator: validator,
                  ),
                ),
              ),
              width10,
              KButton(onPressed: onTap, label: 'Send OTP').regular,
            ],
          ),
        ],
      );

  static Widget dropdown({
    TextEditingController? controller,
    String? label,
    String? hintText,
    Widget? labelIcon,
    double fontSize = 16,
    bool showRequiredStar = false,
    required List<DropdownMenuEntry<dynamic>>? items,
    void Function(dynamic)? onSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null
            ? Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Row(
                  children: [
                    labelIcon != null
                        ? Padding(
                            padding: EdgeInsets.only(right: 7.0),
                            child: labelIcon,
                          )
                        : SizedBox.shrink(),
                    Text(
                      label,
                      style: TextStyle(fontSize: 15),
                    ),
                    showRequiredStar
                        ? Padding(
                            padding: EdgeInsets.only(left: 3.0),
                            child: Text(
                              "*",
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        : SizedBox()
                  ],
                ),
              )
            : SizedBox.shrink(),
        DropdownMenu(
          controller: controller,
          hintText: hintText,
          textStyle: kFieldTextstyle.copyWith(
            fontSize: fontSize,
          ),
          onSelected: onSelected,
          expandedInsets: EdgeInsets.zero,
          inputDecorationTheme: InputDecorationTheme(
            activeIndicatorBorder: BorderSide(color: Colors.grey.shade500),
            border: OutlineInputBorder(
              borderRadius: kRadius(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: kRadius(10),
              borderSide: BorderSide(color: Colors.red.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: kRadius(10),
              borderSide: BorderSide(color: Colors.grey.shade500),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: kRadius(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            filled: true,
            fillColor: kCardColor,
            hintStyle: kHintTextstyle.copyWith(
              fontSize: fontSize,
            ),
          ),
          selectedTrailingIcon: Icon(Icons.keyboard_arrow_up_rounded),
          trailingIcon: Icon(Icons.keyboard_arrow_down_rounded),
          menuStyle: MenuStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.white),
          ),
          dropdownMenuEntries: items!,
          menuHeight: 300,
        ),
      ],
    );
  }
}
