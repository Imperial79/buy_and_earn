// ignore_for_file: unused_result

import 'package:buy_and_earn/Components/constants.dart';
import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Repository/auth_repository.dart';
import 'package:buy_and_earn/Repository/wallet_repository.dart';
import 'package:buy_and_earn/Screens/Auth/RegisterUI.dart';
import 'package:buy_and_earn/Screens/More/ChangePinsUI.dart';
import 'package:buy_and_earn/Screens/More/HelpUI.dart';
import 'package:buy_and_earn/Screens/More/KProfileCard.dart';
import 'package:buy_and_earn/Screens/More/KycUI.dart';
import 'package:buy_and_earn/Screens/RootUI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/Label.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/colors.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Repository/clubHouse_repository.dart';
import '../Auth/TPin_UI.dart';

class MoreUI extends ConsumerStatefulWidget {
  const MoreUI({super.key});

  @override
  ConsumerState<MoreUI> createState() => _MoreUIState();
}

class _MoreUIState extends ConsumerState<MoreUI> {
  bool isLoading = false;

  _logout() async {
    setState(() => isLoading = true);
    final res = await ref.read(authRepository).logout({});
    if (!res.error) {
      navPopUntilPush(context, const RegisterUI()).then(
        (value) {
          ref.read(customerProvider.notifier).state = null;
          ref.read(navigationProvider.notifier).state = 0;
        },
      );
    }
    if (mounted) setState(() => isLoading = false);
  }

  Future<void> _buyMembership() async {
    try {
      setState(() {
        isLoading = true;
      });
      Map? data = await navPush(context, const TPin_UI()) as Map?;

      if (data != null) {
        final res =
            await ref.read(clubHouseRepository).buyMembership(data["tpin"]);

        if (!res.error) {
          ref.refresh(auth.future);
          ref.refresh(walletFuture.future);
        }

        KSnackbar(context, content: res.message, isDanger: res.error);
      }
    } catch (e) {
      KSnackbar(context, content: "Something went wrong!", isDanger: true);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final customer = ref.watch(customerProvider);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        ref.read(navigationProvider.notifier).state = 0;
      },
      child: KScaffold(
        isLoading: isLoading,
        body: customer != null
            ? SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(kPadding).copyWith(top: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kWalletCard(context),
                      KProfileCard(
                        isLoading: (loading) {
                          setState(() {
                            isLoading = loading;
                          });
                        },
                      ),
                      height20,
                      kCard(
                        borderWidth: 1,
                        borderColor: customer.status == "Pending"
                            ? Colors.amber.shade100
                            : Colors.lightGreen.shade500,
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Action Required",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            height10,
                            Row(
                              children: [
                                Icon(
                                  customer.status == "Pending"
                                      ? Icons.do_disturb_outlined
                                      : Icons.check_circle_outline_outlined,
                                  size: 30,
                                  color: Colors.lightGreen.shade900,
                                ),
                                width10,
                                Label(
                                  customer.status == "Pending"
                                      ? "ID Not Activated"
                                      : "ID Activated",
                                ).regular,
                              ],
                            ),
                          ],
                        ),
                      ),
                      height20,
                      kCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Label("Refer Code").regular,
                            height10,
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    customer.referCode,
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
                                    Clipboard.setData(ClipboardData(
                                        text: customer.referCode));
                                    KSnackbar(context,
                                        content:
                                            "Refer Code copied to clipboard",
                                        isDanger: false);
                                  },
                                  icon: const Icon(
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
                      _settingButton(
                        onTap: () {
                          return showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            builder: (context) => SingleChildScrollView(
                              child: kClubModal(
                                context,
                                onPressed: () async {
                                  Navigator.pop(context);
                                  await _buyMembership();
                                },
                              ),
                            ),
                          );
                        },
                        isPremium: true,
                        label: "Club Membership",
                        iconPath: kIconMap["Club House"]!,
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
                            // _settingButton(
                            //   onTap: () {
                            //     return showModalBottomSheet(
                            //       context: context,
                            //       backgroundColor: Colors.transparent,
                            //       elevation: 0,
                            //       builder: (context) => SingleChildScrollView(
                            //         child: kClubModal(
                            //           context,
                            //           onPressed: () async {
                            //             Navigator.pop(context);
                            //             await _buyMembership();
                            //           },
                            //         ),
                            //       ),
                            //     );
                            //   },
                            //   isPremium: true,
                            //   label: "Club Membership",
                            //   iconPath: kIconMap["Club House"]!,
                            // ),
                            // Divider(
                            //   color: Colors.grey.shade300,
                            // ),
                            _settingButton(
                              onTap: () {
                                navPush(context, const KycUI());
                              },
                              label: "KYC",
                              icon: const Icon(
                                Icons.keyboard_command_key_sharp,
                                size: 23,
                                color: Light.primary,
                              ),
                            ),
                            const Divider(),
                            _settingButton(
                              onTap: () {
                                navPush(context, const ChangePinsUI());
                              },
                              label: "Change PIN",
                              icon: const Icon(
                                Icons.lock_outline,
                                size: 23,
                                color: Light.primary,
                              ),
                            ),
                            const Divider(),
                            _settingButton(
                              onTap: () {
                                navPush(context, const HelpUI());
                              },
                              label: "Help",
                              iconPath: "$kIconPath/info.svg",
                            ),
                            const Divider(),
                            _settingButton(
                              onTap: () async {
                                await launchUrl(
                                  Uri.parse("https://buynearn.shop/privacy"),
                                );
                              },
                              label: "Privacy",
                              iconPath: "$kIconPath/privacy.svg",
                            ),
                            const Divider(),
                            _settingButton(
                              onTap: () {
                                _logout();
                              },
                              label: "Log Out",
                              iconPath: "$kIconPath/log-out.svg",
                            ),
                          ],
                        ),
                      ),
                      height15,
                      const Text("Version $kAppVersion"),
                      const Text(
                        "ImVy Developers©",
                        style: TextStyle(color: Colors.grey),
                      ),
                      kHeight(100),
                    ],
                  ),
                ),
              )
            : const SizedBox(),
      ),
    );
  }

  Widget _settingButton({
    required onTap,
    required String label,
    String iconPath = "",
    Widget? icon,
    bool isPremium = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
            borderRadius: kRadius(5),
            border: Border.all(
                color: isPremium ? Colors.black : Colors.transparent,
                width: .2),
            gradient:
                isPremium ? LinearGradient(colors: kPremiumColors) : null),
        child: Row(
          children: [
            icon ??
                SvgPicture.asset(
                  iconPath,
                  height: 20,
                  colorFilter: kSvgColor(Light.primary),
                ),
            width15,
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
            width10,
            if (!isPremium)
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 15,
              ),
          ],
        ),
      ),
    );
  }
}
