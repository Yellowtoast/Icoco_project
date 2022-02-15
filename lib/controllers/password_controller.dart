import 'dart:math';
import 'package:app/configs/purplebook.dart';
import 'package:app/controllers/fcm_controller.dart';
import 'package:app/helpers/formatter.dart';
import 'package:app/models/reservation.dart';
import 'package:app/models/user.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PasswordController extends GetxController {
  // ignore: unused_field
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  String regNum = '';
  FCMController fcmController = Get.find();
  Rxn<UserModel> userModel = Rxn<UserModel>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController authCodeController = TextEditingController();
  Rxn<String> nameErrorText = Rxn<String>();
  Rxn<String> phoneErrorText = Rxn<String>();
  Rxn<String> authCodeErrorText = Rxn<String>();
  Rxn<String> passwordErrorText = Rxn<String>();
  Rxn<String> confirmPasswordErrorText = Rxn<String>();
  Rxn<String> birthErrorText = Rxn<String>();
  Rxn<String> regNumErrorText = Rxn<String>();
  late String phoneNumber;
  RxInt codeSentTimes = 0.obs;
  RxBool isButtonValid = false.obs;
  Rxn<bool> isTimeOut = Rxn<bool>();
  Rxn<String> authCode = Rxn<String>();
  Rx<int> timeLeft = 0.obs;
  Rxn<bool> isRightCodeNum = Rxn<bool>();
  late Timer codeTimer;
  RxBool isCodeSent = false.obs;
  RxList<Rxn<String>> errorTextList = RxList<Rxn<String>>();
  RxList<TextEditingController> controllerList =
      RxList<TextEditingController>();
  RxBool codeSendButtonValid = false.obs;
  RxBool showTimer = false.obs;
  String? uid;
  RxList<dynamic> stepList = [false.obs, false.obs].obs;

  @override
  void onReady() {
    ever(stepList, validateButton2);
    ever(passwordErrorText, validateButton);
    ever(confirmPasswordErrorText, validateButton);
    ever(nameErrorText, validateButton);
    ever(regNumErrorText, validateButton);
    ever(phoneErrorText, validateButton);
    ever(authCodeErrorText, validateButton);

    super.onReady();
  }

  @override
  void onClose() {
    nameController.clear();
    phoneController.clear();
    confirmPasswordController.clear();
    nameController.clear();
    authCodeController.clear();
    birthController.clear();
    genderController.clear();
    super.onClose();
  }

//verify code sent to user
  validateAuthCode() {
    final value = authCodeController.value.text;
    if (timeLeft.value > 0 && value == authCode.value) {
      showTimer.value = false;
      authCodeErrorText.value = null;
    } else if (value.isEmpty) {
      showTimer.value = true;
      authCodeErrorText.value = null;
    } else {
      showTimer.value = true;
      authCodeErrorText.value = '인증번호가 일치하지 않습니다';
    }
  }

  sendAuthCodeMessage() async {
    try {
      await getNewCodeNum();
      print(authCode);
      // late String to = phoneNumber;
      // late String text = '아이코코 인증번호 $authCode을 입력해주세요.';
      // final jwt = JWT(
      //   {"to": to, "text": text},
      // );
      // var token = jwt.sign(SecretKey(JWT_KEY));
      // codeSentTimes++;
      // var res = await http.get(
      //   Uri.parse(
      //     'https://icoco2022-erpweb.vercel.app/api/sendMessage',
      //   ),
      //   headers: {'x-access-token': token},
      // );
      // print(res.statusCode);

      return;
    } catch (e) {
      print(e);
    }
  }

  getNewCodeNum() {
    try {
      List<String> codeNumList = [];

      for (int i = 0; codeNumList.length <= 4; i++) {
        var codeNum = Random().nextInt(10).toString();
        codeNumList.add(codeNum);
      }
      authCode.value = codeNumList.join("");
    } catch (e) {
      print("인증코드 생성 실패");
    }
  }

  void startAuthCodeTimer(int timeOutSecond) {
    showTimer.value = true;
    timeLeft.value = timeOutSecond;
    codeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timeLeft.value = timeLeft.value - 1;
      validateAuthCode();
      if (timeLeft.value <= 0) {
        codeTimer.cancel();
        timeLeft.value = 0;
        codeSendButtonValid.value = true;
      }
    });
  }

  validateButton(errorText) {
    var noError = true;
    var notEmpty = true;
    errorTextList.forEach((element) {
      print(element.value);
      if (element.value != null) {
        noError = false;
      }
    });

    controllerList.forEach((controller) {
      if (controller.value.text.isEmpty) {
        notEmpty = false;
      }
    });

    if (noError && notEmpty) {
      isButtonValid.value = true;
    } else {
      isButtonValid.value = false;
    }
  }

  validateButton2(_list) {
    if (_list.contains(false.obs)) {
      isButtonValid.value = false;
    } else {
      isButtonValid.value = true;
    }
  }

  checkUserFirestore(String name, String phone, String regNum) async {
    String? uid;

    try {
      var querySnapshot =
          await db.collection('User').where('phone', isEqualTo: phone).get();

      querySnapshot.docs.forEach((doc) async {
        if (doc.data()['name'] == name &&
            doc.data()['phone'] == phone &&
            doc.data()['regNum'] == regNum) {
          uid = doc.data()['uid'];
        }
      });
      return uid;
    } catch (e) {
      print(e);
    }
  }

  changePassword(String _uid, String _newPassword) async {
    // reviewModelList.clear();
    var queryParameters = {
      "uid": _uid,
      "password": _newPassword,
    };

    final jwt = JWT(
      queryParameters,
    );
    var token = jwt.sign(SecretKey(JWT_KEY));
    var res = await http.put(
      Uri.parse(
        // 'https://icoco2022-erpweb.vercel.app/api/updatePassword',
        'http://172.30.1.22:3000/api/updatePassword',
      ),
      headers: {'x-access-token': token},
    );
    print(res.statusCode);
  }

  getRegnum() {
    return birthController.text + genderController.text;
  }
}
