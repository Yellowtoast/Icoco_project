// ignore_for_file: prefer_final_fields, prefer_collection_literals, avoid_print
import 'package:app/controllers/auth_controller.dart';
import 'package:app/widgets/loading/loading.dart';
import 'package:app/widgets/modal/exit_icon_modal.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../configs/routes.dart';
import '../widgets/modal/bottomup_modal2.dart';

class FCMController extends GetxController {
  static FCMController get to => Get.find();
  FirebaseMessaging _messaging = FirebaseMessaging.instance;
  Rx<String> fcmToken = ''.obs;
  RxMap<String, dynamic> message = Map<String, dynamic>().obs;
  Rxn<NotificationSettings> _settings = Rxn<NotificationSettings>();
  RxBool pushAllowed = false.obs;

  @override
  void onInit() {
    _initNotification();
    _getToken();
    ever(fcmToken, updateFCM);
    super.onInit();
  }

  Future<void> getPermisstionFromUser() async {
    _settings.value = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (_settings.value?.authorizationStatus ==
        AuthorizationStatus.authorized) {
      print('User granted permission');
      pushAllowed.value = true;
    } else {
      print('User declined or has not accepted permission');
      pushAllowed.value = false;
    }
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
    // await _messaging.setForegroundNotificationPresentationOptions(
    //   alert: true,
    //   badge: true,
    //   sound: true,
    // );

    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) async {
      _onMessage(remoteMessage);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      Get.dialog(Container(
        color: Colors.black,
        width: 20,
        height: 20,
        child: Text(remoteMessage.data.toString()),
      ));
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void>? _onMessage(RemoteMessage message) {
    print('FCM 메세지 도착');
    print("_onMessage : ${message.data}");

    // exitIconModal(
    //     message.notification?.title ?? 'title',
    //     message.notification?.body ?? 'BODY',
    //     '확인',
    //     () => Get.back(),
    //     'icons/checked.svg',
    //     50);

    BottomUpModal2(
        title: message.notification?.title ?? "산후도우미 변경 완료",
        subtitle: message.notification?.body ??
            "산후도우미 변경 요청으로\n다른 도우미님으로 변경되었습니다\n메인페이지에서 확인바랍니다.",
        buttonText: "확인 완료",
        onTap: () async {
          AuthController authController = Get.find();
          loading(await authController.setModelInfo());
          Get.offAllNamed(Routes.HOME);
        });
    return null;
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("_onLaunch : ${message.data}");

    BottomUpModal2(
        title: message.notification?.title ?? "산후도우미 변경 완료",
        subtitle: message.notification?.body ??
            "산후도우미 변경 요청으로\n다른 도우미님으로 변경되었습니다\n메인페이지에서 확인바랍니다.",
        buttonText: "확인 완료",
        onTap: () async {
          AuthController authController = Get.find();
          loading(await authController.setModelInfo());
          Get.offAllNamed(Routes.HOME);
        });
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
