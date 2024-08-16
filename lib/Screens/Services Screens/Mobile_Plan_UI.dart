import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Screens/Auth/TPin_UI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kButton.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kTextfield.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Mobile_Plan_UI extends StatefulWidget {
  final int providerId;
  final String providerName;
  final String providerImage;
  const Mobile_Plan_UI(
      {super.key,
      required this.providerId,
      required this.providerName,
      required this.providerImage});

  @override
  State<Mobile_Plan_UI> createState() => _Mobile_Plan_UIState();
}

class _Mobile_Plan_UIState extends State<Mobile_Plan_UI> {
  @override
  Widget build(BuildContext context) {
    return KScaffold(
      appBar: KAppBar(context, title: "Enter plan details", showBack: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(kPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kWalletCard(context),
              height10,
              kCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kPlanCard(
                      providerImage: widget.providerImage,
                      providerName: widget.providerName,
                    ),
                    height20,
                    KTextfield.regular(context,
                        label: "Enter recharge amount",
                        hintText: "Amount",
                        prefixText: "₹",
                        textSize: 25,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        fieldColor: Colors.grey.shade100),
                    height10,
                    KButton.full(
                        onPressed: () {
                          navPush(context, TPin_UI());
                        },
                        label: "Recharge")
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
