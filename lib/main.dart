import 'package:buy_and_earn/Screens/RootUI.dart';
import 'package:buy_and_earn/Utils/colors.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    kSystemColors();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: kTheme(context),
      title: "Buy & Earn",
      home: RootUI(),
    );
  }
}
