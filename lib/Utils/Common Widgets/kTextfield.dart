import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../colors.dart';
import '../commons.dart';
import 'kButton.dart';

class KValidation {
  static String? required(String? val) {
    if (val == null || val.isEmpty) {
      return 'Required!';
    }
    return null;
  }

  static String? phone(String? val) {
    if (val == null || val.isEmpty) {
      return 'Required!';
    } else if (val.length != 10) {
      return "Phone must be of length 10!";
    }
    return null;
  }

  static String? email(String? val) {
    if (val == null || val.isEmpty) {
      return 'Required!';
    }
    // Basic email pattern validation
    String pattern = r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(val)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? pan(String? val) {
    if (val == null || val.isEmpty) {
      return 'Required!';
    }
    // Basic email pattern validation
    else if (val.length != 10) {
      return 'Length must be 10!';
    }
    return null;
  }
}

class KTextfield {
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
  final bool obscureText;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final FocusNode? focusNode;
  final String? label;
  final double? fontSize;
  final Widget? labelIcon;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;

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
    this.obscureText = false,
    this.maxLength,
    this.minLines = 1,
    this.maxLines = 1,
    this.focusNode,
    this.label,
    this.fontSize = 17,
    this.labelIcon,
    this.textCapitalization = TextCapitalization.words,
    this.inputFormatters,
    this.onChanged,
    this.validator,
    this.onFieldSubmitted,
  });

  InputBorder borderStyle(Color? customBorder) => OutlineInputBorder(
        borderRadius: kRadius(10),
        borderSide:
            BorderSide(color: borderColor ?? customBorder ?? Light.border),
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
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: fontSize,
                    letterSpacing: obscureText ? 10 : .5,
                    height: 1.5,
                  ),
                  readOnly: readOnly ?? false,
                  obscureText: obscureText,
                  keyboardType: keyboardType,
                  maxLength: maxLength,
                  maxLines: maxLines,
                  minLines: minLines,
                  inputFormatters: inputFormatters,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: fieldColor ?? Colors.white,
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
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: fontSize,
                                letterSpacing: .5,
                                height: 1.5,
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
                    border: borderStyle(null),
                    errorBorder: borderStyle(Colors.red.shade300),
                    focusedBorder: borderStyle(Colors.grey.shade500),
                    enabledBorder: borderStyle(null),
                    hintText: hintText,
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: fontSize,
                      letterSpacing: 1,
                      height: 1.5,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  onChanged: onChanged,
                  validator: validator,
                  onFieldSubmitted: onFieldSubmitted,
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
                        color: Light.secondary,
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
                            color: Light.secondary,
                            borderRadius: kRadius(10),
                          ),
                          child: prefix!,
                        )
                      : const SizedBox(),
              Flexible(
                child: TextFormField(
                  controller: controller,
                  textCapitalization: textCapitalization,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: fontSize,
                    letterSpacing: .5,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                  readOnly: readOnly ?? false,
                  obscureText: obscureText,
                  keyboardType: keyboardType,
                  maxLength: maxLength,
                  maxLines: maxLines,
                  minLines: maxLines,
                  inputFormatters: inputFormatters,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Light.card,
                    counterText: '',
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: kRadius(10),
                      borderSide: const BorderSide(color: Light.border),
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
                      borderSide: const BorderSide(color: Light.border),
                    ),
                    hintText: hintText,
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: fontSize,
                      height: 1.5,
                      color: Colors.grey.shade700,
                    ),
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
            textStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: fontSize,
              letterSpacing: .5,
              height: 1.5,
            ),
            onSelected: onSelected,
            expandedInsets: EdgeInsets.zero,
            inputDecorationTheme: InputDecorationTheme(
              activeIndicatorBorder: BorderSide(color: Colors.grey.shade500),
              border: OutlineInputBorder(
                borderRadius: kRadius(10),
                borderSide: const BorderSide(color: Light.border),
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
                borderSide: const BorderSide(color: Light.border),
              ),
              filled: true,
              fillColor: Light.card,
              hintStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: fontSize,
                height: 1.5,
                color: Colors.grey.shade700,
              ),
            ),
            selectedTrailingIcon: const Icon(Icons.keyboard_arrow_up_rounded),
            trailingIcon: const Icon(Icons.keyboard_arrow_down_rounded),
            dropdownMenuEntries: dropdownMenuEntries,
            menuHeight: 300,
          ),
        ],
      );
}
