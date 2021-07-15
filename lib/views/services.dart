import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:final_app/views/push_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:overlay_support/overlay_support.dart';

import 'notificationbadge.dart';

class Services {
  FirebaseMessaging _messaging;
  static Future<void> sendNotification(receiver, String msg) async {
    var postUrl = "https://fcm.googleapis.com/fcm/send";
    var token = await getToken(receiver);
    print('token : $token');

    final data = {
      "notification": {"body": msg, "title": "Portfol.io"},
      "priority": "high",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": "1",
        "status": "done"
      },
      "to": "$token"
    };
    final key =
        "AAAA5OJ1mwQ:APA91bFlfnrQ-ipFDRE7nhHJT-pnopeD5JCYF7xMkm6ZeISfGWmHvoo2X2DHELi-KQ9s7rOwJYizcqfm0SKPYwC-IDXG_tEe0syixhBaOBySM7vVAFt1gCGf2GSTABvICR_lApP1LEjJ";

    final headers = {
      'content-type': 'application/json',
      'Authorization': 'key=${key}'
    };

    BaseOptions options = new BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: headers,
    );

    try {
      final response = await Dio(options).post(postUrl, data: data);

      if (response.statusCode == 200) {
        debugPrint(response.toString());
        Fluttertoast.showToast(msg: 'Request Sent To Driver');
      } else {
        print('notification sending failed');
        // on failure do sth
      }
    } catch (e) {
      print('exception $e');
    }
  }

  static Future<String> getToken(userId) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;

    var token;
    await _db.collection('users').doc(userId).get().then((snapshot) {
      token = snapshot.data()['fcmtoken'];
    });

    return token;
  }

  Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
  }

  void configureNotifs() async {
    // 1. Initialize the Firebase app
    // await Firebase.initializeApp();
    // we dont need this
    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    PushNotification _notificationInfo;

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // Parse the message received
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
        );

        if (_notificationInfo != null) {
          // For displaying the notification as an overlay
          showSimpleNotification(
            Text(_notificationInfo.title),
            subtitle: Text(_notificationInfo.body),
            background: Colors.cyan.shade700,
            duration: Duration(seconds: 2),
          );
        }
      });
    } else {
      print('User declined or has not accepted permission');
    }

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification _notificationInfo;
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
      );
    });

    // For handling notification when the app is in terminated state

    RemoteMessage initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
      );
    }
  }
}
