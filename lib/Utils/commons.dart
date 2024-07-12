import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

BorderRadius kRadius(double radius) => BorderRadius.circular(radius);

Future<void> navPush(BuildContext context, Widget screen) {
  return Navigator.push(
      context, MaterialPageRoute(builder: (context) => screen));
}

Future<void> navPushReplacement(BuildContext context, Widget screen) {
  return Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => screen));
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
