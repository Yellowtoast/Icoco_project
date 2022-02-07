import 'package:app/configs/insurance_standards.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/models/reservation.dart';
import 'package:app/models/review.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MypageController extends GetxController {
  RxBool allowEvent = false.obs;
  RxBool allowPushAlarm = false.obs;
  AuthController authController = Get.find();
  Rxn<dynamic> model = Rxn<dynamic>();
  List<String> addressList = [];
  RxList<Rxn<ReviewModel>>? middleReviewModelList = RxList<Rxn<ReviewModel>>();
  RxList<Rxn<ReviewModel>>? finalReviewModelList = RxList<Rxn<ReviewModel>>();

  @override
  void onInit() {
    // splitAddress(model);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  // splitAddress(String) {
  //   addressList = _model.value.address.split("/");
  //   update();
  // }
}
