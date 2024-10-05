import 'package:buy_and_earn/Components/constants.dart';
import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Models/transactions_model.dart';
import 'package:buy_and_earn/Screens/More/HelpUI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kButton.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class TransactionDetailUI extends StatefulWidget {
  final Transactions_Model txnDetails;
  const TransactionDetailUI({super.key, required this.txnDetails});

  @override
  State<TransactionDetailUI> createState() =>
      _TransactionDetailUIState(txnDetails: txnDetails);
}

class _TransactionDetailUIState extends State<TransactionDetailUI> {
  final Transactions_Model txnDetails;
  _TransactionDetailUIState({required this.txnDetails});

  @override
  Widget build(BuildContext context) {
    return KScaffold(
      appBar: KAppBar(
        context,
        showOriginal: true,
        title: "BNETXN${txnDetails.id}",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _statusCard(),
              kLabel("${txnDetails.source}"),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 22,
                    child: SvgPicture.asset(
                      kIconMap["Prepaid"]!,
                    ),
                  ),
                  width10,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${txnDetails.title.split('for').first.trim()}",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                        Text(
                          "${txnDetails.title.split('for').last.trim()}",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "${kCurrencyFormat(txnDetails.amount)}",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                ],
              ),
              height10,
              Text(
                "Note - The amount shown is rounded to 2 decimal places, but the actual amount Credited/Debited may be smaller and cannot be fully displayed here.",
                style: TextStyle(fontSize: 13),
              ),
              height20,
              kLabel("Payment Breakdown", top: 0, bottom: 10),
              kCard(
                child: Column(
                  children: txnDetails.paymentBreakdown.entries.map((entry) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(entry.key),
                        Text(
                            "${kCurrencyFormat(entry.value, decimalDigit: 6)}"),
                      ],
                    );
                  }).toList(),
                ),
              ),
              kLabel("Transaction ID", bottom: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "BNETXN${txnDetails.id}",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                  ),
                  width10,
                  IconButton.filledTonal(
                    onPressed: () {
                      Clipboard.setData(
                              ClipboardData(text: "BNETXN${txnDetails.id}"))
                          .then(
                        (value) {
                          KSnackbar(context,
                              content: "Transaction ID copied to clipboard!");
                        },
                      );
                    },
                    visualDensity: VisualDensity.compact,
                    icon: Icon(
                      Icons.copy,
                      size: 15,
                    ),
                  ),
                ],
              ),
              height20,
              KButton(
                onPressed: () {
                  navPush(context, HelpUI());
                },
                label: "Need Help?",
                fontSize: 15,
                icon: Icon(
                  Icons.help,
                  size: 20,
                ),
              ).outlinedFull,
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusCard() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: kColorMap[txnDetails.status],
        borderRadius: kRadius(10),
      ),
      child: Row(
        children: [
          Icon(
            txnDetails.status == "Success"
                ? Icons.check_circle_outlined
                : Icons.info_outline,
            color: Colors.white,
          ),
          width10,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Transaction ${txnDetails.status}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  DateFormat('dd MMM yyyy • h:mm a')
                      .format(DateTime.parse(txnDetails.date)),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
