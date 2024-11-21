import 'package:flutter/material.dart';
import 'commons.dart';

/// Custom Light Theme
ThemeData kTheme(BuildContext context) => ThemeData(
      useMaterial3: true,
      secondaryHeaderColor: Light.secondary,
      colorSchemeSeed: Light.primary,
      fontFamily: 'Jakarta',
      scaffoldBackgroundColor: Light.scaffold,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          splashFactory: InkSplash.splashFactory,
          backgroundColor: Light.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          shape: RoundedRectangleBorder(
            borderRadius: kRadius(5),
          ),
          alignment: Alignment.center,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: 'Jakarta',
            fontSize: 12,
          ),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: Colors.grey.shade300,
      ),
      splashFactory: InkSplash.splashFactory,
      appBarTheme:
          AppBarTheme(color: Colors.white.withOpacity(0), elevation: 0),
      cardTheme: CardTheme(
        color: Light.primary,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: kRadius(10),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Light.link,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          visualDensity: const VisualDensity(horizontal: -2, vertical: -2),
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

List<Color> kPremiumColors = [
  const Color.fromARGB(255, 255, 220, 232),
  const Color.fromARGB(255, 220, 255, 240),
  const Color.fromARGB(255, 247, 255, 220),
];

// Light Theme Colors
class Light {
  static const scaffold = Color(0xfff9f9f9);
  static const primary = Color(0xff16325B);
  static const primaryAccent = Color(0xFFCBDDEB);
  static const secondary = Color(0xFF227B94);
  static const tertiary = Color(0xff78B7D0);
  static const quarternary = Color(0xffFFDC7F);
  static const card = Colors.white;
  static const border = Color(0xFFE0E0E0);
  static const link = Color(0xFF1565C0);
}

// Text Colors for Different States
class StatusTextColor {
  static const neutral = Color(0xFF1976D2);
  static const pending = Color(0xFFD18400);
  static const success = Color(0xFF0A8812);
  static const danger = Color(0xFFA72A0B);
}

// Card Colors for Different States
class StatusCardColor {
  // static const neutral = Color(0xFFB6DBFF);
  // static const pending = Color(0xFFFFECB3);
  // static const success = Color(0xFFD2FFD5);
  // static const danger = Color(0xFFFFD9CF);
  // static const completed = Color(0xFFD2FFD5);
  static const neutral = Color(0xFF1976D2);
  static const pending = Color(0xFFD18400);
  static const success = Color(0xFF0A8812);
  static const danger = Color(0xFFA72A0B);
}

// Card Colors for Different States
class StatusIcon {
  static const pending = Icons.schedule;
  static const danger = Icons.dangerous;
  static const success = Icons.done;
  static const outgoing = Icons.arrow_outward_rounded;
}

// Map for Text Color by Status
final Map<String, Color> kColorMapText = {
  'Initiated': StatusTextColor.neutral,
  'Refund': StatusTextColor.neutral,
  'Pending': StatusTextColor.pending,
  'Processing': StatusTextColor.pending,
  'In Transit': StatusTextColor.pending,
  'Verified': StatusTextColor.success,
  'Accepted': StatusTextColor.success,
  'Success': StatusTextColor.success,
  'Online': StatusTextColor.success,
  'Out for delivery': StatusTextColor.success,
  'Delivered': StatusTextColor.success,
  'Rejected': StatusTextColor.danger,
  'Cancelled': StatusTextColor.danger,
  'Failed': StatusTextColor.danger,
};

Map kColorMap = {
  'Pending': StatusCardColor.pending,
  'Verified': StatusCardColor.success,
  'Offline': StatusCardColor.danger,
  'Cancelled': StatusCardColor.danger,
  'Failed': StatusCardColor.danger,
  'Online': StatusCardColor.success,
  "Refund": StatusCardColor.neutral,
  "Success": StatusCardColor.success,
};

Map kStatusIconMap = {
  "Rejected": StatusIcon.danger,
  "Processing": StatusIcon.pending,
  "Pending": StatusIcon.pending,
  "Verified": StatusIcon.success,
  "Success": StatusIcon.success,
  "Refund": StatusIcon.outgoing,
};
