import 'package:app/configs/enum.dart';
import 'package:app/configs/purplebook.dart';
import 'package:app/configs/steps.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/home_controller.dart';
import 'package:app/helpers/validator.dart';
import 'package:app/configs/voucher_fee.dart';
import 'package:app/models/reservation.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VoucherController extends GetxController {
  Rxn<String> voucherType1 = Rxn<String>();
  Rxn<String> voucherType2 = Rxn<String>();
  Rxn<String> voucherType3 = Rxn<String>();
  Rxn<String> voucherResult = Rxn<String>();
  Rxn<String> fullRegNum = Rxn<String>();
  RxBool hasPreviousVoucher = false.obs;
  RxBool isVoucherUsed = false.obs;
  Rxn<bool> isVoucherValid = Rxn<bool>();
  RxList<String> voucherType1List = ['A', 'B', 'C'].obs;
  RxList<String> voucherType2List = ['가', '통합', '라'].obs;
  RxList<String> voucherType3List = ['1', '2', '3'].obs;
  RxBool showResult = false.obs;
  RxList<int> userFeeList = [0, 0, 0, 0, 0].obs;
  RxList<int> govermentFeeList = [0, 0, 0, 0, 0].obs;
  RxList<int> depositFeeList = [0, 0, 0, 0, 0].obs;
  RxList<int> remainingFeeList = [0, 0, 0, 0, 0].obs;
  RxList<int> totalFeeList = [0, 0, 0, 0, 0].obs;
  RxInt additionalFee = 0.obs;
  TextEditingController frontRegNumController = TextEditingController();
  TextEditingController backRegNumController = TextEditingController();
  Rxn<User?> firebaseAuthUser = Rxn<User?>();
  late serviceDurationType maxSupportedWeek;
  RxBool isButtonValid = false.obs;
  HomeController homeController = HomeController();
  Rxn<String> regNumErrorText = Rxn<String>();

  @override
  void onInit() {
    if (voucherResult.value != null) {
      setVoucherInfo(voucherResult.value!);
    }

    super.onInit();
  }

  @override
  void onReady() {
    // ever(voucherResult, setVoucherInfo);

    super.onReady();
  }

  setVoucherInfo(String? _voucher) {
    if (_voucher == null || _voucher == '') {
      print('no voucher info');
      return;
    } else {
      splitVoucherResult(_voucher);
      getVoucherCostInfo(_voucher);
    }
  }

  splitVoucherResult(String _voucher) {
    List<String>? voucherList = _voucher.split('-');
    for (var element in voucherList) {
      switch (voucherList.indexOf(element)) {
        case 0:
          voucherType1.value = element;
          break;
        case 1:
          voucherType2.value = element;
          break;
        case 2:
          voucherType3.value = element;
          break;
        default:
      }
    }
  }

  setDropDownList(Rxn<String>? voucherItem) {
    if (voucherItem == null) {
      //바우처 선택 액션이 취해지지 않은 상태에서 해당 함수가 실행된다면
      //기존에 있던 바우처 정보를 불러와야 함 -> 드롭다운도 세팅되어 있는 상태여야 함
      splitVoucherResult(voucherResult.value!);
      if (voucherType1.value == 'A') {
        voucherType3List.value = ['1', '2', '3'];
      } else if (voucherType1.value == 'B') {
        voucherType3List.value = ['1', '2'];
      } else if (voucherType1.value == 'C') {
        voucherType3List.value = [''];
      }
    } else {
      if (voucherItem.value == 'A' ||
          voucherItem.value == 'B' ||
          voucherItem.value == 'C') {
        if (voucherType1.value == 'A') {
          voucherType3List.value = ['1', '2', '3'];
        } else if (voucherType1.value == 'B') {
          voucherType3List.value = ['1', '2'];
        } else if (voucherType1.value == 'C') {
          voucherType3List.value = [''];
        }
        showResult.value = false;
        voucherType2.value = null;
        voucherType3.value = null;
      } else {
        return;
      }
    }
  }

  // Rxn<String>? checkVoucherValid() {
  //   Rxn<String> fullVoucher = Rxn<String>();
  //   if ((voucherType1.value != null &&
  //           voucherType2.value != null &&
  //           voucherType3.value != null) ||
  //       (voucherType1.value == 'C' && voucherType2.value != null)) {
  //     if (voucherType1.value == 'C') {
  //       fullVoucher.value = voucherType1.value! + '-' + voucherType2.value!;
  //     } else {
  //       fullVoucher.value = voucherType1.value! +
  //           '-' +
  //           voucherType2.value! +
  //           '-' +
  //           voucherType3.value!;
  //       return fullVoucher;
  //     }
  //   } else {
  //     return fullVoucher;
  //   }
  // }

  makeFullVoucherResult() {
    late String fullVoucher;
    if (voucherType1.value == 'C') {
      fullVoucher = voucherType1.value! + '-' + voucherType2.value!;
    } else {
      fullVoucher = voucherType1.value! +
          '-' +
          voucherType2.value! +
          '-' +
          voucherType3.value!;
    }

    return fullVoucher;
  }

  bool checkVoucherValid() {
    if ((voucherType1.value != null &&
            voucherType2.value != null &&
            voucherType3.value != null) ||
        (voucherType1.value == 'C' && voucherType2.value != null)) {
      return true;
    } else {
      return false;
    }
  }

  getVoucherCostInfo(String voucher) {
    depositFeeList.assignAll(depositFeePerWeek);
    totalFeeList.assignAll(totalFeeInfo[voucher]!);
    govermentFeeList.assignAll(govermentFeeInfo[voucher]!);

    calculateUserFee();
    calculateRemainingFee();

    showResult.value = true;
  }

  calculateUserFee() {
    for (int i = 0; i < 5; i++) {
      userFeeList[i] = totalFeeList[i] - govermentFeeList[i];
    }
  }

  calculateRemainingFee() {
    for (int i = 0; i < 5; i++) {
      remainingFeeList.value[i] =
          userFeeList[i].toInt() - depositFeeList[i].toInt();
    }
  }

  getFullRegNum() {
    String fullRegNum;

    fullRegNum = frontRegNumController.value.text +
        "-" +
        backRegNumController.value.text;

    return fullRegNum;
  }

  updateRegnumToModel(Rxn<ReservationModel?> model) {
    model.value!.fullRegNum = getFullRegNum();
  }

  updateVoucherToModel(Rxn<ReservationModel?> model) {
    model.value!.voucher = voucherResult.value;
  }

  validateButton(String frontText, String backText) {
    if (regNumErrorText.value == null && frontText != '' && backText != '') {
      isButtonValid.value = true;
    } else {
      isButtonValid.value = false;
    }
  }
}
