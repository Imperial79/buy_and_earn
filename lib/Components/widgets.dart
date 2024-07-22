import 'package:buy_and_earn/Repository/wallet_repository.dart';
import 'package:buy_and_earn/Screens/Wallet/WalletUI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Utils/Common Widgets/kButton.dart';
import '../Utils/colors.dart';
import '../Utils/commons.dart';

Widget kLabel(String label) {
  return Text(
    label,
    style: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 17,
    ),
  );
}

Widget kCard({Widget? child}) {
  return Card(
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: Colors.grey.shade300,
      ),
      borderRadius: kRadius(7),
    ),
    color: kCardColor,
    child: Padding(
      padding: EdgeInsets.all(12),
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
                // size: 60,
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
              label: "Report",
            )
          ],
        ),
      ),
    );
  });
}
