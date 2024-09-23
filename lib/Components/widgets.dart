import 'package:buy_and_earn/Models/transactions_model.dart';
import 'package:buy_and_earn/Repository/clubHouse_repository.dart';
import 'package:buy_and_earn/Repository/wallet_repository.dart';
import 'package:buy_and_earn/Screens/Wallet/WalletUI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kButton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../Screens/Transactions/TransactionDetailUI.dart';
import '../Utils/colors.dart';
import '../Utils/commons.dart';
import 'constants.dart';

Widget kLabel(String label, {double top = 20, double bottom = 15}) {
  return Padding(
    padding: EdgeInsets.only(bottom: bottom, top: top),
    child: Text(
      label,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 15,
      ),
    ),
  );
}

Widget kHeading(String label) {
  return Text(
    label.toLowerCase(),
    style: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 20,
    ),
  );
}

Widget kCard({
  Widget? child,
  double? width,
  Color? cardColor,
  EdgeInsetsGeometry? padding,
  bool isPremium = false,
}) {
  return SizedBox(
    width: width,
    child: isPremium
        ? Container(
            padding: EdgeInsets.all(kPadding),
            decoration: BoxDecoration(
              borderRadius: kRadius(5),
              gradient: LinearGradient(
                colors: kPremiumColors,
              ),
            ),
            child: child,
          )
        : Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.grey.shade300,
              ),
              borderRadius: kRadius(7),
            ),
            color: cardColor ?? kCardColor,
            child: Padding(
              padding: padding ?? EdgeInsets.all(12),
              child: child,
            ),
          ),
  );
}

Widget kWalletCard(context) {
  return Consumer(
    builder: (context, ref, child) {
      final wallet = ref.watch(walletFuture);

      return Card(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white.withOpacity(.2),
                child: Icon(
                  Icons.wallet,
                  color: Colors.white,
                ),
              ),
              width10,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Wallet Balance",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      wallet.when(
                        data: (data) => kCurrencyFormat("${data!.balance}"),
                        error: (error, stackTrace) => "-",
                        loading: () => "...",
                      ),
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              KButton.outlinedRegular(
                  onPressed: () {
                    navPush(context, WalletUI());
                  },
                  label: "Add Money",
                  color: Colors.white,
                  fontSize: 12),
            ],
          ),
        ),
      );
    },
  );
}

Widget kRecentHistoryCard(context, Transactions_Model data) {
  bool isCredit = data.type == "Credit";
  return InkWell(
    onTap: () {
      navPush(context, TransactionDetailUI(txnDetails: data));
    },
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor:
              isCredit ? Colors.greenAccent.shade100 : const Color(0xFFFFDAD7),
          child: SvgPicture.asset(
            kIconMap[data.source] ?? "$kServiceIcon/mobile.svg",
            height: 20,
            colorFilter: kSvgColor(kPrimaryColor),
          ),
        ),
        width10,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      data.title.split('for').first.trim(),
                      style: TextStyle(
                        // fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    "${isCredit ? "+" : "-"} ${kCurrencyFormat("${data.amount}", decimalDigit: 2)}",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Text(
                data.title.split('for').last.trim(),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              height5,
              Row(
                children: [
                  Expanded(
                    child: Text(
                      DateFormat('dd MMM yyyy • h:mm a')
                          .format(DateTime.parse(data.date)),
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // width10,
                  // Flexible(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       Expanded(
                  //           child: Text(
                  //         'Debited from',
                  //         style: TextStyle(
                  //             fontSize: 13,
                  //             color: Colors.grey,
                  //             fontWeight: FontWeight.w600),
                  //         textAlign: TextAlign.end,
                  //       )),
                  //       width5,
                  //       Icon(
                  //         Icons.wallet,
                  //         size: 15,
                  //       )
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget kNoData({
  String image = "assets/images/no-data.svg",
  required String title,
  String? subtitle,
  Widget? action,
}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 30.0),
          child: image.contains(".svg")
              ? SvgPicture.asset(
                  image,
                  height: 200,
                )
              : Image.asset(image),
        ),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          textAlign: TextAlign.center,
        ),
        subtitle != null
            ? Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  subtitle,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              )
            : SizedBox(),
        action != null
            ? Padding(padding: EdgeInsets.only(top: 12.0), child: action)
            : SizedBox(),
      ],
    ),
  );
}

