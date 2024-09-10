import 'package:buy_and_earn/Components/constants.dart';
import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Repository/wallet_repository.dart';
import 'package:buy_and_earn/Screens/RootUI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kButton.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kCarousel.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/colors.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:url_launcher/url_launcher.dart';

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
      appBar: KAppBar(context, title: "Wallet", showBack: true, actions: [
        IconButton(
            onPressed: () {
              ref.read(navigationProvider.notifier).state = 2;
              Navigator.pop(context);
            },
            icon: Icon(Icons.history)),
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
                              data: (data) => kCurrencyFormat(data!.balance),
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
              // height15,
              // TextFieldTapRegion(
              //   onTapOutside: (event) {
              //     FocusScope.of(context).unfocus();
              //   },
              //   child: KTextfield.regular(
              //     context,
              //     controller: amount,
              //     textSize: 25,
              //     keyboardType: TextInputType.number,
              //     prefixText: "₹ ",
              //     hintText: "Enter amount",
              //     onChanged: (val) {
              //       setState(() {});
              //     },
              //   ),
              // ),
              // height15,
              // Text(
              //   "Recommended",
              //   style: TextStyle(fontSize: 12),
              // ),
              // height10,
              // Wrap(
              //   spacing: 10,
              //   runSpacing: 10,
              //   children: [
              //     kPill(
              //         onTap: () {
              //           setState(() {
              //             amount.text = "100";
              //           });
              //         },
              //         label: "₹100"),
              //     kPill(
              //         onTap: () {
              //           setState(() {
              //             amount.text = "500";
              //           });
              //         },
              //         label: "₹500"),
              //     kPill(
              //         onTap: () {
              //           setState(() {
              //             amount.text = "1500";
              //           });
              //         },
              //         label: "₹1,500"),
              //     kPill(
              //         onTap: () {
              //           setState(() {
              //             amount.text = "2000";
              //           });
              //         },
              //         label: "₹2,000"),
              //   ],
              // ),
              // height20,
              // KButton.full(
              //   onPressed: amount.text.isNotEmpty ? () {} : null,
              //   label: "Proceed to recharge",
              // ),
              kLabel(
                "How to recharge wallet:",
              ),
              kPoint(1, "Transfer amount on the details given below."),
              kPoint(2, "Share payment details on WhatsApp/Telegram."),

              // _bankCard(),
              height20,
              KCarousel(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("$kImagePath/admin-gpay.jpg"),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("$kImagePath/admin-wp.jpg"),
                      ),
                    ),
                  ),
                ],
                isLooped: false,
              ),
              height20,
              Row(
                children: [
                  Expanded(
                    child: KButton.full(
                        onPressed: () async {
                          await launchUrl(Uri.parse("https://t.me/BSPL2"));
                        },
                        backgroundColor: Colors.blue.shade700,
                        label: "Telegram",
                        fontSize: 15),
                  ),
                  width10,
                  Expanded(
                    child: KButton.full(
                      onPressed: () async {
                        await launchUrl(Uri.parse("https://wa.me/7454038717"));
                      },
                      backgroundColor: Colors.green.shade700,
                      label: "WhatsApp",
                      fontSize: 15,
                    ),
                  ),
                ],
              ),

              kLabel("Today's Earnings"),

              wallet.when(
                data: (data) => StaggeredGridView.count(
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
                    _statCard(
                        kCurrencyFormat(
                          data!.selfCashback,
                          decimalDigit: 5,
                        ),
                        "Self Cashback"),
                    _statCard(
                      kCurrencyFormat(
                        data.referralIncome,
                        decimalDigit: 5,
                      ),
                      "Level Commission",
                    ),
                    _statCard(
                      kCurrencyFormat(
                        data.workingBonus,
                        decimalDigit: 5,
                      ),
                      "Working Bonus",
                    ),
                    _statCard(
                        kCurrencyFormat(
                          data.reward,
                          decimalDigit: 5,
                        ),
                        "Rewards"),
                  ],
                ),
                error: (error, stackTrace) => SizedBox(),
                loading: () => CircularProgressIndicator(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _bankCard() {
    return Card(
      color: Colors.black,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.security_rounded,
                size: 70,
                color: Colors.white.withOpacity(.2),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.account_balance_outlined,
                      color: Colors.white,
                    ),
                    width10,
                    Flexible(
                      child: Text(
                        "BankName",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                kHeight(40),
                Text(
                  "Acc No",
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 5,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "IFSC",
                  style: TextStyle(
                    fontSize: 12,
                    letterSpacing: 2,
                    color: Colors.white,
                  ),
                ),
                kHeight(30),
                Text(
                  "Holder Name",
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white,
                  ),
                ),
                height5,
                Text(
                  "Admin Name",
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 2,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
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
