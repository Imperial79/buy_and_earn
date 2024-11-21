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
import '../../Utils/colors.dart';

class TransactionDetailUI extends StatefulWidget {
  final Transactions_Model txn;
  const TransactionDetailUI({super.key, required this.txn});

  @override
  State<TransactionDetailUI> createState() =>
      _TransactionDetailUIState(txn: txn);
}

class _TransactionDetailUIState extends State<TransactionDetailUI> {
  final Transactions_Model txn;
  _TransactionDetailUIState({required this.txn});

  @override
  Widget build(BuildContext context) {
    return KScaffold(
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _statusCard(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kLabel(txn.source),
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
                                txn.title.split('for').first.trim(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              Text(
                                txn.title.split('for').last.trim(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          kCurrencyFormat(txn.amount),
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 15),
                        ),
                      ],
                    ),
                    height10,
                    const Text(
                      "Note - The amount shown is rounded to 2 decimal places, but the actual amount Credited/Debited may be smaller and cannot be fully displayed here.",
                      style: TextStyle(fontSize: 13),
                    ),
                    height20,
                    kLabel("Payment Breakdown", top: 0, bottom: 10),
                    kCard(
                      child: Column(
                        children: txn.paymentBreakdown.entries.map((entry) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(entry.key),
                              Text(kCurrencyFormat(entry.value,
                                  decimalDigit: 6)),
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
                            "BNETXN${txn.id}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                        ),
                        width10,
                        IconButton.filledTonal(
                          onPressed: () {
                            Clipboard.setData(
                                    ClipboardData(text: "BNETXN${txn.id}"))
                                .then(
                              (value) {
                                KSnackbar(context,
                                    content:
                                        "Transaction ID copied to clipboard!");
                              },
                            );
                          },
                          visualDensity: VisualDensity.compact,
                          icon: const Icon(
                            Icons.copy,
                            size: 15,
                          ),
                        ),
                      ],
                    ),
                    height20,
                    KButton(
                      onPressed: () {
                        navPush(context, const HelpUI());
                      },
                      label: "Need Help?",
                      fontSize: 15,
                      icon: const Icon(
                        Icons.help,
                        size: 20,
                      ),
                    ).outlinedFull,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusCard() {
    String status = txn.status;
    return Container(
      color: kColorMap[status] ?? Colors.black,
      width: double.maxFinite,
      padding: const EdgeInsets.all(20),
      child: SafeArea(
        child: Column(
          children: [
            Icon(
              kStatusIconMap[status],
              color: Colors.white,
              size: 30,
            ),
            Text(
              "Transaction $status",
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            Text(
              DateFormat('dd MMM yyyy • h:mm a')
                  .format(DateTime.parse(txn.date)),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
