import 'package:flutter/material.dart';

import 'package:buy_and_earn/Utils/commons.dart';

import '../../Utils/colors.dart';

class ReminderCard extends StatelessWidget {
  final bool visible;
  final void Function()? onTap;
  final String title;

  final Widget? content;
  final Color? cardColor;
  final Color? iconColor;
  final IconData? icon;
  const ReminderCard({
    Key? key,
    this.visible = false,
    this.onTap,
    required this.title,
    this.content,
    this.cardColor,
    this.iconColor,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          shape: RoundedRectangleBorder(
            borderRadius: kRadius(10),
          ),
          color: cardColor ?? kColor(context).secondaryContainer,
          child: Padding(
            padding: EdgeInsets.all(kPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: iconColor,
                      child: Icon(
                        icon ?? Icons.warning,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                    ),
                  ],
                ),
                height15,
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
