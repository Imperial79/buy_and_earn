import 'dart:developer';

import 'package:buy_and_earn/Repository/auth_repository.dart';
import 'package:buy_and_earn/Repository/internet_repository.dart';
import 'package:buy_and_earn/Screens/Auth/RegisterUI.dart';
import 'package:buy_and_earn/Screens/Auth/SplashUI.dart';
import 'package:buy_and_earn/Screens/RootUI.dart';
import 'package:buy_and_earn/Utils/colors.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    _auth();
  }

  _auth() async {
    await ref.read(auth);
  }

  @override
  Widget build(BuildContext context) {
    kSystemColors();
    final user = ref.watch(userProvider);
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      theme: kTheme(context),
      title: "Buy & Earn",
      home: ref.watch(auth).isLoading
          ? SplashUI()
          : user != null
              ? RootUI()
              : RegisterUI(),
    );
  }
}
