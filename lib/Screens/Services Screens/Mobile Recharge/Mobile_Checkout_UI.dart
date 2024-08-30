import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Models/mobile_recharge_modal.dart';
import 'package:buy_and_earn/Screens/Auth/TPin_UI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/colors.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';

import '../../../Utils/Common Widgets/kButton.dart';

class Mobile_Checkout_UI extends StatefulWidget {
  final Mobile_Recharge_Modal masterdata;
  const Mobile_Checkout_UI({
    super.key,
    required this.masterdata,
  });

  @override
  State<Mobile_Checkout_UI> createState() => _Mobile_Checkout_UIState();
}

class _Mobile_Checkout_UIState extends State<Mobile_Checkout_UI> {
  double netPayable = 0.0;
  @override
  Widget build(BuildContext context) {
    return KScaffold(
      appBar: KAppBar(context, title: "Checkout", showBack: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(kPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kPlanCard(
                context,
                customerName: widget.masterdata.customerName,
                providerImage: widget.masterdata.providerImage!,
                providerName: widget.masterdata.providerName!,
                phone: widget.masterdata.customerPhone,
              ),
              height20,
              kLabel("Plan Details"),
              height15,
              kCard(
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "₹ ${widget.masterdata.planAmount}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Valididty: NA",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        width10,
                        Text(
                          "Data: NA",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        width10,
                        Text(
                          "Talktime: NA",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              height20,
              kLabel("Total breakdown"),
              height15,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Plan price"),
                  Text("₹ ${widget.masterdata.planAmount}")
                ],
              ),
              height10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("GST"), Text("+ ₹ 0.5")],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: KButton.icon(
            onPressed: () {
              navPush(
                  context,
                  TPin_UI(
                    amount: "${widget.masterdata.planAmount}",
                    phone: widget.masterdata.customerPhone!,
                    providerId: widget.masterdata.providerId!,
                  ));
            },
            backgroundColor: kPrimaryColor,
            label: "Pay",
            icon: Text("₹${widget.masterdata.planAmount}"),
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
