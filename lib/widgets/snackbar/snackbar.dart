import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../configs/colors.dart';

openSnackbar(String? title, String? subtitle) {
  return Get.snackbar(title ?? "인증번호 전송 완료", subtitle ?? "",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Color.fromARGB(152, 0, 0, 0),
      colorText: IcoColors.white,
      duration: Duration(seconds: 3),
      borderRadius: 8,
      margin: EdgeInsets.all(20));
}

iconSnackbar() {
  return Get.dialog(
      Lottie.asset('assets/swipe.json',
          repeat: true, reverse: false, animate: true, width: 330),
      barrierColor: Color.fromARGB(105, 0, 0, 0));
}

iconSnackbar2() {
  return SnackBar(
      duration: Duration(seconds: 2),
      content: Lottie.asset('assets/swipe.json',
          repeat: true, reverse: false, animate: true, width: 330),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: Color.fromARGB(94, 0, 0, 0));
}
