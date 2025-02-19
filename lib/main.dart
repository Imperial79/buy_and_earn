import 'package:buy_and_earn/Repository/auth_repository.dart';
import 'package:buy_and_earn/Screens/Auth/WelcomeUI.dart';
import 'package:buy_and_earn/Screens/RootUI.dart';
import 'package:buy_and_earn/Utils/colors.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:buy_and_earn/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upgrader/upgrader.dart';
import 'Repository/notification_methods.dart';
import 'Screens/Auth/SplashUI.dart';
import 'Services/notification_config.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  await FirebaseNotification().init();
  runApp(const ProviderScope(child: MyApp()));
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
    _generateFCM();
  }

  _auth() async {
    ref.read(auth);
  }

  _generateFCM() async {
    ref.read(notificationRepository).generateMyToken(ref);
    final accessToken =
        await ref.read(notificationRepository).generateAccessToken();
    ref.read(accessTokenProvider.notifier).update((state) => accessToken);
  }

  @override
  Widget build(BuildContext context) {
    kSystemColors();

    final customer = ref.watch(customerProvider);
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      theme: kTheme(context),
      title: "Buy & Earn",
      home: UpgradeAlert(
        child: ref.watch(auth).isLoading
            ? const SplashUI()
            : customer != null
                ? const RootUI()
                : const WelcomeUI(),
      ),
    );
  }
}
