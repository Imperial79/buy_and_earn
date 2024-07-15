import 'package:flutter/material.dart';
import 'commons.dart';

/// Custom Light Theme
ThemeData kTheme(BuildContext context) => ThemeData(
      useMaterial3: true,
      secondaryHeaderColor: kSecondaryColor,
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
      appBarTheme:
          AppBarTheme(color: Colors.white.withOpacity(0), elevation: 0),
      cardTheme: CardTheme(
        color: kPrimaryColor,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: kRadius(10),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: kTextbuttonColor,
          padding: EdgeInsets.symmetric(horizontal: 5),
          visualDensity: VisualDensity(horizontal: -2, vertical: -2),
          textStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.blue.shade800,
          ),
        ),
      ),
    );

/// Colors according to the primary color seed
ColorScheme kColor(BuildContext context) => Theme.of(context).colorScheme;

/// For setting SVG icon Color
ColorFilter kSvgColor(Color color) => ColorFilter.mode(color, BlendMode.srcIn);

Color kScaffoldColor = Color(0xfff9f9f9);
Color kPrimaryColor = Color(0xff034f89);
Color kPrimaryAccentColor = Color.fromARGB(255, 203, 221, 235);
Color kSecondaryColor = Color(0xfff89900);
Color kCardColor = Colors.white;
Color kCardDarkColor = Color(0xff595c65);
Color kTextbuttonColor = Colors.blue.shade800;
