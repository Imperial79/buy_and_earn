import 'package:buy_and_earn/Components/constants.dart';
import 'package:buy_and_earn/Screens/Auth/RegisterUI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kButton.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kCarousel.dart';
import 'package:buy_and_earn/Utils/colors.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeUI extends StatefulWidget {
  const WelcomeUI({super.key});

  @override
  State<WelcomeUI> createState() => _WelcomeUIState();
}

class _WelcomeUIState extends State<WelcomeUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            KCarousel(
              indicatorSpacing: 20,
              viewportFraction: 1,
              children: [
                SvgPicture.asset("$welcomeImages/1.svg"),
                SvgPicture.asset("$welcomeImages/2.svg"),
                SvgPicture.asset("$welcomeImages/3.svg"),
                SvgPicture.asset("$welcomeImages/4.svg"),
                SvgPicture.asset("$welcomeImages/5.svg"),
              ],
              isLooped: true,
            ),
            kHeight(40),
            Padding(
              padding: EdgeInsets.all(kPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome to",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "Buy n Earn",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SafeArea(
        child: KButton(
          onPressed: () {
            navPush(context, RegisterUI());
          },
          label: "Proceed",
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          backgroundColor: kSecondaryColor,
        ).thickPill,
      ),
    );
  }
}
