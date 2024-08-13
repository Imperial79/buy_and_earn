import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:flutter/material.dart';

import '../../Utils/colors.dart';
import '../../Utils/commons.dart';

class TPin_UI extends StatefulWidget {
  const TPin_UI({super.key});

  @override
  State<TPin_UI> createState() => _TPin_UIState();
}

class _TPin_UIState extends State<TPin_UI> {
  String tpin = "";
  @override
  Widget build(BuildContext context) {
    return KScaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Enter MPIN"),
                    Text(
                      tpin,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: _onScreenKeyboard(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _onScreenKeyboard() {
    return Column(
      children: [
        Row(
          children: [
            _keyboardBtn('1'),
            _keyboardBtn('2'),
            _keyboardBtn('3'),
          ],
        ),
        Row(
          children: [
            _keyboardBtn('4'),
            _keyboardBtn('5'),
            _keyboardBtn('6'),
          ],
        ),
        Row(
          children: [
            _keyboardBtn('7'),
            _keyboardBtn('8'),
            _keyboardBtn('9'),
          ],
        ),
        Row(
          children: [
            _keyboardBtn('0'),
            _keyboardBtn('back'),
          ],
        ),
      ],
    );
  }

  Widget _keyboardBtn(String label) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(3.0),
        child: InkWell(
          borderRadius: kRadius(5),
          onLongPress: () {
            if (label == "back") {
              setState(() {
                tpin = "";
              });
            }
          },
          onTap: () {
            if (label == "back") {
              if (tpin.isNotEmpty) {
                setState(() {
                  tpin = tpin.substring(0, tpin.length - 1);
                });
              }
            } else {
              if (tpin.length != 5) {
                if (tpin.length < 3) {
                  setState(() {
                    tpin = tpin + label;
                  });
                } else {
                  setState(() {
                    tpin = tpin + label;
                  });
                  // _login();
                }
              }
            }
          },
          child: Ink(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: kRadius(10),
              color: kColor(context).secondaryContainer,
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: FittedBox(
                child: label == "back"
                    ? Icon(Icons.backspace)
                    : Text(
                        label,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
