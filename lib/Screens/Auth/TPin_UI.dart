import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:flutter/material.dart';
import '../../Utils/colors.dart';
import '../../Utils/commons.dart';

class TPin_UI extends StatefulWidget {
  const TPin_UI({
    super.key,
  });

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
                    const Text(
                      "Verification",
                      style: TextStyle(
                        fontSize: 30,
                        color: Light.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    height20,
                    const Text(
                      "Enter your 6-digits TPIN",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    height20,
                    Text(
                      tpin.isEmpty ? "------" : tpin,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 10,
                        color: tpin.isEmpty ? Colors.grey : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
            _keyboardBtn('back'),
            _keyboardBtn('0'),
            _keyboardBtn('OK'),
          ],
        ),
      ],
    );
  }

  Widget _keyboardBtn(String label) {
    bool isDelete = label == "back";
    bool isDone = label == "OK";
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: InkWell(
          borderRadius: kRadius(5),
          splashColor: Light.primary,
          onLongPress: () {
            if (isDelete) {
              setState(() {
                tpin = "";
              });
            }
          },
          onTap: () {
            if (!isDone) {
              if (isDelete) {
                if (tpin.isNotEmpty) {
                  setState(() {
                    tpin = tpin.substring(0, tpin.length - 1);
                  });
                }
              } else {
                if (tpin.length != 6) {
                  if (tpin.length < 3) {
                    setState(() {
                      tpin = tpin + label;
                    });
                  } else {
                    setState(() {
                      tpin = tpin + label;
                    });
                  }
                }
              }
            } else {
              if (tpin.length == 6) {
                Navigator.pop(context, {"tpin": tpin});
              }
            }
          },
          child: Ink(
            height: 55,
            decoration: BoxDecoration(
              borderRadius: kRadius(5),
              color: isDone
                  ? Colors.greenAccent
                  : isDelete
                      ? Colors.redAccent
                      : kColor(context).secondaryContainer,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: FittedBox(
                child: isDone
                    ? const Icon(Icons.done)
                    : label == "back"
                        ? const Icon(
                            Icons.backspace,
                            color: Colors.white,
                          )
                        : Text(
                            label,
                            style: const TextStyle(
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
