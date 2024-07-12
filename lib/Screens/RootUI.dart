import 'package:animations/animations.dart';
import 'package:buy_and_earn/Screens/Home/HomeUI.dart';
import 'package:buy_and_earn/Screens/More/MoreUI.dart';
import 'package:buy_and_earn/Utils/colors.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

final navigationProvider = StateProvider<int>((ref) => 0);

class RootUI extends ConsumerStatefulWidget {
  const RootUI({super.key});

  @override
  ConsumerState<RootUI> createState() => _RootUIState();
}

class _RootUIState extends ConsumerState<RootUI> {
  final _screens = [
    HomeUI(),
    HomeUI(),
    HomeUI(),
    MoreUI(),
  ];

  @override
  Widget build(BuildContext context) {
    final activeIndex = ref.watch(navigationProvider);
    return Scaffold(
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
    );
  }

  SafeArea _bottomBar() {
    return SafeArea(
      top: false,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: kCardColor,
          borderRadius: kRadius(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100.withOpacity(.5),
              blurRadius: 10,
              spreadRadius: 20,
            ),
          ],
        ),
        child: Row(
          children: [
            _navigationButton(
              0,
              label: "home",
              iconPath: "$kIconPath/home.svg",
              selectedIconPath: "$kIconPath/home-filled.svg",
            ),
            _navigationButton(
              1,
              label: "home",
              iconPath: "$kIconPath/home.svg",
              selectedIconPath: "$kIconPath/home-filled.svg",
            ),
            _navigationButton(
              2,
              label: "home",
              iconPath: "$kIconPath/home.svg",
              selectedIconPath: "$kIconPath/home-filled.svg",
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
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Consumer(builder: (context, ref, _) {
        final activeIndex = ref.watch(navigationProvider);
        bool isActive = activeIndex == index;

        return IconButton(
          onPressed: () {
            ref.read(navigationProvider.notifier).state = index;
          },
          icon: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                isActive ? selectedIconPath : iconPath,
                height: 20,
                colorFilter:
                    kSvgColor(isActive ? kSecondaryColor : Colors.grey),
              ),
              AnimatedSize(
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
                        ),
                      )
                    : Container(
                        child: Text(""),
                      ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
