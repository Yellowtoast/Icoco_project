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
  RxBool show = false.obs;
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
  RxList<String>? voucherType3List = ['1', '2', '3'].obs;
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
  void onInit() async {
    await setVoucherInfo(voucherResult.value);

    super.onInit();
  }

  @override
  void onReady() async {
    ever(voucherResult, setVoucherInfo);

    super.onReady();
  }

  setVoucherInfo(voucher) {
    if (voucher == null) {
      print('no voucher info');
      return;
    }

    List<String>? voucherList = voucher.split('-');

    for (var element in voucherList!) {
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
    getVoucherCostInfo();
  }

  setDropDownList() {
    if (voucherType1.value == 'A') {
      voucherType3List!.value = ['1', '2', '3'];
    } else if (voucherType1.value == 'B') {
      voucherType3List!.value = ['1', '2'];
    } else {
      voucherType3List!.value = [''];
    }
  }

  checkVoucherValid() {
    if ((voucherType1.value != null &&
            voucherType2.value != null &&
            voucherType3.value != null) ||
        (voucherType1.value == 'C' && voucherType2.value != null)) {
      if (voucherType1.value == 'C') {
        voucherResult.value = voucherType1.value! + '-' + voucherType2.value!;
      } else {
        voucherResult.value = voucherType1.value! +
            '-' +
            voucherType2.value! +
            '-' +
            voucherType3.value!;
      }
    } else {
      voucherResult.value = '';
    }
    getVoucherCostInfo();
  }

  getVoucherCostInfo() {
    try {
      if (voucherResult.value != null) {
        depositFeeList.assignAll(depositFeePerWeek);
        totalFeeList.assignAll(totalFeeInfo[voucherResult.value]!);
        govermentFeeList.assignAll(govermentFeeInfo[voucherResult.value]!);

        calculateUserFee();
        calculateRemainingFee();

        showResult.value = true;
      } else {
        showResult.value = false;
      }
    } catch (e) {
      showResult.value = false;
    }
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

  updateRegnumToModel(Rxn<ReservationModel?> model) async {
    model.value!.fullRegNum = await getFullRegNum();
  }

  updateVoucherToModel(Rxn<ReservationModel?> model) async {
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
