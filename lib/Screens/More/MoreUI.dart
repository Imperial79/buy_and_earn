import 'package:buy_and_earn/Components/constants.dart';
import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Repository/auth_repository.dart';
import 'package:buy_and_earn/Screens/Auth/RegisterUI.dart';
import 'package:buy_and_earn/Screens/More/HelpUI.dart';
import 'package:buy_and_earn/Screens/RootUI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kButton.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/colors.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreUI extends ConsumerStatefulWidget {
  const MoreUI({super.key});

  @override
  ConsumerState<MoreUI> createState() => _MoreUIState();
}

class _MoreUIState extends ConsumerState<MoreUI> {
  bool _isLoading = false;

  _logout() async {
    setState(() => _isLoading = true);
    final res = await ref.read(authRepository).logout({});
    if (!res.error) {
      navPopUntilPush(context, RegisterUI()).then(
        (value) {
          ref.read(userProvider.notifier).state = null;
          ref.read(navigationProvider.notifier).state = 0;
        },
      );
    }
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return KScaffold(
      isLoading: _isLoading,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kWalletCard(context),
              height15,
              kCard(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: Text("${user!.name[0]}"),
                    ),
                    width10,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${user.name}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          height5,
                          Text("+91 ${user.phone}"),
                          Text("${user.email}"),
                          height5,
                          // KButton.outlined(
                          //   onPressed: () {},
                          //   label: "Edit Details",
                          //   textColor: kPrimaryColor,
                          //   borderColor: kPrimaryColor,
                          // ),
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
                            "${user.referCode}",
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
                            Clipboard.setData(
                                ClipboardData(text: "${user.referCode}"));
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
                    // _settingButton(
                    //     onTap: () {},
                    //     label: "My Address",
                    //     iconPath: "$kIconPath/my-address.svg"),
                    // Divider(
                    //   color: Colors.grey.shade300,
                    // ),
                    // _settingButton(
                    //     onTap: () {},
                    //     label: "Change Password",
                    //     iconPath: "$kIconPath/lock.svg"),
                    // Divider(
                    //   color: Colors.grey.shade300,
                    // ),
                    _settingButton(
                        onTap: () {
                          navPush(context, HelpUI());
                        },
                        label: "Help",
                        iconPath: "$kIconPath/info.svg"),
                    Divider(),
                    _settingButton(
                        onTap: () async {
                          await launchUrl(
                            Uri.parse("https://buynearn.shop/privacy"),
                          );
                        },
                        label: "Privacy",
                        iconPath: "$kIconPath/privacy.svg"),
                    Divider(
                        // color: Colors.grey.shade300,
                        ),
                    _settingButton(
                        onTap: () {
                          _logout();
                        },
                        label: "Log Out",
                        iconPath: "$kIconPath/log-out.svg"),
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
    required onTap,
    required String label,
    required String iconPath,
  }) {
    return ListTile(
      onTap: onTap,
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
