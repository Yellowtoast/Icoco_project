import 'package:app/configs/enum.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/voucher_controller.dart';
import 'package:app/controllers/additional_fee_controller.dart';
import 'package:app/controllers/date_info_controller.dart';
import 'package:app/helpers/enum_to_string.dart';
import 'package:app/helpers/formatter.dart';
import 'package:app/models/reservation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: constant_identifier_names
enum stepType { STEP1, STEP2, STEP3 }

class ServiceInfoController extends GetxController {
  AuthController authController = Get.find();
  VoucherController voucherController = Get.find();
  DateInfoController dateInfoController = Get.find();
  Rxn<lactationType> lactationTypeSelected = Rxn<lactationType>();
  Rxn<carePlaceType> carePlaceTypeSelected = Rxn<carePlaceType>();
  Rxn<serviceDurationType> voucherUseDurationSelected =
      Rxn<serviceDurationType>();
  TextEditingController extraRequestsController = TextEditingController();
  Rxn<petType> petTypeSelected = Rxn<petType>();
  Rx<bool> isButtonValid = false.obs;
  Rx<int> priorityNum = 0.obs;
  // List<String> serviceDurationTypeList = ['1주', '2주', '3주', '4주', '5주'];
  // Rxn<String> serviceDurationSelected = Rxn<String>();
  // Rxn<DateTime> serviceStartDate = Rxn<DateTime>();
  // Rxn<DateTime> serviceEndDate = Rxn<DateTime>();
  Map<stepType, RxBool> allStepState = {
    stepType.STEP1: false.obs,
    stepType.STEP2: false.obs,
    stepType.STEP3: false.obs,
  };
  RxList<carePriority> carePriorityList = RxList<carePriority>();
  List<String> stringCarePriorityList = [];

  late int finalUserFee;
  late int finalGovermentFee;
  late int finalTotalFee;
  late int finalDepositFee;
  late int finalRemainingFee;

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    ever(lactationTypeSelected, validateButton);
    ever(carePlaceTypeSelected, validateButton);
    ever(petTypeSelected, validateButton);
    ever(carePriorityList, validateButton);
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  setServiceCost(String serviceDuration) {
    late int listIndex;
    switch (serviceDuration) {
      case '1주':
        listIndex = 0;
        break;
      case '2주':
        listIndex = 1;
        break;
      case '3주':
        listIndex = 2;
        break;
      case '4주':
        listIndex = 3;
        break;
      case '5주':
        listIndex = 4;
        break;
      default:
    }
    authController.reservationModel.value!.userCost =
        voucherController.userFeeList[listIndex];
    authController.reservationModel.value!.revenueCost =
        voucherController.govermentFeeList[listIndex];
    authController.reservationModel.value!.totalCost =
        voucherController.totalFeeList[listIndex];
    authController.reservationModel.value!.depositCost =
        voucherController.depositFeeList[listIndex];
    authController.reservationModel.value!.balanceCost =
        voucherController.remainingFeeList[listIndex];
  }

  carePriorityButtonController(carePriority selectedCare) {
    print("this is priorityNum set: ${priorityNum.value}");
    print("this is selectedCare set: $selectedCare");
    print(
        "Is this a list contains selectedCare? -> ${carePriorityList.contains(selectedCare)}");
    if (carePriorityList.contains(selectedCare)) {
      carePriorityList.clear();
    } else {
      carePriorityList.add(selectedCare);
    }
    print(
        "Is this a list contains selectedCare? -> ${carePriorityList.contains(selectedCare)}");
  }

  // setLactationType() {
  //   reservationController.reservationModel.value!.lactationType =
  //       lactationTypeSelected.value!.convertLactationTypeToSting;
  // }

  // setCarePlace() {
  //   reservationController.reservationModel.value!.placeToBeServiced =
  //       carePlaceTypeSelected.value!.convertCarePlaceTypeToString;
  // }

  setPetType() {
    authController.reservationModel.value!.animalType =
        petTypeSelected.value!.convertPetTypeToString;
  }

  // setExtraRequest() {
  //   print(extraRequestsController.text);
  //   reservationController.reservationModel.value!.extraRequests =
  //       extraRequestsController.text;
  // }

  setCarePriorityList() {
    if (carePriorityList.isNotEmpty) {
      stringCarePriorityList.clear();
      carePriorityList.forEach((element) {
        print(element.convertCarePriorityToString);
        stringCarePriorityList.add(element.convertCarePriorityToString);
      });
    }
  }

  setServiceInfoToModel(Rxn<ReservationModel?> model, String serviceDuration) {
    setServiceCost(serviceDuration);
    setCarePriorityList();

    model.value!.voucher = voucherController.voucherResult.value ??
        authController.reservationModel.value!.voucher;
    model.value!.careRanking =
        (stringCarePriorityList.isNotEmpty) ? stringCarePriorityList : null;
    model.value!.placeToBeServiced = (carePlaceTypeSelected.value != null)
        ? carePlaceTypeSelected.value!.convertCarePlaceTypeToString
        : null;
    model.value!.lactationType = (lactationTypeSelected.value != null)
        ? lactationTypeSelected.value!.convertLactationTypeToSting
        : null;
    model.value!.animalType = (petTypeSelected.value != null)
        ? petTypeSelected.value!.convertPetTypeToString
        : null;
    model.value!.requirement = extraRequestsController.text;
  }

  updateServiceInfoToModel(
      Rxn<ReservationModel?> model, String serviceDuration) {
    setCarePriorityList();

    model.value!.voucher = voucherController.voucherResult.value ??
        authController.reservationModel.value!.voucher;
    model.value!.careRanking =
        (stringCarePriorityList.isNotEmpty) ? stringCarePriorityList : null;
    model.value!.placeToBeServiced = (carePlaceTypeSelected.value != null)
        ? carePlaceTypeSelected.value!.convertCarePlaceTypeToString
        : null;
    model.value!.lactationType = (lactationTypeSelected.value != null)
        ? lactationTypeSelected.value!.convertLactationTypeToSting
        : null;
    model.value!.animalType = (petTypeSelected.value != null)
        ? petTypeSelected.value!.convertPetTypeToString
        : null;
    model.value!.requirement = extraRequestsController.text;
  }

  validateButton(_info) {
    if (lactationTypeSelected.value != null &&
        carePlaceTypeSelected.value != null &&
        petTypeSelected.value != null &&
        carePriorityList.length == 4) {
      isButtonValid.value = true;
    } else {
      isButtonValid.value = false;
    }
  }
}
