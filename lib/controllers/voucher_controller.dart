import 'package:app/controllers/auth_controller.dart';
import 'package:app/configs/voucher_fee.dart';
import 'package:app/models/fee_info.dart';
import 'package:app/models/reservation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<dynamic> userFeeList = [0, 0, 0, 0, 0];
  List<dynamic> govermentFeeList = [0, 0, 0, 0, 0];
  List<dynamic> depositFeeList = [0, 0, 0, 0, 0];
  List<dynamic> remainingFeeList = [0, 0, 0, 0, 0];
  late List<dynamic> totalFeeList;
  TextEditingController frontRegNumController = TextEditingController();
  TextEditingController backRegNumController = TextEditingController();
  // late serviceDurationType maxSupportedWeek;
  RxBool isButtonValid = false.obs;
  Rxn<String> regNumErrorText = Rxn<String>();
  AuthController authController = Get.find();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  late FeeModel feeModelCompany;
  late FeeModel feeModelDefault;
  Rx<String> companyUid = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getDefaultFeeInfoFirestore();
    if (voucherResult.value != null) {
      setVoucherInfo(voucherResult.value!,
          authController.reservationModel.value!.extraCost!);
    }
  }

  @override
  void onReady() {
    super.onReady();
    // ever(voucherResult, setVoucherInfo);
  }

  setVoucherInfo(String? _voucher, int additionalFee) async {
    if (_voucher == null || _voucher == '') {
      print('no voucher info');
      return;
    } else {
      voucherResult.value = _voucher;
      if (_voucher != '일반서비스') {
        await splitVoucherResult(_voucher);
        await setDropDownList(null);
      }
      print(companyUid.value);
      await getVoucherCostInfo(_voucher, additionalFee, companyUid.value);
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

  getVoucherCostInfo(
      String voucher, int additionalFee, String companyUid) async {
    depositFeeList = depositFeePerWeek.toList();
    if (companyUid.isNotEmpty) {
      await getCompanyFeeInfoFirestore(companyUid);
      totalFeeList = feeModelCompany.serviceFeeInfo[voucher];
      govermentFeeList = feeModelCompany.govermentFeeInfo[voucher];
    } else {
      await getDefaultFeeInfoFirestore();
      totalFeeList = feeModelDefault.serviceFeeInfo[voucher];
      govermentFeeList = feeModelDefault.govermentFeeInfo[voucher];
    }

    totalFeeList = totalFeeList.map((e) => (e == null) ? 0 : e).toList();
    govermentFeeList =
        govermentFeeList.map((e) => (e == null) ? 0 : e).toList();

    for (int i = 0; i < 5; i++) {
      totalFeeList[i] = totalFeeList[i] + depositFeeList[i] + additionalFee;
    }
    await calculateUserFee();
    await calculateRemainingFee();
    update();
    showResult.value = true;
  }

  calculateUserFee() {
    for (int i = 0; i < 5; i++) {
      userFeeList[i] = totalFeeList[i] - govermentFeeList[i];
    }
  }

  calculateRemainingFee() {
    for (int i = 0; i < 5; i++) {
      remainingFeeList[i] = userFeeList[i] - depositFeeList[i];
    }
  }

  getCompanyFeeInfoFirestore(String companyid) async {
    var documentSnapshot = await db.collection('Company').doc(companyid).get();
    FeeModel model = FeeModel.fromJson(
        {'companyId': companyid, ...documentSnapshot.data()!});
    feeModelCompany = model;
    return model;
  }

  getDefaultFeeInfoFirestore() async {
    var documentSnapshot = await db.collection('Admin').doc('info').get();
    FeeModel model =
        FeeModel.fromJson({'companyId': 'info', ...documentSnapshot.data()!});
    feeModelDefault = model;
    return model;
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
