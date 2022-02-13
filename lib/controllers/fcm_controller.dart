// ignore_for_file: prefer_final_fields, prefer_collection_literals, avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class FCMController extends GetxController {
  static FCMController get to => Get.find();
  FirebaseMessaging _messaging = FirebaseMessaging.instance;
  late final String fcmToken;
  RxMap<String, dynamic> message = Map<String, dynamic>().obs;

  @override
  void onInit() {
    _initNotification();
    _getToken();
    super.onInit();
  }

  Future<String?> _getToken() async {
    try {
      String? token = await _messaging.getToken(
        vapidKey: 'KEY',
      );
      fcmToken = token!;
    } catch (e) {
      print(e);
    }
  }

  Future<void> _initNotification() async {
    // NotificationSettings settings = await _messaging.requestPermission(
    //     sound: true, badge: true, alert: true, provisional: true);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      onMessage:
      _onMessage;
      onLaunch:
      _onLaunch;
      onResume:
      _onResume;
    });

    NotificationSettings _settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  Future<void>? _onResume(Map<String, dynamic> message) {
    print("_onResume : $message");
    return null;
  }

  Future<void>? _onLaunch(Map<String, dynamic> message) {
    print("_onLaunch : $message");
    _actionOnNotification(message);
    return null;
  }

  void _actionOnNotification(Map<String, dynamic> messageMap) {
    message(messageMap);
  }

  Future<void>? _onMessage(Map<String, dynamic> message) {
    print("_onMessage : $message");
    return null;
  }
}
