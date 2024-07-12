import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kCarousel.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/colors.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({super.key});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  @override
  Widget build(BuildContext context) {
    return KScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              height20,
              kWalletCard(),
              height15,
              KCarousel(
                height: 120,
                children: [
                  KCarousel.Item(
                      radius: 10,
                      padding: EdgeInsets.zero,
                      url:
                          "https://img.freepik.com/free-vector/mega-sale-offers-banner-template_1017-31299.jpg"),
                ],
                isLooped: true,
              ),
              height15,
              kCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kLabel('Recharge, Booking & Bill Payments'),
                    height20,
                    GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                            iconPath: "$kServiceIcon/dth.svg", label: "DTH"),
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
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                            iconPath: "$kServiceIcon/bus.svg", label: "Bus"),
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
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                      ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        _serviceButton(iconPath: "", label: "E-Commerce"),
                        _serviceButton(iconPath: "", label: "Train"),
                        _serviceButton(iconPath: "", label: "Hotels"),
                        _serviceButton(iconPath: "", label: "Bus"),
                        _serviceButton(iconPath: "", label: "Car"),
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
                      itemBuilder: (context, index) => _recentHistoryCard(),
                    ),
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

  Row _header() {
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
        Container(
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
      ],
    );
  }

  Row _recentHistoryCard() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20,
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
    return Expanded(
      child: iconPath != null && label != null
          ? IconButton(
              onPressed: () {},
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 25,
                    child: FittedBox(
                      child: SvgPicture.asset(
                        iconPath,
                        colorFilter: kSvgColor(kPrimaryColor),
                      ),
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
          : SizedBox(),
    );
  }
}
