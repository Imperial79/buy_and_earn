import 'package:buy_and_earn/Screens/RootUI.dart';
import 'package:buy_and_earn/Utils/colors.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class Kbottomnavbar extends ConsumerWidget {
  const Kbottomnavbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Light.card,
          borderRadius: kRadius(12),
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
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
    );
  }

  Widget navBtn(
    int index, {
    required String label,
    required String iconPath,
    required String selectedIconPath,
  }) {
    return Consumer(builder: (context, ref, _) {
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
          icon: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                isActive ? selectedIconPath : iconPath,
                height: 20,
                colorFilter:
                    kSvgColor(isActive ? Light.secondary : Colors.grey),
              ),
              Flexible(
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  alignment: Alignment.centerLeft,
                  child: isActive
                      ? Container(
                          margin: const EdgeInsets.only(left: 5),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(color: Light.secondary, width: 2),
                            ),
                          ),
                          child: Text(
                            label,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Light.secondary,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        )
                      : const Text(""),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
