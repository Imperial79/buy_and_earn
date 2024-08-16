import 'package:buy_and_earn/Repository/wallet_repository.dart';
import 'package:buy_and_earn/Screens/Wallet/WalletUI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Screens/Transactions/TransactionDetailUI.dart';
import '../Utils/Common Widgets/kButton.dart';
import '../Utils/colors.dart';
import '../Utils/commons.dart';
import 'constants.dart';

Widget kLabel(String label) {
  return Text(
    label,
    style: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 17,
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

Widget kCard({Widget? child, Color? cardColor, EdgeInsetsGeometry? padding}) {
  return Card(
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
  );
}

Widget kWalletCard(context) {
  return Consumer(builder: (context, ref, child) {
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
                      data: (data) => "₹ ${data?.balance ?? 0.0}",
                      error: (error, stackTrace) => "-",
                      loading: () => "-",
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
            KButton.outlined(
              onPressed: () {
                navPush(context, WalletUI());
              },
              label: "Add Money",
            ),
          ],
        ),
      ),
    );
  });
}

Widget kRecentHistoryCard(context) {
  return InkWell(
    onTap: () {
      navPush(context, TransactionDetailUI());
    },
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20,
          child: SvgPicture.asset(
            kIconMap['electricity']!,
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
                      'Electricity bill paid',
                      style: TextStyle(
                        // fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    "- ₹199",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Text(
                '12736736127362',
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
                      '10 July 2024 • 9:10 pm',
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

Widget kNoData({required String title, String? subtitle, Widget? action}) {
  return Center(
    child: Column(
      children: [
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
  String? phone,
  String region = "Pan India",
}) {
  return kCard(
    child: Row(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(providerImage),
              fit: BoxFit.contain,
            ),
          ),
        ),
        width20,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                providerName,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
              ),
              phone != null
                  ? Padding(
                      padding: EdgeInsets.only(top: 0.0),
                      child: Text(
                        "+91 $phone",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    )
                  : SizedBox(),
              Text(
                region,
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
