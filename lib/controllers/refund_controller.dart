import 'package:app/configs/insurance_standards.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/helpers/date_calculator.dart';
import 'package:app/helpers/formatter.dart';
import 'package:app/models/refund.dart';
import 'package:app/models/reservation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RefundController extends GetxController {
  AuthController authController = Get.find();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  List<String> bankType = ['KB국민은행', '신한은행', '하나은행'];
  Rxn<ReservationModel> reservationModel = Rxn<ReservationModel>();
  TextEditingController accountNumberTextController = TextEditingController();
  TextEditingController accountHolderTextController = TextEditingController();
  Rxn<String> bankSelected = Rxn<String>();
  Rxn<String> accountNumber = Rxn<String>();
  Rxn<String> accountHolder = Rxn<String>();

  Rx<bool> isButtonValid = false.obs;
  RxList<Rx<bool>> stepList = [
    false.obs,
    false.obs,
    false.obs,
  ].obs;

  late int serviceDays;
  late int serviceDaysLeft;
  late int serviceDaysSpent;
  late int spentUserFee;
  late int spentUserFeePercent;
  late int refundableUserFee;
  late int refundableFeePercent;
  late int totalServiceCost;

  @override
  void onInit() {
    setRefundInfo();
    super.onInit();
  }

  @override
  void onReady() {
    ever(stepList, validateButton);
    super.onReady();
  }

  setRefundInfo() {
    totalServiceCost = authController.reservationModel.value!.userCost!;
    serviceDays = int.parse((authController
            .reservationModel.value!.serviceDuration!
            .substring(0, 1))) *
        7;
    serviceDaysSpent = getServiceDaysSpent();
    serviceDaysLeft = serviceDays - serviceDaysSpent;
    refundableUserFee = calcRefundableFee(totalServiceCost, serviceDays);
    spentUserFee =
        authController.reservationModel.value!.userCost! - refundableUserFee;
    spentUserFeePercent = calcFeePercent(spentUserFee, totalServiceCost);
    refundableFeePercent = 100 - spentUserFeePercent;
  }

  validateButton(_stepList) {
    _stepList.contains(false.obs)
        ? isButtonValid.value = false
        : isButtonValid.value = true;
    return true;
  }

  calcRefundableFee(int totalServiceFee, int serviceDays) {
    double oneServiceDayFee = totalServiceFee / serviceDays;
    return (serviceDaysLeft * oneServiceDayFee).toInt();
  }

  getServiceDaysSpent() {
    return calcDifferenceBetweenDates(
        authController.reservationModel.value!.serviceStartDate!,
        dateFormatWithDot.format(DateTime.now()));
  }

  calcFeePercent(int part, int whole) {
    int percent = ((part / whole) * 100).toInt();
    return percent;
  }

  createRefundFirestore(String reservationNumber) {
    RefundModel _newRefundModel = RefundModel(
        refundAccountHolder: accountHolder.value!,
        refundAccountNumber: accountNumber.value!,
        refundBank: bankSelected.value!,
        refundRequested: true,
        serviceRemainingDays: serviceDaysLeft,
        status: '서비스취소');
    db.doc('/Reservation/$reservationNumber').update(_newRefundModel.toJson());
    update();
  }
}
  // calculateServiceDaysLeft() {
  //   serviceDaysLeft = calcDifferenceBetweenDates(
  //       dateFormatWithDot.format(DateTime.now()),
  //       authController.reservationModel.value!.serviceEndDate!);
  // }


