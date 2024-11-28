import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Screens/RootUI.dart';
import 'package:buy_and_earn/Utils/colors.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_shadow/simple_shadow.dart';

class KNavigationBar extends ConsumerWidget {
  const KNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      top: false,
      child: SimpleShadow(
        opacity: .1,
        sigma: 20,
        child: kCard(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(15),
          color: Light.card,
          borderWidth: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              navBtn(
                0,
                label: "home",
                iconPath: "$kIconPath/home.svg",
                selectedIconPath: "$kIconPath/home-filled.svg",
              ),
              navBtn(
                1,
                label: "refer",
                iconPath: "$kIconPath/refer.svg",
                selectedIconPath: "$kIconPath/refer-filled.svg",
              ),
              navBtn(
                2,
                label: "transactions",
                iconPath: "$kIconPath/transactions.svg",
                selectedIconPath: "$kIconPath/transactions-filled.svg",
              ),
              navBtn(
                3,
                label: "more",
                iconPath: "$kIconPath/more.svg",
                selectedIconPath: "$kIconPath/more-filled.svg",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget navBtn(
    int index, {
    required String label,
    required String iconPath,
    required String selectedIconPath,
  }) {
    return Consumer(
      builder: (context, ref, _) {
        final activeIndex = ref.watch(navigationProvider);
        bool isActive = activeIndex == index;

        return AnimatedScale(
          duration: const Duration(milliseconds: 300),
          scale: isActive ? 1.1 : 1,
          child: IconButton(
            onPressed: () {
              ref.read(navigationProvider.notifier).state = index;
            },
            visualDensity: const VisualDensity(horizontal: 2, vertical: 2),
            icon: AnimatedScale(
              duration: const Duration(milliseconds: 200),
              scale: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    isActive ? selectedIconPath : iconPath,
                    height: 20,
                    colorFilter:
                        kSvgColor(isActive ? Light.secondary : Colors.grey),
                  ),
                  kHeight(1),
                  Text(
                    label,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isActive ? Light.secondary : Colors.grey,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
