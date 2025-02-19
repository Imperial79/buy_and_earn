import 'package:buy_and_earn/Components/constants.dart';
import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Repository/wallet_repository.dart';
import 'package:buy_and_earn/Screens/RootUI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/Label.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kButton.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/colors.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:simple_shadow/simple_shadow.dart';
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
            icon: const Icon(Icons.history)),
        width10,
      ]),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SimpleShadow(
                opacity: .1,
                sigma: 10,
                child: kCard(
                  color: Light.card,
                  borderWidth: 0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Available balance",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                // color: Colors.white,
                              ),
                            ),
                            height10,
                            Text(
                              wallet.when(
                                data: (data) => kCurrencyFormat(data!.balance),
                                error: (error, stackTrace) => "-",
                                loading: () => "...",
                              ),
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Light.primary,
                                fontSize: 30,
                                // color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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

              // _bankCard(),
              height20,
              const Text(
                "How to recharge wallet ?",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
              height20,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("$kImagePath/admin-gpay.jpg"),
                      ),
                    ),
                  ),
                  width20,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        kPoint(1,
                            "Transfer amount on the QR Code with any UPI enabled payments app."),
                        kPoint(
                            2, "Share payment details on WhatsApp/Telegram."),
                      ],
                    ),
                  ),
                ],
              ),
              height20,
              Row(
                children: [
                  Expanded(
                    child: KButton(
                      onPressed: () async {
                        await launchUrl(Uri.parse("https://t.me/BSPL2"));
                      },
                      backgroundColor: Colors.blue.shade700,
                      label: "Telegram",
                      fontSize: 15,
                    ).full,
                  ),
                  width10,
                  Expanded(
                    child: KButton(
                      onPressed: () async {
                        await launchUrl(Uri.parse("https://wa.me/7454038717"));
                      },
                      backgroundColor: Colors.green.shade700,
                      label: "WhatsApp",
                      fontSize: 15,
                    ).full,
                  ),
                ],
              ),
              height20,
              Label("Today's Earnings").regular, height10,

              wallet.when(
                data: (data) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StaggeredGridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      staggeredTiles: List.generate(
                        6,
                        (index) => const StaggeredTile.fit(1),
                      ),
                      children: [
                        _statCard(
                            kCurrencyFormat(
                              data!.selfCashback,
                              decimalDigit: 5,
                            ),
                            "Self Cashback"),
                        _statCard(
                          kCurrencyFormat(
                            data.levelCommission,
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
                        _statCard(
                          kCurrencyFormat(
                            data.clubhouseCommission,
                            decimalDigit: 5,
                          ),
                          "Club House Commission",
                        ),
                        _statCard(
                          kCurrencyFormat(
                            data.royalAchieversCommission,
                            decimalDigit: 5,
                          ),
                          "Royal Achievers Commission",
                        ),
                      ],
                    ),
                    height20,
                    Label("Last month earning").regular,
                    height10,
                    _statCard(
                      kCurrencyFormat(
                        data.lastMonthCommissionEarned,
                        decimalDigit: 5,
                      ),
                      "TDS Deducted ${kCurrencyFormat(data.lastMonthTdsDeducted)}",
                      contentColor: Colors.red.shade700,
                      title: DateFormat("MMMM").format(DateTime(
                          DateTime.now().year, DateTime.now().month - 1)),
                    ),
                  ],
                ),
                error: (error, stackTrace) => const SizedBox(),
                loading: () => const CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _bankCard() {
  //   return Card(
  //     color: Colors.black,
  //     child: Padding(
  //       padding: const EdgeInsets.all(12),
  //       child: Stack(
  //         children: [
  //           Align(
  //             alignment: Alignment.topRight,
  //             child: Icon(
  //               Icons.security_rounded,
  //               size: 70,
  //               color: Colors.white.withOpacity(.2),
  //             ),
  //           ),
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Row(
  //                 children: [
  //                   const Icon(
  //                     Icons.account_balance_outlined,
  //                     color: Colors.white,
  //                   ),
  //                   width10,
  //                   const Flexible(
  //                     child: Text(
  //                       "BankName",
  //                       style: TextStyle(
  //                         fontSize: 15,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               kHeight(40),
  //               const Text(
  //                 "Acc No",
  //                 style: TextStyle(
  //                   fontSize: 20,
  //                   letterSpacing: 5,
  //                   color: Colors.white,
  //                 ),
  //               ),
  //               const Text(
  //                 "IFSC",
  //                 style: TextStyle(
  //                   fontSize: 12,
  //                   letterSpacing: 2,
  //                   color: Colors.white,
  //                 ),
  //               ),
  //               kHeight(30),
  //               const Text(
  //                 "Holder Name",
  //                 style: TextStyle(
  //                   fontSize: 11,
  //                   color: Colors.white,
  //                 ),
  //               ),
  //               height5,
  //               const Text(
  //                 "Admin Name",
  //                 style: TextStyle(
  //                   fontSize: 16,
  //                   letterSpacing: 2,
  //                   color: Colors.white,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _statCard(
    String label,
    String content, {
    Color? contentColor,
    String? title,
  }) {
    return kCard(
      color: Light.card,
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Row(
                children: [
                  const Expanded(child: Text("Commission Earned")),
                  Text(
                    title.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          height10,
          Text(
            content,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: contentColor,
              letterSpacing: .5,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
