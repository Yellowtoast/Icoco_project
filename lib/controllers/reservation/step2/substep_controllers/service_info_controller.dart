import 'package:app/configs/enum.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/reservation/step1/voucher_controller.dart';
import 'package:app/controllers/reservation/step2/substep_controllers/additional_fee_controller.dart';
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
  Rxn<lactationType> lactationTypeSelected = Rxn<lactationType>();
  Rxn<carePlaceType> carePlaceTypeSelected = Rxn<carePlaceType>();
  Rxn<serviceDurationType> useDurationSelected = Rxn<serviceDurationType>();
  TextEditingController extraRequestsController = TextEditingController();
  Rxn<petType> petTypeSelected = Rxn<petType>();
  Rx<bool> isButtonValid = false.obs;
  Rx<int> priorityNum = 0.obs;
  List<String> serviceDurationTypeList = ['1주', '2주', '3주', '4주', '5주'];
  Rxn<String> serviceDurationSelected = Rxn<String>();
  Rxn<DateTime> serviceStartDate = Rxn<DateTime>();
  Rxn<DateTime> serviceEndDate = Rxn<DateTime>();
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

  setServiceCost() {
    late int listIndex;
    switch (useDurationSelected.value) {
      case serviceDurationType.ONEWEEK:
        listIndex = 0;
        break;
      case serviceDurationType.TWOWEEK:
        listIndex = 1;
        break;
      case serviceDurationType.THREEWEEK:
        listIndex = 2;
        break;
      case serviceDurationType.FOURWEEK:
        listIndex = 2;
        break;
      case serviceDurationType.FIVEWEEK:
        listIndex = 2;
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
    // reservationController.reservationModel.value!.extraCost =
    //     additionalFeeController.totalAdditionalFee;
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
        stringCarePriorityList.add(element.convertCarePriorityToString);
      });
    }
  }

  setServiceEndDate(String? serviceDuration) {
    int serviceDurationInt;
    var weekString = serviceDuration!.replaceAll('주', '');

    if (serviceStartDate.value != null) {
      serviceDurationInt = int.parse(weekString);
      serviceEndDate.value =
          serviceStartDate.value!.add(Duration(days: serviceDurationInt * 7));
    } else {
      serviceEndDate.value = null;
    }
  }

  updateServiceInfoToModel(Rxn<ReservationModel?> model) async {
    await setServiceCost();
    await setCarePriorityList();
    await setServiceEndDate(serviceDurationSelected.value);

    model.value!.voucher = voucherController.voucherResult.value!;
    model.value!.serviceDuration =
        useDurationSelected.value!.convertDurationTypeToString;
    model.value!.serviceStartDate = (serviceStartDate.value != null)
        ? dateFormatWithDot.format(serviceStartDate.value!)
        : null;
    model.value!.serviceEndDate = (serviceEndDate.value != null)
        ? dateFormatWithDot.format(serviceEndDate.value!)
        : null;
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
    model.value!.extraRequests = extraRequestsController.text;
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
