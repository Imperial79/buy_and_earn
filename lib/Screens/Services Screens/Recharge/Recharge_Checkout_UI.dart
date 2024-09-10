import 'package:buy_and_earn/Components/constants.dart';
import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Models/mobile_recharge_modal.dart';
import 'package:buy_and_earn/Models/recharge_model.dart';
import 'package:buy_and_earn/Repository/auth_repository.dart';
import 'package:buy_and_earn/Screens/Auth/TPin_UI.dart';
import 'package:buy_and_earn/Screens/Services%20Screens/Recharge/Recharge_Loading_UI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/colors.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../Utils/Common Widgets/kButton.dart';

class Recharge_Checkout_UI extends ConsumerStatefulWidget {
  final Mobile_Recharge_Model? mobile_recharge_data;
  final Recharge_Model? recharge_data;
  const Recharge_Checkout_UI({
    super.key,
    this.mobile_recharge_data,
    this.recharge_data,
  });

  @override
  ConsumerState<Recharge_Checkout_UI> createState() =>
      _Recharge_Checkout_UIState(mobile_recharge_data, recharge_data);
}

class _Recharge_Checkout_UIState extends ConsumerState<Recharge_Checkout_UI> {
  final Mobile_Recharge_Model? mobile_recharge_data;
  final Recharge_Model? recharge_data;
  _Recharge_Checkout_UIState(
    this.mobile_recharge_data,
    this.recharge_data,
  );
  double netPayable = 0.0;
  double planAmount = 0.0;
  int providerId = 0;
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

    final user = ref.watch(userProvider);

    netPayable = planAmount;

    if (user!.status == "Pending" && planAmount >= user.idActiveMinThreshold) {
      netPayable += user.idActiveAmount;
    }

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
              kLabel("Plan Details"),
              kCard(
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      kCurrencyFormat("$planAmount"),
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
              kLabel("Total breakdown"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Plan price"),
                  Text(kCurrencyFormat("$planAmount"))
                ],
              ),
              Text(
                "*Includes all taxes in the net payable amount below.",
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
              height10,
              if (user.status == "Pending" &&
                  planAmount >= user.idActiveMinThreshold)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("ID Activation"),
                    Text("+ ${kCurrencyFormat("${user.idActiveAmount}")}")
                  ],
                ),
              Divider(
                color: Colors.grey.shade400,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Net Payable",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    kCurrencyFormat("$netPayable"),
                    style: TextStyle(fontWeight: FontWeight.w600),
                  )
                ],
              ),
              if (user.status == "Pending" &&
                  planAmount < user.idActiveMinThreshold)
                Card(
                  margin: EdgeInsets.only(top: 20),
                  color: Colors.amber.shade100,
                  child: Padding(
                    padding: EdgeInsets.all(kPadding),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.info),
                        width10,
                        Expanded(
                          child: Text(
                            "No cashback will be applicable on this recharge.",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              if (user.status == "Pending")
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kLabel("ID activation"),
                    kLabel("Terms", top: 10),
                    kPoint(1,
                        "Min. one time purchase of ${kCurrencyFormat(user.idActiveMinThreshold, decimalDigit: 0)} or more."),
                    kPoint(2,
                        "One time ${kCurrencyFormat(user.idActiveAmount, decimalDigit: 0)} will be deducted as part of activation."),
                    kLabel("Benefits"),
                    kPoint(1,
                        "All source of commission income will be activated which includes self cashback, level commission, working bonus and rewards."),
                  ],
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

              navPushReplacement(
                context,
                Recharge_Loading_UI(
                  service: service,
                  providerId: providerId,
                  consumerNo: consumerNo,
                  amount: planAmount,
                  tpin: res!["tpin"],
                ),
              );
            },
            backgroundColor: kPrimaryColor,
            label: "Pay",
            icon: Text(kCurrencyFormat("$netPayable")),
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
