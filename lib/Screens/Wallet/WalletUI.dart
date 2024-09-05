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
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

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
      appBar: KAppBar(context, title: "Wallet", actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.history)),
        width10,
      ]),
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
                            "Available balance",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
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
                              fontWeight: FontWeight.w600,
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
                  height20,
                  kLabel("Today's Stats"),
                  height15,
                  StaggeredGridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    physics: NeverScrollableScrollPhysics(),
                    staggeredTiles: [
                      StaggeredTile.fit(1),
                      StaggeredTile.fit(1),
                      StaggeredTile.fit(1),
                      StaggeredTile.fit(1),
                    ],
                    children: [
                      _statCard("₹ 100", "Total earned"),
                      _statCard(
                        "100",
                        "Total Distance Travelled (Kms)",
                      ),
                      _statCard(
                        "⭐ 2",
                        "Average Ratings",
                      ),
                      _statCard("1", "Total Trips"),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statCard(String label, String content) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: kRadius(10),
      ),
      color: kCardColor,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
            height10,
            Text(
              content,
              style: TextStyle(
                fontSize: 13,
                letterSpacing: 1,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
