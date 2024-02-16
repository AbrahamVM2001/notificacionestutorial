import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notificacionestutorial/firebase_options.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'MyFirebaseMessagingService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialization successful');

    final notificationSettings = await FirebaseMessaging.instance.requestPermission(
      provisional: true,
    );

    if (notificationSettings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted notification permissions');
    } else {
      print('User declined or restricted notification permissions');
    }
    MyFirebaseMessagingService().initialize();
    FirebaseMessaging.instance.getToken().then((token) {
      print('=================================================');
      print('Firebase Cloud Messaging token: $token');
      print('=================================================');
    });

    runApp(MyApp());
  } catch (e) {
    print("Firebase initialization error: $e");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: "https://flutter.dev/",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}