import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'local_notifications_service.dart';

class NotificationService  {

  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future init () async {
    await messaging.requestPermission();
    String? token = await messaging.getToken();
    print("token is $token");
    FirebaseMessaging.onBackgroundMessage(handelbackgroundMessage);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      LocalNotificationService.showBasicNotification(
          '⚠️⚠️${message.notification!.title}⚠️⚠️',
        message.notification!.body
      );
    });
  }

  static Future<void> handelbackgroundMessage (RemoteMessage message) async {
    await Firebase.initializeApp();
    message.notification!.title;
  }

}
