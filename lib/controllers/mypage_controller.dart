import 'package:app/configs/insurance_standards.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/models/reservation.dart';
import 'package:app/models/review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MypageController extends GetxController {
  final FirebaseFirestore db = FirebaseFirestore.instance;
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

  getMyPreviousReview(
      String reservationNumber, String userUid, String reviewType) async {
    Rxn<ReviewModel> _previousModel = Rxn<ReviewModel>();
    RxList<Rxn<ReviewModel>> _myReviewList = RxList<Rxn<ReviewModel>>();

    var querySnapshot = await db
        .collection('Review')
        .where('reservationNumber', isEqualTo: reservationNumber)
        .get();

    querySnapshot.docs.forEach((doc) {
      if (doc.data()['type'] == reviewType && doc.data()['userId'] == userUid) {
        _previousModel.value = ReviewModel.fromJson(doc.data());
        if (_previousModel.value != null) {
          print({'before', _previousModel.value!.contents});
          _myReviewList.add(_previousModel);
          print({'after', _previousModel.value!.contents});
        }
      }
    });

    return _myReviewList;
  }
}
