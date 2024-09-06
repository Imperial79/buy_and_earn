import 'dart:developer';

import 'package:animations/animations.dart';
import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Repository/clubHouse_repository.dart';
import 'package:buy_and_earn/Screens/Auth/TPin_UI.dart';
import 'package:buy_and_earn/Screens/Home/HomeUI.dart';
import 'package:buy_and_earn/Screens/More/MoreUI.dart';
import 'package:buy_and_earn/Screens/Refer/ReferUI.dart';
import 'package:buy_and_earn/Screens/Transactions/TransactionsUI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/colors.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:upgrader/upgrader.dart';

final navigationProvider = StateProvider<int>((ref) => 0);

class RootUI extends ConsumerStatefulWidget {
  const RootUI({super.key});

  @override
  ConsumerState<RootUI> createState() => _RootUIState();
}

class _RootUIState extends ConsumerState<RootUI> {
  bool isLoading = false;
  final _screens = [
    HomeUI(),
    ReferUI(),
    TransactionsUI(),
    MoreUI(),
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _showMembershipDialog();
      },
    );
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

        log("$res");
      }
    } catch (e) {
      KSnackbar(context, content: "Something went wrong!", isDanger: true);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  _showMembershipDialog() {
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
  }

  @override
  Widget build(BuildContext context) {
    final activeIndex = ref.watch(navigationProvider);

    return UpgradeAlert(
      showIgnore: false,
      showLater: false,
      shouldPopScope: () => false,
      child: KScaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageTransitionSwitcher(
              transitionBuilder: (child, animation, secondaryAnimation) {
                return FadeThroughTransition(
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  fillColor: Theme.of(context).colorScheme.surface,
                  child: child,
                );
              },
              child: _screens[activeIndex],
            ),
            _bottomBar(),
          ],
        ),
      ),
    );
  }

  SafeArea _bottomBar() {
    return SafeArea(
      top: false,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: kCardColor,
          borderRadius: kRadius(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.03),
              blurRadius: 20,
              spreadRadius: 10,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _navigationButton(
              0,
              label: "home",
              iconPath: "$kIconPath/home.svg",
              selectedIconPath: "$kIconPath/home-filled.svg",
            ),
            _navigationButton(
              1,
              label: "refer",
              iconPath: "$kIconPath/refer.svg",
              selectedIconPath: "$kIconPath/refer-filled.svg",
            ),
            _navigationButton(
              2,
              label: "transactions",
              iconPath: "$kIconPath/transactions.svg",
              selectedIconPath: "$kIconPath/transactions-filled.svg",
            ),
            _navigationButton(
              3,
              label: "more",
              iconPath: "$kIconPath/more.svg",
              selectedIconPath: "$kIconPath/more-filled.svg",
            ),
          ],
        ),
      ),
    );
  }

  Widget _navigationButton(
    int index, {
    required String label,
    required String iconPath,
    required String selectedIconPath,
  }) {
    return Consumer(builder: (context, ref, _) {
      final activeIndex = ref.watch(navigationProvider);
      bool isActive = activeIndex == index;

      return IconButton(
        onPressed: () {
          ref.read(navigationProvider.notifier).state = index;
        },
        visualDensity: VisualDensity(horizontal: 2, vertical: 2),
        icon: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              isActive ? selectedIconPath : iconPath,
              height: 20,
              colorFilter: kSvgColor(isActive ? kSecondaryColor : Colors.grey),
            ),
            Flexible(
              child: AnimatedSize(
                duration: Duration(milliseconds: 200),
                alignment: Alignment.centerLeft,
                child: isActive
                    ? Container(
                        margin: EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(color: kSecondaryColor, width: 2),
                          ),
                        ),
                        child: Text(
                          label,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: kSecondaryColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      )
                    : Container(
                        child: Text(""),
                      ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
