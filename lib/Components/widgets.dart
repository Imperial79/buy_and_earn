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
import 'package:simple_shadow/simple_shadow.dart';
import '../Screens/Transactions/TransactionDetailUI.dart';
import '../Utils/colors.dart';
import '../Utils/commons.dart';
import 'constants.dart';

Widget kHeading(String label) {
  return Text(
    label.toLowerCase(),
    style: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 20,
    ),
  );
}

Widget kInfoCard(
  String text,
) {
  return kCard(
    borderWidth: 0,
    color: Colors.amber.shade100,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.info,
          color: Colors.amber.shade900,
        ),
        width10,
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    ),
  );
}

Widget kCard({
  Widget? child,
  double? width,
  Color borderColor = Light.border,
  double borderWidth = 1,
  Color color = Light.card,
  double radius = 15,
  EdgeInsetsGeometry? padding,
  EdgeInsetsGeometry? margin,
  bool isPremium = false,
}) {
  return isPremium
      ? Container(
          width: width,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: kRadius(radius),
            gradient: LinearGradient(
              colors: kPremiumColors,
            ),
          ),
          child: child,
        )
      : Container(
          width: width,
          decoration: BoxDecoration(
            borderRadius: kRadius(radius),
            color: color,
            border: Border.all(color: borderColor, width: borderWidth),
          ),
          margin: margin,
          padding: padding ?? const EdgeInsets.all(15),
          child: child,
        );
}

Widget kWalletCard(context) {
  return Consumer(
    builder: (context, ref, child) {
      final wallet = ref.watch(walletFuture);

      return SimpleShadow(
        opacity: .1,
        sigma: 20,
        child: kCard(
          margin: const EdgeInsets.symmetric(vertical: 20),
          color: Light.card,
          borderColor: Light.scaffold,
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundColor: Light.primary,
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
                    const Text(
                      "Available Balance",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        // color: Colors.white,
                      ),
                    ),
                    Text(
                      wallet.when(
                        data: (data) => kCurrencyFormat("${data!.balance}"),
                        error: (error, stackTrace) => "-",
                        loading: () => "...",
                      ),
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        // color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              KButton(
                onPressed: () {
                  navPush(context, const WalletUI());
                },
                backgroundColor: Light.quarternary,
                label: "Recharge",
              ).pill,
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
      navPush(context, TransactionDetailUI(txn: data));
    },
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor:
              isCredit ? Colors.lightGreen.shade100 : const Color(0xFFFFDAD7),
          child: SvgPicture.asset(
            kIconMap[data.source] ?? "$kServiceIcon/mobile.svg",
            height: 20,
            colorFilter:
                kSvgColor(isCredit ? Colors.lightGreen.shade900 : Colors.red),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.title.split('for').first.trim(),
                          style: const TextStyle(
                            // fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          data.status,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: kColorMapText[data.status]),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "${isCredit ? "+" : "-"} ${kCurrencyFormat("${data.amount}", decimalDigit: 2)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              height5,
              Row(
                children: [
                  Expanded(
                    child: Text(
                      DateFormat('dd MMM yyyy • h:mm a')
                          .format(DateTime.parse(data.date)),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    DateFormat('hh:mm a').format(DateTime.parse(data.date)),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
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
          padding: const EdgeInsets.only(bottom: 30.0),
          child: image.contains(".svg")
              ? SvgPicture.asset(
                  image,
                  height: 200,
                )
              : Image.asset(image),
        ),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          textAlign: TextAlign.center,
        ),
        subtitle != null
            ? Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  subtitle,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              )
            : const SizedBox(),
        action != null
            ? Padding(padding: const EdgeInsets.only(top: 12.0), child: action)
            : const SizedBox(),
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
            height: 40,
            width: 40,
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
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              phone != null && customerName != null
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        phone,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    )
                  : const SizedBox(),
              Text(
                "$providerName - $region",
                style: const TextStyle(
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
            child: const Text("Change")),
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
      return kCard(
        isPremium: true,
        radius: 0,
        width: double.maxFinite,
        padding: const EdgeInsets.all(kPadding),
        child: SafeArea(
          child: clubData.when(
            data: (data) {
              if (data != null) {
                double mySpent = parseToDouble(data["mySpent"]);
                double clubHouseYearlySpend =
                    parseToDouble(data["clubHouseYearlySpend"]);
                return Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Club House Stats",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton.filledTonal(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.close)),
                        ),
                      ],
                    ),
                    data["isMember"] == "true"
                        ? Column(
                            children: [
                              height20,
                              Text(
                                "FY ${data['targetFy']} Spent",
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              height10,
                              Text(
                                "${kCurrencyFormat(mySpent, decimalDigit: 0)} / ${kCurrencyFormat(clubHouseYearlySpend, decimalDigit: 0)}",
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
                                ),
                              ),
                              height20,
                              if (mySpent > clubHouseYearlySpend)
                                const Text(
                                  "Target Achieved!",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                )
                              else
                                Text(
                                  "${(mySpent / clubHouseYearlySpend).floor() * 100}% completed",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              height5,
                              if (mySpent < clubHouseYearlySpend)
                                ClipRRect(
                                  borderRadius: kRadius(10),
                                  child: LinearProgressIndicator(
                                    value: (mySpent / clubHouseYearlySpend),
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
                                  const Text(
                                    "Club Housefull",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  height20,
                                  const Text(
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
                                  const Center(
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
                                      padding: const EdgeInsets.only(bottom: 2),
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Light.primary,
                                                  width: 2))),
                                      child: Text(
                                        "At just ${kCurrencyFormat(data["clubHouseMembership"], decimalDigit: 0)}*",
                                        style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w900,
                                          color: Light.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                  height20,
                                  const Text(
                                    "Benefits",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w800),
                                  ),
                                  Text(
                                    "- Member of Fiscal Year ${data['targetFy']}.",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const Text(
                                    "- Receive 10% of company's profit in the end of the fiscal year, distributed equally among all Clubhouse Achievers.",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  height20,
                                  const Text(
                                    "Terms",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w800),
                                  ),
                                  Text(
                                    "- Yearly target of ${kCurrencyFormat(clubHouseYearlySpend)} must be completed individually.",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const Text(
                                    "- Spends will be accumulated from 1st April - 31st March of the Fiscal Year.",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  const Text(
                                    "- Non-Refundable.",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  height20,
                                  const Center(
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
                                      color: Light.primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: kRadius(100),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40),
                                      textColor: Colors.white,
                                      child: const Text(
                                        "Buy Now",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                  ],
                );
              } else {
                return kNoData(title: "Oops!", subtitle: "Try again later!");
              }
            },
            error: (error, stackTrace) =>
                kNoData(title: "Oops!", subtitle: "Try again later!"),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
        ),
      );
    },
  );
}

Widget kPoint(int index, String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$index.",
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        width10,
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    ),
  );
}

Widget kPagination({
  required void Function()? onDecrement,
  required void Function()? onIncrement,
  required int pageNo,
}) {
  return Row(
    children: [
      CircleAvatar(
        child: IconButton(
          onPressed: onDecrement,
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      width20,
      Text(
        "Page ${pageNo + 1}",
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      width20,
      CircleAvatar(
        backgroundColor: Light.secondary,
        foregroundColor: Colors.white,
        child: IconButton(
          onPressed: onIncrement,
          icon: const Icon(Icons.arrow_forward),
        ),
      ),
    ],
  );
}
