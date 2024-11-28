import 'package:buy_and_earn/Components/widgets.dart';
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
        child: kCard(
          borderWidth: 0,
          width: double.maxFinite,
          radius: 10,
          margin: const EdgeInsets.symmetric(horizontal: kPadding),
          color: cardColor ?? kColor(context).secondaryContainer,
          child: Row(
            children: [
              Icon(
                icon ?? Icons.info,
                color: iconColor,
                size: 20,
              ),
              width10,
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
