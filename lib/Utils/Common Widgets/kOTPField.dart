import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../colors.dart';

class KOtpField extends StatefulWidget {
  final void Function(String)? onCompleted;
  final String? Function(String?)? validator;
  final int length;
  const KOtpField({
    super.key,
    this.onCompleted,
    required this.length,
    this.validator,
  });

  @override
  State<KOtpField> createState() => _KOtpFieldState();
}

class _KOtpFieldState extends State<KOtpField> {
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(
          color: Light.secondary.withOpacity(.5),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: kColor(context).primary, width: 2),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(
          color: Light.primary,
          width: 1,
        ),
        color: kColor(context).primaryContainer.withOpacity(.5),
      ),
    );
    return Pinput(
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      length: widget.length,
      validator: widget.validator,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onCompleted: widget.onCompleted,
    );
  }
}
