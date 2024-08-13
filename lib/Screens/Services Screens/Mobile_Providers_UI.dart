import 'package:buy_and_earn/Screens/Services%20Screens/Mobile_Recharge_UI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';

class Mobile_Providers_UI extends StatefulWidget {
  const Mobile_Providers_UI({super.key});

  @override
  State<Mobile_Providers_UI> createState() => _Mobile_Providers_UIState();
}

class _Mobile_Providers_UIState extends State<Mobile_Providers_UI> {
  @override
  Widget build(BuildContext context) {
    return KScaffold(
      appBar: KAppBar(context, title: "Select Provider", showBack: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(kPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                onTap: () {
                  navPush(context, Mobile_Recharge_UI());
                },
                tileColor: Colors.white,
                leading: CircleAvatar(),
                title: Text(
                  "Airtel",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