Widget kPlanCard(
  context, {
  required String providerImage,
  required String providerName,
  String? customerName,
  String? phone,
  String region = "Pan India",
}) {
  customerName =
      customerName != null && customerName.isEmpty ? null : customerName;

  return kCard(
    child: Row(
      children: [
        CachedNetworkImage(
          imageUrl: providerImage,
          imageBuilder: (context, imageProvider) => Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        width20,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                customerName ?? phone ?? providerName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              phone != null && customerName != null
                  ? Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        phone,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    )
                  : SizedBox(),
              Text(
                "$providerName - $region",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        width10,
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Change")),
      ],
    ),
  );
}

Widget kClubModal(
  BuildContext context, {
  required void Function()? onPressed,
}) {
  return Consumer(
    builder: (context, ref, _) {
      final clubData = ref.watch(clubHouseFuture);
      return Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: kRadius(30),
          color: Colors.white,
          gradient: LinearGradient(
            colors: kPremiumColors,
          ),
        ),
        padding: EdgeInsets.all(kPadding),
        child: SafeArea(
          child: clubData.when(
            data: (data) => data != null
                ? Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close)),
                      ),
                      data["isMember"] == "true"
                          ? Column(
                              children: [
                                Text(
                                  "Club House Stats",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                height20,
                                Text(
                                  "FY ${data['targetFy']} spend",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: kPrimaryColor,
                                  ),
                                ),
                                height10,
                                Text(
                                  "${kCurrencyFormat(data["mySpent"], decimalDigit: 0)} / ${kCurrencyFormat(data["clubHouseYearlySpend"], decimalDigit: 0)}",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900,
                                    color: kPrimaryColor,
                                  ),
                                ),
                                height20,
                                if (data["mySpent"] >
                                    data["clubHouseYearlySpend"])
                                  Text(
                                    "Target Achieved!",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        color: kPrimaryColor),
                                  )
                                else
                                  Text(
                                    "${(data["mySpent"] / data["clubHouseYearlySpend"]).floor() * 100}% completed",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                height5,
                                if (data["mySpent"] <
                                    data["clubHouseYearlySpend"])
                                  ClipRRect(
                                    borderRadius: kRadius(10),
                                    child: LinearProgressIndicator(
                                      value: (data["mySpent"] /
                                          data["clubHouseYearlySpend"]),
                                      minHeight: 20,
                                      backgroundColor:
                                          Colors.white.withOpacity(.5),
                                    ),
                                  ),
                              ],
                            )
                          : data['isHousefull'] == "true"
                              ? Column(
                                  children: [
                                    Text(
                                      "Club Housefull",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    height20,
                                    Text(
                                      "Check back later!",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(
                                        "Club Membership",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    height20,
                                    Center(
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: 2),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: kPrimaryColor,
                                                    width: 2))),
                                        child: Text(
                                          "At just ${kCurrencyFormat(data["clubHouseMembership"], decimalDigit: 0)}*",
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w900,
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    height20,
                                    Text(
                                      "Benefits",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Text(
                                      "- Member of Fiscal Year ${data['targetFy']}.",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "- Receive 10% of company's profit in the end of the fiscal year, distributed equally among all Clubhouse Achievers.",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    height20,
                                    Text(
                                      "Terms",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Text(
                                      "- Yearly target of ${kCurrencyFormat(data['clubHouseYearlySpend'])} must be completed individually.",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "- Spends will be accumulated from 1st April - 31st March of the Fiscal Year.",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "- Non-Refundable.",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    height20,
                                    Center(
                                      child: Text(
                                        "*Terms and Conditions apply",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ),
                                    height5,
                                    Center(
                                      child: MaterialButton(
                                        onPressed: onPressed,
                                        elevation: 0,
                                        highlightElevation: 0,
                                        color: kPrimaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: kRadius(100),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 40),
                                        textColor: Colors.white,
                                        child: Text(
                                          "Buy Now",
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                    ],
                  )
                : kNoData(title: "Oops!", subtitle: "Try again later!"),
            error: (error, stackTrace) =>
                kNoData(title: "Oops!", subtitle: "Try again later!"),
            loading: () => Center(child: CircularProgressIndicator()),
          ),
        ),
      );
    },
  );
}

Widget kPoint(int index, String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 15,
          child: Text("$index."),
        ),
        width10,
        Expanded(child: Text(text))
      ],
    ),
  );
}
