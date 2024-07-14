import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

const String kIconPath = "assets/icons";
const String kServiceIcon = "assets/icons/Service Icons";

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

Route _createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      final tween = Tween(begin: begin, end: end);
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: curve,
      );

      return FadeTransition(
        opacity: curvedAnimation,
        child: SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        ),
      );
    },
  );
}

BorderRadius kRadius(double radius) => BorderRadius.circular(radius);

Future<void> navPush(BuildContext context, Widget screen) {
  return Navigator.push(context, _createRoute(screen));
}

Future<void> navPushReplacement(BuildContext context, Widget screen) {
  return Navigator.pushReplacement(context, _createRoute(screen));
}

Future<void> navPopUntilPush(BuildContext context, Widget screen) {
  Navigator.popUntil(context, (route) => false);
  return navPush(context, screen);
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
}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: isDanger!
          ? kColor(context).errorContainer
          : kColor(context).primaryContainer,
      dismissDirection: DismissDirection.vertical,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: kRadius(10),
        side: BorderSide(
          color: isDanger
              ? kColor(context).onErrorContainer
              : kColor(context).onPrimaryContainer,
        ),
      ),
      content: Text(
        content,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: isDanger
              ? kColor(context).onErrorContainer
              : kColor(context).onPrimaryContainer,
          fontFamily: 'Jakarta',
        ),
      ),
    ),
  );
}
