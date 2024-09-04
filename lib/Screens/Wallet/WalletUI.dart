import 'package:buy_and_earn/Components/constants.dart';
import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Repository/wallet_repository.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kButton.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kTextfield.dart';
import 'package:buy_and_earn/Utils/colors.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WalletUI extends ConsumerStatefulWidget {
  const WalletUI({super.key});

  @override
  ConsumerState<WalletUI> createState() => _WalletUIState();
}

class _WalletUIState extends ConsumerState<WalletUI> {
  final amount = TextEditingController();

  @override
  void dispose() {
    amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wallet = ref.watch(walletFuture);
    return KScaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kCard(
                cardColor: kPrimaryColor,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Wallet",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: Colors.white),
                          ),
                          height10,
                          Text(
                            wallet.when(
                              data: (data) =>
                                  kCurrencyFormat("${data!["balance"]}"),
                              error: (error, stackTrace) => "-",
                              loading: () => "...",
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              height15,
              TextFieldTapRegion(
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                child: KTextfield.regular(
                  context,
                  controller: amount,
                  textSize: 25,
                  keyboardType: TextInputType.number,
                  prefixText: "₹ ",
                  hintText: "Enter amount",
                  onChanged: (val) {
                    setState(() {});
                  },
                ),
              ),
              height15,
              Text(
                "Recommended",
                style: TextStyle(fontSize: 12),
              ),
              height10,
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  kPill(
                      onTap: () {
                        setState(() {
                          amount.text = "100";
                        });
                      },
                      label: "₹100"),
                  kPill(
                      onTap: () {
                        setState(() {
                          amount.text = "500";
                        });
                      },
                      label: "₹500"),
                  kPill(
                      onTap: () {
                        setState(() {
                          amount.text = "1500";
                        });
                      },
                      label: "₹1,500"),
                  kPill(
                      onTap: () {
                        setState(() {
                          amount.text = "2000";
                        });
                      },
                      label: "₹2,000"),
                  height20,
                  KButton.full(
                    onPressed: amount.text.isNotEmpty ? () {} : null,
                    label: "Proceed to recharge",
                  ),
                  KButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                    label: "History",
                    backgroundColor: Colors.grey.shade300,
                    padding: EdgeInsets.all(10),
                    textColor: Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
