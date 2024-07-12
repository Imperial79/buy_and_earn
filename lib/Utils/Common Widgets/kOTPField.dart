import 'package:flutter/material.dart';

import '../colors.dart';

class KOtpField extends StatefulWidget {
  final int length; // Length of the OTP code (default 6)
  final ValueChanged<String> onCompleted; // Callback for completed OTP
  final bool autoFocus;
  final double? fontSize;

  const KOtpField({
    super.key,
    required this.length,
    required this.onCompleted,
    this.fontSize,
    this.autoFocus = true,
  });

  @override
  State<KOtpField> createState() => _KOtpFieldState();
}

class _KOtpFieldState extends State<KOtpField> {
  List<TextEditingController> controllers = [];
  String otp = "";

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.length; i++) {
      controllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void addText(String text) {
    if (otp.length <= widget.length) {
      setState(() {
        otp += text;
        int currentDigit = otp.length - 1;
        if (currentDigit < widget.length - 1) {
          controllers[currentDigit + 1].text = "";
          FocusScope.of(context).nextFocus();
        } else {
          widget.onCompleted(otp);
        }
      });
    }
  }

  void removeText() {
    if (otp.isNotEmpty) {
      setState(() {
        otp = otp.substring(0, otp.length - 1);
        int currentDigit = otp.length;
        if (currentDigit > 0) {
          controllers[currentDigit].text = "";
          FocusScope.of(context).previousFocus();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Flex(
            children: List.generate(
              widget.length,
              (index) {
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    color: Colors.grey.shade100,
                    width: double.maxFinite,
                    child: TextField(
                      controller: controllers[index],
                      cursorColor: kPrimaryColor,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: widget.fontSize ?? 10,
                      ),
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      autofocus: widget.autoFocus ? index == 0 : false,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          addText(value);
                        } else {
                          removeText();
                        }
                      },
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: '-',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        contentPadding:
                            EdgeInsets.only(left: 4, top: 20, bottom: 20),
                        border: InputBorder.none,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: kSecondaryColor,
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
          ),
        );
      },
    );
  }
}
