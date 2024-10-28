import 'package:buy_and_earn/Components/constants.dart';
import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Screens/RootUI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Utils/Common Widgets/kButton.dart';
import '../../Utils/commons.dart';

class FlashPasswordUI extends ConsumerStatefulWidget {
  final String mpin;
  final String tpin;
  const FlashPasswordUI({super.key, required this.mpin, required this.tpin});

  @override
  ConsumerState<FlashPasswordUI> createState() =>
      _FlashPasswordUIState(mpin: mpin, tpin: tpin);
}

class _FlashPasswordUIState extends ConsumerState<FlashPasswordUI> {
  final String mpin;
  final String tpin;
  _FlashPasswordUIState({required this.mpin, required this.tpin});

  String decryptedMpin = "";
  String decryptedTpin = "";
  @override
  void initState() {
    super.initState();
    decryptedMpin = encryptDecryptText("decrypt", mpin);
    decryptedTpin = encryptDecryptText("decrypt", tpin);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return KScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              height15,
              const Text(
                "Credentials",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                ),
              ),
              const Text(
                "Save these credentials for future use",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
              height20,
              kCard(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "MPIN",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            decryptedMpin,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    width10,
                    IconButton.filled(
                      onPressed: () {
                        Clipboard.setData(
                            ClipboardData(text: "MPIN: $decryptedMpin"));
                        KSnackbar(context, content: "MPIN Copied");
                      },
                      icon: const Icon(
                        Icons.copy,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),
              height20,
              kCard(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "TPIN",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            decryptedTpin,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    width10,
                    IconButton.filled(
                      onPressed: () {
                        Clipboard.setData(
                            ClipboardData(text: "TPIN: $decryptedTpin"));
                        KSnackbar(context, content: "TPIN Copied");
                      },
                      icon: const Icon(
                        Icons.copy,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: KButton(
            onPressed: () {
              navPopUntilPush(context, const RootUI());
            },
            label: "Go to Home",
          ).full,
        ),
      ),
    );
  }
}
