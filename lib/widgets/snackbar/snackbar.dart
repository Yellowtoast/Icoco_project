import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/colors.dart';

openSnackbar(String? title, String? subtitle) {
  return Get.snackbar(title ?? "인증번호 전송 완료", subtitle ?? "",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Color.fromARGB(129, 0, 0, 0),
      colorText: IcoColors.white,
      duration: Duration(seconds: 3),
      borderRadius: 8,
      margin: EdgeInsets.all(20));
}

openSnackbar(String? title, String? subtitle) {
  return Get.snackbar(title ?? "인증번호 전송 완료", subtitle ?? "",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Color.fromARGB(129, 0, 0, 0),
      colorText: IcoColors.white,
      duration: Duration(seconds: 3),
      borderRadius: 8,
      margin: EdgeInsets.all(20));
}
