// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:buy_and_earn/Utils/Common%20Widgets/kButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../colors.dart';
import '../commons.dart';

class KTextfield {
  static Widget regular(
    BuildContext context, {
    double? textSize,
    void Function()? onTap,
    bool? readOnly,
    TextEditingController? controller,
    String? hintText,
    TextInputType? keyboardType,
    String? prefixText,
    Widget? prefix,
    Color? fieldColor,
    Color? borderColor,
    bool obscureText = false,
    int? maxLength,
    int? maxLines = 1,
    String? label,
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
          TextFieldTapRegion(
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            child: TextFormField(
              onTap: onTap,
              controller: controller,
              textCapitalization: textCapitalization,
              style: TextStyle(
                fontSize: textSize ?? 17,
                fontWeight: FontWeight.w500,
                letterSpacing: obscureText ? 2 : .5,
              ),
              readOnly: readOnly ?? false,
              obscureText: obscureText,
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
                prefixText: prefixText,
                prefixStyle: TextStyle(
                  fontSize: textSize ?? 17,
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: kRadius(7),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: kRadius(7),
                  borderSide: BorderSide(color: Colors.red.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: kRadius(7),
                  borderSide: BorderSide(color: Colors.grey.shade500),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: kRadius(7),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: textSize ?? 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              onChanged: onChanged,
              validator: validator,
            ),
          ),
        ],
      );

  static Widget otp(
    BuildContext context, {
    void Function()? onTap,
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
                    FocusScope.of(context).unfocus();
                  },
                  child: TextFormField(
                    controller: controller,
                    textCapitalization: textCapitalization,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 10,
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
                      hintStyle: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        letterSpacing: 1,
                      ),
                    ),
                    onChanged: onChanged,
                    validator: validator,
                  ),
                ),
              ),
              width10,
              KButton.regular(onPressed: onTap, label: 'Send OTP')
            ],
          ),
        ],
      );

  static Widget dropdown({
    String label = "label",
    String? value,
    required List<DropdownMenuItem<String>>? items,
    required void Function(String?)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        height10,
        Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.grey.shade300,
            ),
            borderRadius: kRadius(7),
          ),
          color: kCardColor,
          child: Padding(
            padding: EdgeInsets.all(12),
            child: DropdownButtonFormField(
              isDense: true,
              decoration: InputDecoration.collapsed(
                hintText: "",
              ),
              value: value,
              items: items,
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
