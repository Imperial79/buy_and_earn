import 'package:buy_and_earn/Repository/auth_repository.dart';
import 'package:buy_and_earn/Screens/Auth/RegisterUI.dart';
import 'package:buy_and_earn/Screens/RootUI.dart';
import 'package:buy_and_earn/Utils/colors.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:buy_and_earn/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Repository/notiification_methods.dart';
import 'Services/notification_config.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  await FirebaseNotification().init();
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
    _generateFCM();
  }

  _auth() async {
    await ref.read(auth);
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

    final user = ref.watch(userProvider);
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      theme: kTheme(context),
      title: "Buy & Earn",
      home: ref.watch(auth).isLoading
          ? null
          : user != null
              ? RootUI()
              : RegisterUI(),
    );
  }
}
