import 'package:buy_and_earn/Components/constants.dart';
import 'package:buy_and_earn/Screens/RootUI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Utils/Common Widgets/kButton.dart';
import '../../Utils/commons.dart';

class FlashPasswordUI extends ConsumerStatefulWidget {
  final mpin;
  final tpin;
  const FlashPasswordUI({super.key, required this.mpin, required this.tpin});

  @override
  ConsumerState<FlashPasswordUI> createState() =>
      _FlashPasswordUIState(mpin: mpin, tpin: tpin);
}

class _FlashPasswordUIState extends ConsumerState<FlashPasswordUI> {
  final mpin;
  final tpin;
  _FlashPasswordUIState({required this.mpin, required this.tpin});

  String encryptedMpin = "";
  String encryptedTpin = "";
  @override
  void initState() {
    super.initState();
    encryptedMpin = encryptDecryptText("decrypt", mpin);
    encryptedTpin = encryptDecryptText("decrypt", tpin);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return KScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              height15,
              Text(
                "Remember Password",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                ),
              ),
              height20,
              Text(
                "MPIN",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                "${encryptedMpin}",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              height20,
              Text(
                "TPIN",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                "${encryptedTpin}",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: KButton.full(
            onPressed: () {
              navPopUntilPush(context, RootUI());
            },
            label: "Go to Home",
          ),
        ),
      ),
    );
  }
}
