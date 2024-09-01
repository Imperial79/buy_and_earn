import 'package:buy_and_earn/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

const String kIconPath = "assets/icons";
const String kServiceIcon = "assets/icons/Service Icons";

double get kPadding => 12;

SizedBox get height5 => SizedBox(height: 5);
SizedBox get height10 => SizedBox(height: 10);
SizedBox get height15 => SizedBox(height: 15);
SizedBox get height20 => SizedBox(height: 20);
SizedBox get height50 => SizedBox(height: 50);

SizedBox get width5 => SizedBox(width: 5);
SizedBox get width10 => SizedBox(width: 10);
SizedBox get width15 => SizedBox(width: 15);
SizedBox get width20 => SizedBox(width: 20);

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

void KSnackbar(
  BuildContext context, {
  required String content,
  bool? isDanger = false,
  bool showIcon = true,
}) {
  scaffoldMessengerKey.currentState?.clearSnackBars();
  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      backgroundColor:
          isDanger! ? kColor(context).error : kColor(context).primary,
      dismissDirection: DismissDirection.horizontal,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: kRadius(10),
      ),
      padding: EdgeInsets.all(kPadding),
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          showIcon
              ? Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(
                    isDanger ? Icons.dangerous : Icons.download_done_outlined,
                    color: Colors.white,
                  ),
                )
              : SizedBox(),
          Expanded(
            child: Text(
              content,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontFamily: 'Jakarta',
              ),
            ),
          ),
        ],
      ),
    ),
  );
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

kWidgetPill(context, {void Function()? onTap, required Widget child}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: kRadius(100),
      color: kColor(context).tertiaryContainer,
    ),
    child: child,
  );
}
