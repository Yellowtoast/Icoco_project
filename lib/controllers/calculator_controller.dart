import 'package:app/configs/insurance_standards.dart';
import 'package:app/models/reservation.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalculatorController extends GetxController {
  List<String> numberOfChildType = ['첫째 아이', '둘째 아이', '셋째 아이 이상'];
  List<String> babyType = ['단태아', '쌍태아', '삼태아이상', '중증장애산모 (중복필수)'];
  List<String> insuranceType = ['직장가입자', '지역가입자', '혼합(직장+지역)'];
  List<String> numberOfHelperType = ['인력 1명', '인력 2명'];
  Rxn<ReservationModel> reservationModel = Rxn<ReservationModel>();
  TextEditingController insuranceFeeTextController = TextEditingController();
  TextEditingController familyNumberTextController = TextEditingController();
  Rxn<String> insuranceTypeSelected = Rxn<String>();
  Rxn<int> healthInsuranceFee = Rxn<int>();
  RxList<String> babyTypeSelectedList = RxList<String>();
  Rxn<String> numberOfChildSelected = Rxn<String>();
  Rxn<String> numberofHelperSelected = Rxn<String>();
  Rxn<String> relatedSelectionField = Rxn<String>();
  late String expectedVoucher;
  late int? familyNumber;
  late int? insuranceFee;
  late bool over150PctIncome;
  late String? firstVoucher;
  late String? secondVoucher;
  late String? thirdVoucher;
  RxList<Rx<bool>> stepList = [
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
  ].obs;

  Rx<bool> isButtonValid = false.obs;

  @override
  void onReady() {
    ever(stepList, validateButton);
    super.onReady();
  }

  validateButton(_stepList) {
    _stepList.contains(false.obs)
        ? isButtonValid.value = false
        : isButtonValid.value = true;

    return true;
  }

  // validateButton() {
  //   return stepList.contains(false.obs) ? false.obs : true.obs;
  // }

  bool isIncomeOver150Pct(
      String insuranceType, int insuranceFee, int familyNum) {
    switch (insuranceType) {
      case "직장가입자":
        if (insuranceFee >= groupSubscriber[familyNum]!) {
          return true;
        } else {
          return false;
        }

      case "지역가입자":
        if (insuranceFee >= individualSubscriber[familyNum]!) {
          return true;
        } else {
          return false;
        }

      case "혼합(직장+지역)":
        if (insuranceFee >= mixedSubscriber[familyNum]!) {
          return true;
        } else {
          return false;
        }

      default:
        return true;
    }
  }

  setFirstVoucherCode(RxList<String> babyTypeList) {
    if (babyTypeList.length == 1) {
      switch (babyTypeList[0]) {
        case "단태아":
          firstVoucher = 'A';
          break;
        case "쌍태아":
          firstVoucher = 'B';
          break;
        case "삼태아이상":
          firstVoucher = 'C';
          break;
        default:
      }
    } else if (babyTypeList.length == 2) {
      if (babyTypeList.contains('단태아')) {
        firstVoucher = 'B';
      } else {
        firstVoucher = 'C';
      }
    }
  }

  setSecondVoucherCode(String insuranceType, int insuranceFee, int familyNum) {
    over150PctIncome =
        isIncomeOver150Pct(insuranceType, insuranceFee, familyNum);
    over150PctIncome ? secondVoucher = '라' : secondVoucher = '통합';
  }

  setThirdVoucherCode(
      String? numberOfChild, String? numberOfHelper, List<String> babyType) {
    if (firstVoucher == 'C') {
      thirdVoucher = null;
      return;
    }

    if (!babyType.contains('쌍태아')) {
      switch (numberOfChild) {
        case "첫째 아이":
          thirdVoucher = '1';
          break;
        case "둘째 아이":
          thirdVoucher = '2';
          break;
        case "셋째 아이 이상":
          if (firstVoucher == 'A') {
            thirdVoucher = '3';
          } else if (firstVoucher == 'B') {
            thirdVoucher = '2';
          }
          break;
        default:
      }
    } else {
      switch (numberOfHelper) {
        case "인력 1명":
          thirdVoucher = '1';
          break;
        case "인력 2명":
          thirdVoucher = '2';
          break;
        default:
      }
    }
  }

  String? getAllVoucherCode() {
    setFirstVoucherCode(babyTypeSelectedList);
    setSecondVoucherCode(
        insuranceTypeSelected.value!, insuranceFee!, familyNumber!);
    setThirdVoucherCode(numberOfChildSelected.value,
        numberofHelperSelected.value, babyTypeSelectedList);
    (thirdVoucher == null)
        ? expectedVoucher = firstVoucher! + '-' + secondVoucher!
        : expectedVoucher =
            firstVoucher! + '-' + secondVoucher! + '-' + thirdVoucher!;

    return expectedVoucher;
  }
}
