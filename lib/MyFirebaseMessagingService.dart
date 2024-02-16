import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyFirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  
  Future<void> initialize() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Received a new FCM message: ${message.notification?.body}");
      var ban = message.notification?.body;
      Fluttertoast.showToast(
        msg: ban ?? '',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 50,
        backgroundColor: Color.fromARGB(255, 255, 0, 0),
        textColor: Color.fromARGB(255, 255, 255, 255),
        fontSize: 24,
      );
    });
  }
}