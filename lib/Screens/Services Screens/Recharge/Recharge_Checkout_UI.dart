import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Models/mobile_recharge_modal.dart';
import 'package:buy_and_earn/Models/recharge_model.dart';
import 'package:buy_and_earn/Screens/Auth/TPin_UI.dart';
import 'package:buy_and_earn/Screens/Services%20Screens/Recharge/Recharge_Loading_UI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/colors.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import '../../../Utils/Common Widgets/kButton.dart';

class Recharge_Checkout_UI extends StatefulWidget {
  final Mobile_Recharge_Model? mobile_recharge_data;
  final Recharge_Model? recharge_data;
  const Recharge_Checkout_UI({
    super.key,
    this.mobile_recharge_data,
    this.recharge_data,
  });

  @override
  State<Recharge_Checkout_UI> createState() =>
      _Recharge_Checkout_UIState(mobile_recharge_data, recharge_data);
}

class _Recharge_Checkout_UIState extends State<Recharge_Checkout_UI> {
  final Mobile_Recharge_Model? mobile_recharge_data;
  final Recharge_Model? recharge_data;
  _Recharge_Checkout_UIState(
    this.mobile_recharge_data,
    this.recharge_data,
  );
  double netPayable = 0.0;
  String planAmount = "0.0";
  String providerId = "";
  String providerName = "";
  String consumerNo = "";
  String providerImage = "";
  String service = "";

  @override
  Widget build(BuildContext context) {
    planAmount = (mobile_recharge_data != null
        ? mobile_recharge_data!.planAmount
        : recharge_data!.planAmount)!;
    providerId = (mobile_recharge_data != null
        ? mobile_recharge_data!.providerId
        : recharge_data!.providerId)!;
    providerName = (mobile_recharge_data != null
        ? mobile_recharge_data!.providerName
        : recharge_data!.providerName)!;
    providerImage = (mobile_recharge_data != null
        ? mobile_recharge_data!.providerImage
        : recharge_data!.providerImage)!;
    service = (mobile_recharge_data != null
        ? mobile_recharge_data!.service
        : recharge_data!.service);
    consumerNo = (mobile_recharge_data != null
        ? mobile_recharge_data!.customerPhone
        : recharge_data!.consumerNo)!;
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
                customerName: mobile_recharge_data?.customerName,
                providerImage: providerImage,
                providerName: providerName,
                phone: mobile_recharge_data != null
                    ? "+91 " + consumerNo
                    : consumerNo,
              ),
              // mobile_recharge_data != null
              //     ? kPlanCard(
              //         context,
              //         customerName: mobile_recharge_data?.customerName,
              //         providerImage: mobile_recharge_data!.providerImage!,
              //         providerName: mobile_recharge_data!.providerName!,
              //         phone: "+91 " + mobile_recharge_data!.customerPhone!,
              //       )
              //     : kPlanCard(
              //         context,
              //         providerImage: recharge_data!.providerImage!,
              //         providerName: recharge_data!.providerName!,
              //         phone: recharge_data!.consumerNo,
              //       ),
              height20,
              kLabel("Plan Details"),
              height15,
              kCard(
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "₹ $planAmount",
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
                children: [Text("Plan price"), Text("₹ $planAmount")],
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
            onPressed: () async {
              Map? res = await navPush(context, TPin_UI());

              if (res != null) {
                navPushReplacement(
                  context,
                  Recharge_Loading_UI(
                    service: service,
                    providerId: providerId,
                    consumerNo: consumerNo,
                    amount: planAmount,
                    tpin: res["tpin"],
                  ),
                );
              }
            },
            backgroundColor: kPrimaryColor,
            label: "Pay",
            icon: Text("₹$planAmount"),
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
