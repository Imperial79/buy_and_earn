import 'package:buy_and_earn/Components/constants.dart';
import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Models/transactions_model.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
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
      appBar: AppBar(),
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
                    radius: 20,
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
                              fontWeight: FontWeight.w600, fontSize: 17),
                        ),
                        Text("${txnDetails.title.split('for').last.trim()}"),
                      ],
                    ),
                  ),
                  Text(
                    "${kCurrencyFormat(txnDetails.amount)}",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                ],
              ),
              height20,
              Text(
                "Payment Breakdown",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Divider(
                height: 30,
              ),
              Column(
                children: txnDetails.paymentBreakdown.entries.map((entry) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(entry.key),
                      Text("${kCurrencyFormat(entry.value, decimalDigit: 6)}"),
                    ],
                  );
                }).toList(),
              ),
              Divider(
                height: 30,
              ),
              Text(
                "Transaction ID",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                "BNETXN${txnDetails.id}",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _statusCard() {
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
