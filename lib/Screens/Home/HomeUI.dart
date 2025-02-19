import 'package:buy_and_earn/Components/constants.dart';
import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Repository/auth_repository.dart';
import 'package:buy_and_earn/Repository/carousel_repository.dart';
import 'package:buy_and_earn/Screens/Home/Reminder_Card.dart';
import 'package:buy_and_earn/Screens/RootUI.dart';
import 'package:buy_and_earn/Screens/Services%20Screens/Recharge/Providers_UI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/Label.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kCarousel.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/colors.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../More/KycUI.dart';

class HomeUI extends ConsumerStatefulWidget {
  const HomeUI({super.key});

  @override
  ConsumerState<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends ConsumerState<HomeUI> {
  @override
  Widget build(BuildContext context) {
    final carouselData = ref.watch(carouselFuture);
    final customer = ref.watch(customerProvider);
    return KScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              height10,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _header(),
                    kWalletCard(context),
                  ],
                ),
              ),
              ReminderCard(
                visible: customer!.kycStatus != "Verified",
                cardColor: customer.kycStatus == "Processing"
                    ? Colors.amber.shade100
                    : customer.kycStatus == "Rejected"
                        ? Colors.red.shade100
                        : Colors.amber.shade100,
                iconColor: customer.kycStatus == "Processing"
                    ? Colors.amber.shade900
                    : customer.kycStatus == "Rejected"
                        ? Colors.red.shade900
                        : Colors.amber.shade900,
                onTap: () {
                  navPush(context, const KycUI());
                },
                title: "KYC ${customer.kycStatus}",
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ReminderCard(
                  icon: Icons.person,
                  visible: customer.status == "Pending",
                  cardColor: Colors.amber.shade100,
                  iconColor: Colors.amber.shade900,
                  title: "Profile Pending",
                  onTap: () {
                    ref.read(navigationProvider.notifier).state = 3;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: carouselData.when(
                  data: (data) => KCarousel(
                    height: 200,
                    isLooped: data.length == 1 ? false : true,
                    children: List.generate(
                      data.length,
                      (index) => KCarousel.Item(
                        onTap: () async {
                          if (data[index]["action"] == "External Link") {
                            await launchUrlString(
                              data[index]["remarks"],
                              mode: LaunchMode.externalApplication,
                            );
                          }
                        },
                        radius: 10,
                        url: data[index]["image"],
                      ),
                    ),
                  ),
                  error: (error, stackTrace) => const SizedBox(),
                  loading: () => const Text("Loading..."),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Label('Recharge').regular,
                          height10,
                          GridView(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                            ),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              _serviceButton(
                                  onPressed: () {
                                    navPush(
                                      context,
                                      const Providers_UI(
                                        service: "Prepaid",
                                      ),
                                    );
                                  },
                                  label: "Prepaid"),
                              // _serviceButton(
                              //     iconPath: "$kServiceIcon/postpaid.svg",
                              //     label: "Postpaid"),
                              _serviceButton(
                                onPressed: () {
                                  navPush(
                                    context,
                                    const Providers_UI(
                                      service: "DTH",
                                    ),
                                  );
                                },
                                label: "DTH",
                              ),
                              // _serviceButton(
                              //     iconPath: "$kServiceIcon/electricity.svg",
                              //     label: "Electricity"),
                              // _serviceButton(
                              //     iconPath: "$kServiceIcon/broadband.svg",
                              //     label: "Broadband"),
                              // _serviceButton(
                              //     iconPath: "$kServiceIcon/fasttag.svg",
                              //     label: "Fast Tag"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // height15,
                    // kCard(
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       kLabel('Tours & Travel'),
                    //       height20,
                    //       GridView(
                    //         gridDelegate:
                    //             SliverGridDelegateWithFixedCrossAxisCount(
                    //           crossAxisCount: 4,
                    //         ),
                    //         shrinkWrap: true,
                    //         physics: NeverScrollableScrollPhysics(),
                    //         children: [
                    //           _serviceButton(
                    //               iconPath: "$kServiceIcon/flight.svg",
                    //               label: "Flight"),
                    //           _serviceButton(
                    //               iconPath: "$kServiceIcon/train.svg",
                    //               label: "Train"),
                    //           _serviceButton(
                    //               iconPath: "$kServiceIcon/hotel.svg",
                    //               label: "Hotels"),
                    //           _serviceButton(
                    //               iconPath: "$kServiceIcon/bus.svg",
                    //               label: "Bus"),
                    //           _serviceButton(
                    //               iconPath: "$kServiceIcon/car.svg",
                    //               label: "Car"),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // height15,
                    // kCard(
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       kLabel('Others'),
                    //       height20,
                    //       GridView(
                    //         gridDelegate:
                    //             SliverGridDelegateWithFixedCrossAxisCount(
                    //           crossAxisCount: 4,
                    //         ),
                    //         shrinkWrap: true,
                    //         physics: NeverScrollableScrollPhysics(),
                    //         children: [
                    //           _serviceButton(
                    //               iconPath: "$kServiceIcon/store.svg",
                    //               label: "E-Commerce"),
                    //           _serviceButton(
                    //               iconPath: "$kServiceIcon/garments.svg",
                    //               label: "Garments"),
                    //           _serviceButton(
                    //               iconPath: "$kServiceIcon/grocery.svg",
                    //               label: "Grocery"),
                    //           _serviceButton(
                    //               iconPath: "$kServiceIcon/food.svg",
                    //               label: "Food"),
                    //           _serviceButton(
                    //               iconPath: "$kServiceIcon/courier.svg",
                    //               label: "Courier"),
                    //           _serviceButton(
                    //               iconPath: "$kServiceIcon/local.svg",
                    //               label: "Local"),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    //     height15,
                    // kCard(
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             kLabel("Recent Payments"),
                    //             height20,
                    //             ListView.separated(
                    //               separatorBuilder: (context, index) => Divider(
                    //                 height: 30,
                    //                 color: Colors.grey.shade300,
                    //               ),
                    //               itemCount: 5,
                    //               shrinkWrap: true,
                    //               physics: NeverScrollableScrollPhysics(),
                    //               itemBuilder: (context, index) =>
                    //                   kRecentHistoryCard(context),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                  ],
                ),
              ),
              kHeight(100),
            ],
          ),
        ),
      ),
    );
  }

  // Widget kReminderCard(
  //   BuildContext context, {
  //   bool visible = true,
  //   void Function()? onTap,
  //   String title = "Title",
  //   String subTitle = "Subtitle",
  //   Widget? content,
  //   void Function()? onClose,
  //   Color? cardColor,
  //   Color? iconColor,
  //   IconData? icon,
  // }) {
  //   return Visibility(
  //     visible: visible,
  //     child: GestureDetector(
  //       onTap: onTap,
  //       child: Card(
  //         shape: RoundedRectangleBorder(
  //           side: BorderSide(
  //             color: iconColor ?? kColor(context).secondary,
  //             width: .5,
  //           ),
  //           borderRadius: kRadius(10),
  //         ),
  //         color: cardColor ?? kColor(context).secondaryContainer,
  //         margin: EdgeInsets.only(
  //           left: kPadding,
  //           right: kPadding,
  //           bottom: kPadding,
  //         ),
  //         child: Padding(
  //           padding: EdgeInsets.all(kPadding),
  //           child: Row(
  //             children: [
  //               Icon(
  //                 icon ?? Icons.warning,
  //                 color: iconColor ?? kColor(context).secondary,
  //               ),
  //               width20,
  //               Expanded(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       title,
  //                       style: const TextStyle(
  //                         fontSize: 15,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //                     if (content == null)
  //                       Text(
  //                         subTitle,
  //                         style: const TextStyle(fontSize: 13),
  //                       )
  //                     else
  //                       content,
  //                   ],
  //                 ),
  //               ),
  //               IconButton(
  //                 onPressed: onClose,
  //                 visualDensity: VisualDensity.compact,
  //                 icon: Icon(
  //                   Icons.close,
  //                   color: iconColor ?? kColor(context).secondary,
  //                   size: 20,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _header() {
    return Consumer(
      builder: (context, ref, _) {
        final customer = ref.watch(customerProvider);
        return Row(
          children: [
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: "hi ", style: TextStyle(fontSize: 20)),
                    TextSpan(
                      text: "${customer!.name.split(' ').first}!",
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                ref.read(navigationProvider.notifier).state = 3;
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kColor(context).primaryContainer,
                  borderRadius: kRadius(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "+91 ${customer.phone}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    width10,
                    CircleAvatar(
                      radius: 7,
                      backgroundColor: kColor(context).primary,
                      child: FittedBox(
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 10,
                          color: kColor(context).onPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _serviceButton({
    void Function()? onPressed,
    required String label,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 50,
            width: 50,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Light.card,
              border: Border.all(color: Light.border),
            ),
            child: FittedBox(
              child: SvgPicture.asset(
                kIconMap[label]!,
                colorFilter: kSvgColor(Light.primary),
              ),
            ),
          ),
          height10,
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
