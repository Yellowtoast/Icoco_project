import 'package:app/configs/enum.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/reservation/step1/voucher_controller.dart';
import 'package:app/helpers/addtional_fee_calc.dart';
import 'package:app/models/reservation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdditionalFeeController extends GetxController {
  AuthController authController = Get.find();
  VoucherController voucherController = Get.find();
  Rxn<ReservationModel> reservationModel = Rxn<ReservationModel>();
  TextEditingController preschoolerController = TextEditingController();
  TextEditingController kindergartenController = TextEditingController();
  TextEditingController schoolerController = TextEditingController();
  TextEditingController extraFamilyController = TextEditingController();
  Rx<bool> isButtonValid = false.obs;
  int? preschoolerFee;
  int? kindergartenFee;
  int? schoolerFee;
  int? extraFamilyFee;
  int? preschooler;
  int? kindergartener;
  int? schooler;
  int? extraFamily;
  int? totalAdditionalFee;

  Rxn<careType> careTypeSelected = Rxn<careType>();

  @override
  void onReady() async {
    ever(careTypeSelected, validateButton);
    super.onReady();
  }

  setExtraChargeOptions() {
    preschooler = int.tryParse(preschoolerController.text) ?? 0;
    kindergartener = int.tryParse(kindergartenController.text) ?? 0;
    schooler = int.tryParse(schoolerController.text) ?? 0;
    extraFamily = int.tryParse(extraFamilyController.text) ?? 0;

    preschoolerFee = (preschooler! * addtionalFeeCalc["preschooler"]!);
    kindergartenFee = (kindergartener! * addtionalFeeCalc["kindergartener"]!);
    schoolerFee = (schooler! * addtionalFeeCalc["schooler"]!);
    extraFamilyFee = (extraFamily! * addtionalFeeCalc["extraFamily"]!);

    totalAdditionalFee =
        preschoolerFee! + kindergartenFee! + schoolerFee! + extraFamilyFee!;
  }

  updateReservationModel() {
    authController.reservationModel.value!.allAdditionalFamily = {
      "preschooler": preschooler,
      "kindergartener": kindergartener,
      "schooler": schooler,
      "extraFamily": extraFamily,
    };

    authController.reservationModel.value!.extraCost = totalAdditionalFee;
    voucherController.additionalFee.value = totalAdditionalFee!;
  }

  validateButton(_info) {
    if (careTypeSelected.value != null) {
      isButtonValid.value = true;
    } else {
      isButtonValid.value = false;
    }
  }
}
