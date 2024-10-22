import 'package:buy_and_earn/Utils/Common%20Widgets/kButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../colors.dart';
import '../commons.dart';

class KValidation {
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required!';
    }
    // Basic email pattern validation
    String pattern = r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }
}

class KTextfield {
  static const double kFontSize = 17;
  static const double kTextHeight = 1.5;

  final bool showRequiredStar;
  final bool autoFocus;
  final void Function()? onTap;
  final bool? readOnly;
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final String? prefixText;
  final Widget? prefix;
  final Widget? suffix;
  final Color? fieldColor;
  final Color? borderColor;
  final bool? obscureText;
  final int? maxLength;
  final int? maxLines;
  final FocusNode? focusNode;
  final String? label;
  final double? fontSize;
  final Widget? labelIcon;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  KTextfield({
    this.showRequiredStar = true,
    this.autoFocus = false,
    this.onTap,
    this.readOnly,
    this.controller,
    this.hintText,
    this.keyboardType,
    this.prefixText,
    this.prefix,
    this.suffix,
    this.fieldColor,
    this.borderColor,
    this.obscureText,
    this.maxLength,
    this.maxLines = 1,
    this.focusNode,
    this.label,
    this.fontSize = kFontSize,
    this.labelIcon,
    this.textCapitalization = TextCapitalization.words,
    this.inputFormatters,
    this.onChanged,
    this.validator,
  });

  static TextStyle kFieldTextstyle = const TextStyle(
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

  Widget get regular => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label != null
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 7.0),
                  child: Row(
                    children: [
                      labelIcon != null
                          ? Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: labelIcon,
                            )
                          : const SizedBox.shrink(),
                      Text(
                        label!,
                        style: const TextStyle(fontSize: 15),
                      ),
                      validator != null && showRequiredStar
                          ? const Padding(
                              padding: EdgeInsets.only(left: 3.0),
                              child: Text(
                                "*",
                                style: TextStyle(color: Colors.red),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
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
                        const BoxConstraints(minHeight: 0, minWidth: 0),
                    suffixIconConstraints:
                        const BoxConstraints(minHeight: 0, minWidth: 0),
                    prefixIcon: prefixText != null
                        ? Container(
                            padding: const EdgeInsets.only(left: 12, right: 5),
                            child: Text(
                              prefixText!,
                              style: kFieldTextstyle.copyWith(
                                fontSize: fontSize,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : prefix != null
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, right: 5),
                                child: prefix!,
                              )
                            : const SizedBox(width: 12),
                    suffixIcon: suffix != null
                        ? Padding(
                            padding: const EdgeInsets.only(left: 12, right: 5),
                            child: suffix!,
                          )
                        : const SizedBox(width: 12),
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
                    hintStyle: kHintTextstyle.copyWith(fontSize: fontSize),
                  ),
                  onChanged: onChanged,
                  validator: validator,
                ),
              ),
            ],
          ),
        ],
      );

  Widget get otp => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label != null
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    children: [
                      labelIcon != null
                          ? Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: labelIcon,
                            )
                          : const SizedBox.shrink(),
                      Text(
                        label!,
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              prefixText != null && prefix == null
                  ? Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(right: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: kRadius(10),
                      ),
                      child: Text(
                        prefixText!,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : prefixText == null && prefix != null
                      ? Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.all(12),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: kSecondaryColor,
                            borderRadius: kRadius(10),
                          ),
                          child: prefix!,
                        )
                      : const SizedBox(),
              Flexible(
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
                    hintStyle: kHintTextstyle.copyWith(fontSize: fontSize),
                  ),
                  onChanged: onChanged,
                  validator: validator,
                ),
              ),
              const SizedBox(width: 10),
              KButton(onPressed: onTap, label: 'Send OTP').regular,
            ],
          ),
        ],
      );

  Widget dropdown({
    required List<DropdownMenuEntry<dynamic>> dropdownMenuEntries,
    void Function(dynamic)? onSelected,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label != null
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    children: [
                      labelIcon != null
                          ? Padding(
                              padding: const EdgeInsets.only(right: 7.0),
                              child: labelIcon,
                            )
                          : const SizedBox.shrink(),
                      Text(
                        label!,
                        style: const TextStyle(fontSize: 15),
                      ),
                      showRequiredStar
                          ? const Padding(
                              padding: EdgeInsets.only(left: 3.0),
                              child: Text(
                                "*",
                                style: TextStyle(color: Colors.red),
                              ),
                            )
                          : const SizedBox()
                    ],
                  ),
                )
              : const SizedBox.shrink(),
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
              hintStyle: kHintTextstyle.copyWith(fontSize: fontSize),
            ),
            selectedTrailingIcon: const Icon(Icons.keyboard_arrow_up_rounded),
            trailingIcon: const Icon(Icons.keyboard_arrow_down_rounded),
            dropdownMenuEntries: dropdownMenuEntries,
            menuHeight: 300,
          ),
        ],
      );
}
