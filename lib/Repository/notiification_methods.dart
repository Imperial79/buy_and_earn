import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import '../Services/SA-Creds.dart';
import '../Services/notification_config.dart';

final notificationRepository = Provider((ref) => NotificationMethods());
final sendNotificationRepository = Provider((ref) => SendNotification());
final accessTokenProvider = StateProvider<String>((ref) => "");
final fcmTokenProvider = StateProvider<String>((ref) => "");

class NotificationMethods {
  Future<String> generateAccessToken() async {
    // How to generate Oauth 2.0 credentials
    // 1. Go to cloud console -> In the project name
    // 2. Go to Service Account -> Generate a Private Key -> Download the JSON file generated
    // 3. Copy All the credentials from the JSON File and paste in the method below.
    // 4. Install the googleapis_auth package from pub.dev and generate the accessToken everytime sending a new request for notification.

    final credentials =
        auth.ServiceAccountCredentials.fromJson(kServiceAccountCred);

    final client = await auth.clientViaServiceAccount(
      credentials,
      ['https://www.googleapis.com/auth/cloud-platform'],
    );

    return client.credentials.accessToken.data;
  }

  Future<void> generateMyToken(WidgetRef ref) async {
    final fcmMessaging = FirebaseMessaging.instance;
    await fcmMessaging.requestPermission();
    final fcmToken = await fcmMessaging.getToken();
    ref.read(fcmTokenProvider.notifier).update((state) => fcmToken!);
  }
}

class SendNotification {
  Future<void> toUser(
    WidgetRef ref, {
    required String userToken,
    required String title,
    required String messageBody,
    String image = "",
  }) async {
    final body = {
      "message": {
        "token": userToken,
        "notification": {
          "title": title,
          "body": messageBody,
          "image": image,
        },
      }
    };
    String accessToken = ref.read(accessTokenProvider);
    try {
      await Dio().post(
        NotificationConstants.baseUrl,
        options: Options(
          headers: {
            "Content-Type": 'application/json',
            "Authorization": "Bearer $accessToken",
          },
        ),
        data: jsonEncode(body),
      );
    } catch (e) {
      log("Unable to send notification-> $e");
    }
  }

  Future<void> toTopic({String topic = "All"}) async {
    final body = {
      "message": {
        "notification": {
          "title": "Notification Title Topic",
          "body": "Default Topic All",
          "image": "https://source.unsplash.com/random",
        },
        "data": {"key": "https://source.unsplash.com/random"},
        "topic": topic,
      }
    };

    String accessToken = await NotificationMethods().generateAccessToken();
    try {
      await Dio().post(
        NotificationConstants.baseUrl,
        options: Options(
          headers: {
            "Content-Type": 'application/json',
            "Authorization": "Bearer $accessToken",
          },
        ),
        data: jsonEncode(body),
      );
    } catch (e) {
      log("Unable to send notification-> $e");
    }
  }

  Future<String> addToDeviceGroup(
    WidgetRef ref, {
    required List<String> fcmTokensList,
  }) async {
    String accessToken = ref.read(accessTokenProvider);

    final body = {
      "operation": "create",
      "notification_key_name": UniqueKey().toString(),
      "registration_ids": fcmTokensList,
    };
    final headers = {
      "Content-Type": 'application/json',
      "access_token_auth": true,
      "Authorization": "Bearer $accessToken",
      "project_id": "398664121175"
    };
    final res = await Dio().post(
      NotificationConstants.groupBaseUrl,
      options: Options(headers: headers),
      data: jsonEncode(body),
    );
    return res.data['notification_key'];
  }
}
