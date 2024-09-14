// ignore_for_file: non_constant_identifier_names
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';

class NotificationConstants {
  static const String baseUrl =
      "https://fcm.googleapis.com/v1/projects/my-postmates-a0834/messages:send";
  static const String groupBaseUrl =
      "https://fcm.googleapis.com/fcm/notification";

  static String myToken = "";
}

class FirebaseNotification {
  final fcmMessaging = FirebaseMessaging.instance;

  final androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: "This channel is used for important notifications only",
    importance: Importance.high,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future initLocalNotifications() async {
    const ios = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_stat_bne');
    const setting = InitializationSettings(android: android, iOS: ios);

    await _localNotifications.initialize(
      setting,
      onDidReceiveNotificationResponse: (details) {
        final message = RemoteMessage.fromMap(jsonDecode(details.payload!));
        handleMessage(message);
      },
    );
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await platform?.createNotificationChannel(androidChannel);
  }

  Future initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    fcmMessaging.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) async {
      final notification = message.notification;
      if (notification == null) return;
      String _image = notification.android!.imageUrl == null
          ? ""
          : notification.android!.imageUrl.toString();
      String _bigPicture = "";

      if (_image.isNotEmpty) {
        _bigPicture = await urlToAndroidBitmap(_image, 'bigPicture');
      }
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            androidChannel.id,
            androidChannel.name,
            channelDescription: androidChannel.description,
            icon: '@drawable/ic_stat_bne',
            styleInformation: _bigPicture.isNotEmpty
                ? BigPictureStyleInformation(
                    FilePathAndroidBitmap(_bigPicture),
                  )
                : null,
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }

  Future<String> urlToAndroidBitmap(String url, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    final response = await http.get(Uri.parse(url));
    final file = File(filePath);

    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  Future<void> init() async {
    await fcmMessaging.requestPermission();

    fcmMessaging.subscribeToTopic("All").then((_) => log("Subscribed to All"));
    fcmMessaging
        .subscribeToTopic("Customers")
        .then((_) => log("Subscribed to Customers"));

    initPushNotification();
    initLocalNotifications();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
  }
}

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  // if (message.notification != null) {
  // print("Title-> ${message.notification?.title}");
  // print("body-> ${message.notification?.body}");
  // print("payload-> ${message.data}");
}
