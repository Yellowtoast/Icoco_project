import 'package:app/controllers/auth_controller.dart';
import 'package:app/widgets/loading/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/snackbar/snackbar.dart';

// ignore: prefer_final_fields
class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Rx<bool> isButtonValid = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> firebaseAuthUser = Rxn<User>();

  RxList<Rxn<String>> errorTextList = RxList<Rxn<String>>();
  RxList<TextEditingController> controllerList =
      RxList<TextEditingController>();
  Rxn<String> nameErrorText = Rxn<String>();
  Rxn<String> emailErrorText = Rxn<String>();
  Rxn<String> phoneErrorText = Rxn<String>();
  Rxn<String> authCodeErrorText = Rxn<String>();
  Rxn<String> passwordErrorText = Rxn<String>();

  @override
  void onClose() {
    emailController.clear();
    passwordController.clear();
    super.onClose();
  }

  @override
  void onReady() async {
    ever(emailErrorText, validateButton);
    ever(passwordErrorText, validateButton);
    super.onReady();
  }

  validateButton(errorText) {
    var noError = true;
    var notEmpty = true;
    // errorTextList.forEach((element) {
    //   print(element.value);
    //   if (element.value != null) {
    //     noError = false;
    //   }
    // });
    for (var element in errorTextList) {
      print(element.value);
      if (element.value != null) {
        noError = false;
      }
    }

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

  login(Rxn<User> firebaseAuthUser, Rx<bool> isLoggedIn) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      isLoggedIn.value = true;
      firebaseAuthUser.value = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        openSnackbar("정보와 일치하는 유저가 없습니다", "올바른 정보로 로그인해주세요");
      } else if (e.code == 'wrong-password') {
        openSnackbar("비밀번호가 맞지 않습니다", "올바른 비밀번호를 입력해주세요");
      } else if (e.code == "invalid-email") {
        openSnackbar("이메일 형식이 옳지 않습니다", "올바른 이메일로 로그인해주세요");
      } else {
        print(e);
      }
    }
  }
}
