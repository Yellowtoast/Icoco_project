import 'package:app/controllers/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: prefer_final_fields
class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Rx<bool> isButtonValid = false.obs;

  FirebaseAuth _auth = FirebaseAuth.instance;
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

  login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      firebaseAuthUser.value = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else if (e.code == "invalid-email") {
        print('이메일 형식이 잘못되었습니다');
      }
    }
  }
}
