// ignore_for_file: unused_result

import 'package:buy_and_earn/Components/constants.dart';
import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Repository/auth_repository.dart';
import 'package:buy_and_earn/Repository/wallet_repository.dart';
import 'package:buy_and_earn/Screens/Auth/RegisterUI.dart';
import 'package:buy_and_earn/Screens/More/ChangePinsUI.dart';
import 'package:buy_and_earn/Screens/More/HelpUI.dart';
import 'package:buy_and_earn/Screens/More/KycUI.dart';
import 'package:buy_and_earn/Screens/RootUI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/colors.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
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
  XFile? _image;

  Future<XFile?> _pickImage({required ImageSource source}) async {
    return await ImagePicker().pickImage(
      source: source,
      imageQuality: 50,
    );
  }

  Future<void> _updateDp() async {
    try {
      setState(() {
        isLoading = true;
      });
      final res = await ref.read(authRepository).updateDp(_image!);
      if (!res.error) {
        ref.refresh(auth.future);
      }
      KSnackbar(context, content: res.message, isDanger: res.error);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  _logout() async {
    setState(() => isLoading = true);
    final res = await ref.read(authRepository).logout({});
    if (!res.error) {
      navPopUntilPush(context, RegisterUI()).then(
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
      Map? data = await navPush(context, TPin_UI()) as Map?;

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
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kWalletCard(context),
                      height15,
                      kCard(
                        isPremium: customer.isMember,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  elevation: 0,
                                  backgroundColor: Colors.white,
                                  builder: (context) => SingleChildScrollView(
                                    padding: EdgeInsets.all(20),
                                    child: SizedBox(
                                      width: double.maxFinite,
                                      child: SafeArea(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Update Profile Image",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            height20,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Flexible(
                                                  child: IconButton(
                                                    onPressed: () async {
                                                      _image = await _pickImage(
                                                          source: ImageSource
                                                              .camera);
                                                      if (_image != null) {
                                                        Navigator.pop(context);
                                                      }
                                                      setState(() {});
                                                      _updateDp();
                                                    },
                                                    icon: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Icon(
                                                          Icons.camera_alt,
                                                          color: kPrimaryColor,
                                                        ),
                                                        height20,
                                                        Text(
                                                          "Camera",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                  child: IconButton(
                                                    onPressed: () async {
                                                      _image = await _pickImage(
                                                          source: ImageSource
                                                              .gallery);
                                                      if (_image != null) {
                                                        Navigator.pop(context);
                                                        _updateDp();
                                                      }
                                                      setState(() {});
                                                    },
                                                    icon: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Icon(
                                                          Icons.photo_sharp,
                                                          color: kPrimaryColor,
                                                        ),
                                                        height20,
                                                        Text(
                                                          "Gallery",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: customer.dp != null
                                  ? CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                          NetworkImage(customer.dp!),
                                    )
                                  : CircleAvatar(
                                      radius: 30,
                                      child: Text("${customer.name[0]}"),
                                    ),
                            ),
                            width10,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "${customer.name}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      width10,
                                      kWidgetPill(
                                        context,
                                        backgroundColor:
                                            Colors.amberAccent.shade100,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 2),
                                        child: Row(
                                          children: [
                                            if (customer.isMember)
                                              Text(
                                                "Member | ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            Text(
                                              "Lvl. ${customer.level}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),

                                  height5,
                                  Text("+91 ${customer.phone}"),
                                  Text("${customer.email}"),
                                  // height5,
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
                      height5,
                      kCard(
                        cardColor: customer.status == "Pending"
                            ? Colors.amber.shade100
                            : Colors.lightGreen.shade100,
                        width: double.maxFinite,
                        child: Row(
                          children: [
                            Icon(
                              customer.status == "Pending"
                                  ? Icons.do_disturb_outlined
                                  : Icons.done,
                              size: 20,
                            ),
                            width10,
                            Text(customer.status == "Pending"
                                ? "ID Not Activated"
                                : "ID Activated"),
                          ],
                        ),
                      ),
                      height15,
                      kCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            kLabel("Refer Code", top: 0),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${customer.referCode}",
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
                                        text: "${customer.referCode}"));
                                    KSnackbar(context,
                                        content:
                                            "Refer Code copied to clipboard",
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
                                navPush(context, KycUI());
                              },
                              label: "KYC",
                              icon: Icon(
                                Icons.keyboard_command_key_sharp,
                                size: 23,
                                color: kPrimaryColor,
                              ),
                            ),
                            Divider(),
                            _settingButton(
                              onTap: () {
                                navPush(context, ChangePinsUI());
                              },
                              label: "Change PIN",
                              icon: Icon(
                                Icons.lock_outline,
                                size: 23,
                                color: kPrimaryColor,
                              ),
                            ),
                            Divider(),
                            _settingButton(
                              onTap: () {
                                navPush(context, HelpUI());
                              },
                              label: "Help",
                              iconPath: "$kIconPath/info.svg",
                            ),
                            Divider(),
                            _settingButton(
                              onTap: () async {
                                await launchUrl(
                                  Uri.parse("https://buynearn.shop/privacy"),
                                );
                              },
                              label: "Privacy",
                              iconPath: "$kIconPath/privacy.svg",
                            ),
                            Divider(),
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
                      Text("Version $kAppVersion"),
                      Text(
                        "ImVy Developers©",
                        style: TextStyle(color: Colors.grey),
                      ),
                      kHeight(100),
                    ],
                  ),
                ),
              )
            : SizedBox(),
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
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
            borderRadius: kRadius(5),
            border: Border.all(
                color: isPremium ? Colors.black : Colors.transparent,
                width: .2),
            gradient:
                isPremium ? LinearGradient(colors: kPremiumColors) : null),
        child: Row(
          children: [
            icon == null
                ? SvgPicture.asset(
                    iconPath,
                    height: 20,
                    colorFilter: kSvgColor(kPrimaryColor),
                  )
                : icon,
            width15,
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
            width10,
            if (!isPremium)
              Icon(
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
