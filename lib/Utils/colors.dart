import 'package:flutter/material.dart';
import 'commons.dart';

ThemeData kTheme(BuildContext context) => ThemeData(
      useMaterial3: true,
      colorSchemeSeed: kPrimaryColor,
      fontFamily: 'Jakarta',
      scaffoldBackgroundColor: kScaffoldColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          splashFactory: InkSplash.splashFactory,
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          shape: RoundedRectangleBorder(
            borderRadius: kRadius(7),
          ),
          alignment: Alignment.center,
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: 'Jakarta',
            fontSize: 12,
          ),
        ),
      ),
      splashFactory: InkSplash.splashFactory,
      appBarTheme: AppBarTheme(color: kCardColor, elevation: 0),
      cardTheme: CardTheme(
        color: kPrimaryColor,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: kRadius(10),
        ),
      ),
    );

ColorScheme kColor(BuildContext context) => Theme.of(context).colorScheme;

ColorFilter kSvgColor(Color color) => ColorFilter.mode(color, BlendMode.srcIn);

Color kScaffoldColor = Color(0xfff9f9f9);
Color kPrimaryColor = Color(0xff034f89);
Color kPrimaryAccentColor = Color(0xfff9efec);
Color kSecondaryColor = Color(0xfff89900);
Color kCardColor = Colors.white;
Color kCardDarkColor = Color(0xff595c65);
