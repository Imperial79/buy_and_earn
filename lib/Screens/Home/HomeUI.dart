import 'package:buy_and_earn/Components/constants.dart';
import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Screens/RootUI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kCarousel.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/colors.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeUI extends StatelessWidget {
  const HomeUI({super.key});

  @override
  Widget build(BuildContext context) {
    return KScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _header(),
                    height20,
                    kWalletCard(context),
                    height15,
                  ],
                ),
              ),
              KCarousel(
                height: 120,
                children: [
                  KCarousel.Item(
                      radius: 10,
                      // padding: EdgeInsets.zero,
                      url:
                          "https://img.freepik.com/free-vector/mega-sale-offers-banner-template_1017-31299.jpg"),
                  KCarousel.Item(
                      radius: 10,
                      // padding: EdgeInsets.zero,
                      url:
                          "https://img.freepik.com/free-vector/mega-sale-offers-banner-template_1017-31299.jpg"),
                ],
                isLooped: true,
              ),
              height15,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kLabel('Recharge, Booking & Bill Payments'),
                          height20,
                          GridView(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                            ),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              _serviceButton(
                                  iconPath: "$kServiceIcon/mobile.svg",
                                  label: "Mobile"),
                              _serviceButton(
                                  iconPath: "$kServiceIcon/postpaid.svg",
                                  label: "Postpaid"),
                              _serviceButton(
                                  iconPath: "$kServiceIcon/dth.svg",
                                  label: "DTH"),
                              _serviceButton(
                                  iconPath: "$kServiceIcon/electricity.svg",
                                  label: "Electricity"),
                              _serviceButton(
                                  iconPath: "$kServiceIcon/broadband.svg",
                                  label: "Broadband"),
                              _serviceButton(
                                  iconPath: "$kServiceIcon/fasttag.svg",
                                  label: "Fast Tag"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    height15,
                    kCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kLabel('Tours & Travel'),
                          height20,
                          GridView(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                            ),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              _serviceButton(
                                  iconPath: "$kServiceIcon/flight.svg",
                                  label: "Flight"),
                              _serviceButton(
                                  iconPath: "$kServiceIcon/train.svg",
                                  label: "Train"),
                              _serviceButton(
                                  iconPath: "$kServiceIcon/hotel.svg",
                                  label: "Hotels"),
                              _serviceButton(
                                  iconPath: "$kServiceIcon/bus.svg",
                                  label: "Bus"),
                              _serviceButton(
                                  iconPath: "$kServiceIcon/car.svg",
                                  label: "Car"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    height15,
                    kCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kLabel('Others'),
                          height20,
                          GridView(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                            ),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              _serviceButton(
                                  iconPath: "$kServiceIcon/store.svg",
                                  label: "E-Commerce"),
                              _serviceButton(
                                  iconPath: "$kServiceIcon/garments.svg",
                                  label: "Garments"),
                              _serviceButton(
                                  iconPath: "$kServiceIcon/grocery.svg",
                                  label: "Grocery"),
                              _serviceButton(
                                  iconPath: "$kServiceIcon/food.svg",
                                  label: "Food"),
                              _serviceButton(
                                  iconPath: "$kServiceIcon/courier.svg",
                                  label: "Courier"),
                              _serviceButton(
                                  iconPath: "$kServiceIcon/local.svg",
                                  label: "Local"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    height15,
                    kCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kLabel("Recent Payments"),
                          height20,
                          ListView.separated(
                            separatorBuilder: (context, index) => Divider(
                              height: 30,
                              color: Colors.grey.shade300,
                            ),
                            itemCount: 5,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) =>
                                _recentHistoryCard(),
                          ),
                        ],
                      ),
                    ),
                    kHeight(100),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Consumer(builder: (context, ref, _) {
      return Row(
        children: [
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: "hi ", style: TextStyle(fontSize: 20)),
                  TextSpan(
                    text: "Avishek!",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
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
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: kSecondaryColor.withOpacity(.3),
                borderRadius: kRadius(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "+91 1234567890",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  width5,
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  Row _recentHistoryCard() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20,
          child: SvgPicture.asset(
            kIconMap['electricity']!,
            height: 20,
            colorFilter: kSvgColor(kPrimaryColor),
          ),
        ),
        width10,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Electricity bill paid',
                      style: TextStyle(
                        // fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    "- ₹199",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Text(
                '12736736127362',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              height5,
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '10 July 2024 • 9:10 pm',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  width10,
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                            child: Text(
                          'Debited from',
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.end,
                        )),
                        width5,
                        Icon(
                          Icons.wallet,
                          size: 15,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _serviceButton({
    String? iconPath,
    String? label,
  }) {
    return iconPath != null && label != null
        ? IconButton(
            onPressed: () {},
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 25,
                  child: SvgPicture.asset(
                    iconPath,
                    colorFilter: kSvgColor(kPrimaryColor),
                  ),
                ),
                height5,
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        : SizedBox();
  }
}
