import 'package:buy_and_earn/Components/constants.dart';
import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Models/transactions_model.dart';
import 'package:buy_and_earn/Screens/More/HelpUI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/Label.dart';
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
      appBar: KAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kPadding).copyWith(top: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: _statusCard()),
              const Divider(
                height: 50,
                color: Light.border,
                thickness: 1,
              ),
              Label(txn.source).regular,
              height20,
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
              height15,
              kInfoCard(
                "The amount shown is rounded to 2 decimal places, but the actual amount Credited/Debited may be smaller and cannot be fully displayed here.",
              ),
              height20,
              Label("Payment Breakdown").regular,
              height10,
              kCard(
                child: Column(
                  children: txn.paymentBreakdown.entries.map((entry) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(entry.key),
                        Text(kCurrencyFormat(entry.value, decimalDigit: 6)),
                      ],
                    );
                  }).toList(),
                ),
              ),
              height20,
              Label("Transaction ID").regular,
              height10,
              kCard(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "BNETXN${txn.id}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                    ),
                    width10,
                    IconButton.filled(
                      onPressed: () {
                        Clipboard.setData(
                                ClipboardData(text: "BNETXN${txn.id}"))
                            .then(
                          (value) {
                            KSnackbar(context,
                                content: "Transaction ID copied to clipboard!");
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
                backgroundColor: kColor(context).primary,
              ).outlinedFull,
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusCard() {
    String status = txn.status;
    return Column(
      children: [
        Icon(
          kStatusIconMap[status],
          color: kColorMap[status] ?? Colors.black,
          size: 50,
        ),
        Text.rich(
          TextSpan(
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
            children: [
              const TextSpan(text: "Transaction "),
              TextSpan(
                text: status,
                style: TextStyle(
                  color: kColorMap[status],
                ),
              ),
            ],
          ),
        ),
        const Divider(
          height: 20,
          color: Colors.black,
          thickness: 1,
          indent: 70,
          endIndent: 70,
        ),
        Text(
          DateFormat('dd MMMM yyyy | hh:mm a').format(DateTime.parse(txn.date)),
          style: const TextStyle(
            fontSize: 15,
            wordSpacing: 2,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
