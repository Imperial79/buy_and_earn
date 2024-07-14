import 'package:buy_and_earn/Components/constants.dart';
import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kButton.dart';
import 'package:buy_and_earn/Utils/colors.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MoreUI extends StatefulWidget {
  const MoreUI({super.key});

  @override
  State<MoreUI> createState() => _MoreUIState();
}

class _MoreUIState extends State<MoreUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kWalletCard(),
              height15,
              kCard(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 30,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 13,
                          child: FittedBox(
                            child: Icon(
                              Icons.edit,
                              size: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    width10,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Avishek",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          height5,
                          Text("+91 9090293832"),
                          Text("avishek@gmail.com"),
                          height5,
                          KButton.outlined(
                            onPressed: () {},
                            label: "Edit Details",
                            textColor: kPrimaryColor,
                            borderColor: kPrimaryColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              height15,
              kCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kLabel("Refer Code"),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "ABCDJ67S",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.grey.shade700,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        width5,
                        IconButton.filledTonal(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: "ABCDJ67S"));
                            KSnackbar(context,
                                content: "Refer Code copied to clipboard",
                                isDanger: false);
                          },
                          icon: Icon(
                            Icons.copy,
                            size: 15,
                          ),
                        ),
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
                    _settingButton(
                        label: "My Address",
                        iconPath: "$kIconPath/my-address.svg"),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    _settingButton(
                        label: "Change Password",
                        iconPath: "$kIconPath/lock.svg"),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    _settingButton(
                        label: "Help", iconPath: "$kIconPath/info.svg"),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    _settingButton(
                        label: "Privacy", iconPath: "$kIconPath/privacy.svg"),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    _settingButton(
                        label: "Log Out", iconPath: "$kIconPath/log-out.svg"),
                  ],
                ),
              ),
              height15,
              Text("Version $kAppVersion"),
              Text(
                "ImVy Developers©",
                style: TextStyle(color: Colors.grey),
              ),
              kHeight(100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _settingButton({
    required String label,
    required String iconPath,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      minVerticalPadding: 10,
      leading: SvgPicture.asset(
        iconPath,
        height: 20,
        colorFilter: kSvgColor(kPrimaryColor),
      ),
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.black,
        fontSize: 15,
        fontFamily: "Jakarta",
      ),
      title: Text(label),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey,
        size: 15,
      ),
    );
  }
}
