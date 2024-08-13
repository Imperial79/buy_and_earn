import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Screens/Auth/TPin_UI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kButton.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kTextfield.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';

class Plan_UI extends StatefulWidget {
  const Plan_UI({super.key});

  @override
  State<Plan_UI> createState() => _Plan_UIState();
}

class _Plan_UIState extends State<Plan_UI> {
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
                    Text("Enter recharge amount"),
                    height10,
                    KTextfield.regular(context,
                        hintText: "Amount", prefixText: "₹"),
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
