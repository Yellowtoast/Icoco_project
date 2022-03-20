import 'package:app/configs/enum.dart';
import 'package:app/controllers/company_controller.dart';
import 'package:app/helpers/addtional_fee_calculator.dart';
import 'package:app/helpers/enum_to_string.dart';
import 'package:app/models/reservation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdditionalFeeController extends GetxController {
  Rxn<ReservationModel> reservationModel = Rxn<ReservationModel>();
  TextEditingController preschoolerController = TextEditingController();
  TextEditingController kindergartenController = TextEditingController();
  TextEditingController schoolerController = TextEditingController();
  TextEditingController extraFamilyController = TextEditingController();
  RxInt additionalFee = 0.obs;
  Rx<bool> isButtonValid = false.obs;
  int? preschoolerFee;
  int? kindergartenFee;
  int? schoolerFee;
  int? extraFamilyFee;
  int preschoolerFeeStandard = 0;
  int kindergartenFeeStandard = 0;
  int schoolerFeeStandard = 0;
  int extraFamilyFeeStandard = 0;
  int? preschooler;
  int? kindergartener;
  int? schooler;
  int? extraFamily;
  int totalAdditionalFee = 0;

  Rxn<careType> careTypeSelected = Rxn<careType>();

  @override
  void onReady() async {
    ever(careTypeSelected, validateButton);
    super.onReady();
  }

  getAdditionalFeeInfo() {
    CompanyController companyController = Get.find();

    preschoolerFeeStandard = companyController
        .companyModelList[companyController.companySelected.value!]
        .preschoolerCost;

    kindergartenFeeStandard = companyController
        .companyModelList[companyController.companySelected.value!]
        .kindergartenerCost;

    schoolerFeeStandard = companyController
        .companyModelList[companyController.companySelected.value!]
        .schoolerCost;

    extraFamilyFeeStandard = companyController
        .companyModelList[companyController.companySelected.value!]
        .extraFamilyCost;
  }

  setExtraChargeOptions() {
    preschooler = int.tryParse(preschoolerController.text) ?? 0;
    kindergartener = int.tryParse(kindergartenController.text) ?? 0;
    schooler = int.tryParse(schoolerController.text) ?? 0;
    extraFamily = int.tryParse(extraFamilyController.text) ?? 0;

    getAdditionalFeeInfo();

    preschoolerFee = (preschooler! * preschoolerFeeStandard);
    kindergartenFee = (kindergartener! * kindergartenFeeStandard);
    schoolerFee = (schooler! * schoolerFeeStandard);
    extraFamilyFee = (extraFamily! * extraFamilyFeeStandard);

    totalAdditionalFee =
        preschoolerFee! + kindergartenFee! + schoolerFee! + extraFamilyFee!;
  }

  updateReservationModel(dynamic model) {
    model.value!.allAdditionalFamily = {
      "preschooler": preschooler,
      "kindergartener": kindergartener,
      "schooler": schooler,
      "extraFamily": extraFamily,
    };
    model.value.careType = careTypeSelected.value!.convertCareTypeToString;
    model.value!.extraCost = totalAdditionalFee;
    // voucherController.additionalFee.value = totalAdditionalFee!;
  }

  validateButton(_info) {
    if (careTypeSelected.value != null) {
      isButtonValid.value = true;
    } else {
      isButtonValid.value = false;
    }
  }
}
