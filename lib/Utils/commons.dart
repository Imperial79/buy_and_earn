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

// Route _createRoute(Widget page) {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => page,
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(1.0, 0.0);
//       const end = Offset.zero;
//       const curve = Curves.easeInOut;

//       final tween = Tween(begin: begin, end: end);
//       final curvedAnimation = CurvedAnimation(
//         parent: animation,
//         curve: curve,
//       );

//       return FadeTransition(
//         opacity: curvedAnimation,
//         child: SlideTransition(
//           position: tween.animate(curvedAnimation),
//           child: child,
//         ),
//       );
//     },
//   );
// }

BorderRadius kRadius(double radius) => BorderRadius.circular(radius);

Future<T?> navPush<T extends Object?>(BuildContext context, Widget screen) {
  return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ));
}

Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
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
}) {
  scaffoldMessengerKey.currentState?.clearSnackBars();
  scaffoldMessengerKey.currentState?.showSnackBar(
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
      padding: EdgeInsets.all(12),
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          Icon(
            isDanger ? Icons.dangerous : Icons.download_done_outlined,
            color: isDanger
                ? kColor(context).onErrorContainer
                : kColor(context).onPrimaryContainer,
          ),
          width10,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isDanger ? "Oops!" : "Success!",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: isDanger
                        ? kColor(context).onErrorContainer
                        : kColor(context).onPrimaryContainer,
                    fontFamily: 'Jakarta',
                  ),
                ),
                Text(
                  content,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: isDanger
                        ? kColor(context).onErrorContainer
                        : kColor(context).onPrimaryContainer,
                    fontFamily: 'Jakarta',
                  ),
                ),
              ],
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
