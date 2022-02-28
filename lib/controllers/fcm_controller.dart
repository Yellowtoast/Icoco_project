// ignore_for_file: prefer_final_fields, prefer_collection_literals, avoid_print
import 'package:app/controllers/auth_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class FCMController extends GetxController {
  static FCMController get to => Get.find();
  FirebaseMessaging _messaging = FirebaseMessaging.instance;
  Rx<String> fcmToken = ''.obs;
  RxMap<String, dynamic> message = Map<String, dynamic>().obs;

  @override
  void onInit() {
    _initNotification();
    _getToken();
    ever(fcmToken, updateFCM);
    super.onInit();
  }

  Future<void> getPermisstionFromUser() async {
    NotificationSettings _settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  Future<String?> _getToken() async {
    try {
      String? token = await _messaging.getToken(
        vapidKey: 'KEY',
      );

      fcmToken.value = token!;
      print({"token: ${fcmToken.value}"});
    } catch (e) {
      print(e);
    }
  }

  Future<void> _initNotification() async {
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      _onMessage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(message);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void>? _onMessage(RemoteMessage message) {
    print("_onMessage : ${message.data}");
    return null;
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("_onLaunch : ${message.data}");
  }

  Future<void> updateFCM(_fcmToken) async {
    AuthController authController = Get.find();
    Future.delayed(const Duration(seconds: 1), () {
      if (authController.isLoggedIn.value) {
        authController.updateFCMToken(fcmToken.value);
      }
    });
  }
}


  // void _actionOnNotification(Map<String, dynamic> messageMap) {
  //   message(messageMap);
  // }
