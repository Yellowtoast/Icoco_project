import 'package:app/configs/colors.dart';
import 'package:app/helpers/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

startLoadingIndicator() {
  return Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset('assets/loading2.json',
              repeat: true, reverse: true, animate: true, width: 90),
        ],
      ),
      barrierColor: Colors.white30,
      barrierDismissible: false);
}

finishLoadingIndicator() {
  Get.back();
}

loading(Future<dynamic> Function() function) {
  return Get.showOverlay(
    opacityColor: Colors.white30,
    asyncFunction: function,
    loadingWidget: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset('assets/loading2.json',
            repeat: true, reverse: true, animate: true, width: 90),
      ],
    ),
  );
}
