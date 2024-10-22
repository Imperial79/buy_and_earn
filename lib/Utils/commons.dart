import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

const String kIconPath = "assets/icons";
const String kServiceIcon = "assets/icons/Service Icons";

double get kPadding => 12;

SizedBox get height5 => const SizedBox(height: 5);
SizedBox get height10 => const SizedBox(height: 10);
SizedBox get height15 => const SizedBox(height: 15);
SizedBox get height20 => const SizedBox(height: 20);
SizedBox get height50 => const SizedBox(height: 50);

SizedBox get width5 => const SizedBox(width: 5);
SizedBox get width10 => const SizedBox(width: 10);
SizedBox get width15 => const SizedBox(width: 15);
SizedBox get width20 => const SizedBox(width: 20);

SizedBox kHeight(double height) => SizedBox(
      height: height,
    );

BorderRadius kRadius(double radius) => BorderRadius.circular(radius);

Future<T?> navPush<T extends Object?>(BuildContext context, Widget screen) {
  return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ));
}

Future<T?> navPushReplacement<T extends Object?, TO extends Object?>(
    BuildContext context, Widget screen) {
  return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ));
}

Future<T?> navPopUntilPush<T extends Object?>(
    BuildContext context, Widget screen) async {
  Navigator.popUntil(context, (route) => false);
  return await navPush(context, screen);
}

kSystemColors() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top]);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
}

void kErrorSnack(context) {
  KSnackbar(context, content: "Something went wrong!", isDanger: true);
}

void KSnackbar(
  BuildContext context, {
  required String content,
  bool isDanger = false,
  bool showIcon = true,
  SnackBarAction? action,
}) {
  DelightToastBar.removeAll();
  DelightToastBar(
    position: DelightSnackbarPosition.top,
    autoDismiss: true,
    snackbarDuration: const Duration(seconds: 3),
    builder: (context) => ToastCard(
      shadowColor: Colors.transparent,
      color: isDanger ? Colors.red.shade700 : kSecondaryColor,
      leading: Icon(
        isDanger ? Icons.dangerous : Icons.verified,
        size: 28,
        color: Colors.white,
      ),
      title: Text(
        content,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          color: Colors.white,
        ),
      ),
    ),
  ).show(context);
}

kPill({void Function()? onTap, required String label}) {
  return GestureDetector(
    onTap: onTap,
    child: Chip(
      shape: RoundedRectangleBorder(
        borderRadius: kRadius(100),
        side: BorderSide(
          color: Colors.grey.shade300,
        ),
      ),
      visualDensity: VisualDensity.compact,
      label: Text(label),
    ),
  );
}

kWidgetPill(
  context, {
  void Function()? onTap,
  required Widget child,
  EdgeInsetsGeometry? padding,
  Color? backgroundColor,
}) {
  return Container(
    padding: padding,
    decoration: BoxDecoration(
      borderRadius: kRadius(100),
      color: backgroundColor ?? kColor(context).tertiaryContainer,
    ),
    child: child,
  );
}
