import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

final _firebaseMessageing = FirebaseMessaging.instance;
@pragma('vm:entry-point')
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  debugPrint("title: ${message.notification?.title ?? ""}");
  debugPrint("Body: ${message.notification?.body ?? ""}");
  debugPrint("Payload: ${message.data}");
}

Future<void> initNotifications() async {
  await _firebaseMessageing.requestPermission();
  final fCMToken = await _firebaseMessageing.getToken();
  debugPrint("TokenFCM: $fCMToken");
  FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  // FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //   "Event: $event".log();
  //   "title:".log();
  // });
}
