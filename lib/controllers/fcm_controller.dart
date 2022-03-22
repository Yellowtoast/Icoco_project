// ignore_for_file: prefer_final_fields, prefer_collection_literals, avoid_print
import 'dart:io';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/widgets/loading/loading.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../configs/routes.dart';
import '../widgets/modal/bottomup_modal2.dart';
import '../widgets/modal/option_modal.dart';

class FCMController extends GetxController {
  static FCMController get to => Get.find();
  FirebaseMessaging _messaging = FirebaseMessaging.instance;
  Rx<String> fcmToken = ''.obs;
  RxMap<String, dynamic> message = Map<String, dynamic>().obs;
  Rxn<NotificationSettings> _settings = Rxn<NotificationSettings>();
  RxBool pushAllowed = false.obs;
  RxBool proceedSignup = false.obs;

  @override
  void onInit() {
    _initNotification();
    _getToken();
    ever(fcmToken, updateFCM);
    super.onInit();
  }

  Future<void> getPermissionFromUser() async {
    Map<Permission, PermissionStatus> statuses = {
      Permission.notification: PermissionStatus.denied,
      Permission.reminders: PermissionStatus.denied
    };

    bool granted = false;

    if (!Platform.isIOS) {
      granted = await IcoOptionModal(
          title: '아이코코 푸시알림 동의',
          subtitle: '사운드 및 아이콘 배지가 알림에 포함될 수 있습니다. 마이페이지에서 이를 변경할 수 있습니다.',
          useIcon: false,
          barrierDismissible: true);

      if (granted) {
        statuses[Permission.notification] = PermissionStatus.granted;
      } else {
        statuses[Permission.notification] = PermissionStatus.denied;
      }
    } else if (Platform.isIOS &&
        statuses[Permission.notification] != PermissionStatus.granted) {
      await Get.dialog(
        CupertinoAlertDialog(
          title: Text("'아이코코'에서 알림을 보내고자 합니다."),
          content:
              Text('경고, 사운드 및 아이콘 배지가 알림에 포함될 수 있습니다. 설정에서 이를 구성할 수 있습니다.'),
          actions: [
            CupertinoDialogAction(
                onPressed: () {
                  statuses[Permission.notification] = PermissionStatus.denied;
                  Get.back();
                },
                child: Text('허용안함')),
            CupertinoDialogAction(
                onPressed: () {
                  statuses[Permission.notification] = PermissionStatus.granted;
                  Get.back();
                },
                child: Text(
                  '허용',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                )),
          ],
        ),
      );
    }

    if (statuses[Permission.notification] == PermissionStatus.granted) {
      print('User granted permission');
      pushAllowed.value = true;
      proceedSignup.value = true;
      _settings.value = await _messaging.requestPermission(
        alert: pushAllowed.value,
        badge: pushAllowed.value,
        sound: pushAllowed.value,
      );
    } else {
      print('User declined or has not accepted permission');
      pushAllowed.value = false;
      proceedSignup.value = false;
    }
    print('허용 누른 후 권한 상태? : ${statuses[Permission.notification]}');
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

  _onMessage(RemoteMessage message) {
    print('FCM 메세지 도착');
    print("_onMessage : ${message.data}");

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
