import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/manager_controller.dart';
import 'package:app/controllers/mypage_controller.dart';
import 'package:app/controllers/reservation/step1/address_controller.dart';
import 'package:app/controllers/reservation/step1/voucher_controller.dart';
import 'package:app/controllers/review_controller.dart';
import 'package:app/helpers/database.dart';
import 'package:app/configs/steps.dart';
import 'package:app/models/reservation.dart';
import 'package:app/models/user.dart';
import 'package:app/pages/home/home_step1.dart';
import 'package:app/pages/home/home_step2.dart';
import 'package:app/pages/home/home_step3.dart';
import 'package:app/pages/home/home_step4.dart';
import 'package:app/pages/home/home_step5_afterbirth.dart';
import 'package:app/pages/home/home_step5_beforebirth.dart';
import 'package:app/pages/home/home_step6.dart';
import 'package:app/pages/home/home_step7.dart';
import 'package:app/pages/home/home_step8.dart';
import 'package:app/pages/home/home_step9.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Rxn<String> reservationNumber = Rxn<String>();
  Rxn<String> userStepTitle = Rxn<String>();
  Rxn<String> userStepInfo = Rxn<String>();
  Rxn<dynamic> homeInfoModel = Rxn<dynamic>();
  Rxn<ReservationModel?> reservationModel = Rxn<ReservationModel?>();
  Rxn<UserModel?> userModel = Rxn<UserModel?>();
  // Rxn<bool> openPopup = Rxn<bool>();

  @override
  void onInit() {
    if (userModel.value == null && reservationModel.value == null) {
      setInfoFromModel();
    }

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  setInfoFromModel() {
    if (reservationBox.isEmpty == true) {
      userModel.value = userBox.get('userModel');
      homeInfoModel = userModel;
    } else {
      reservationModel.value = reservationBox.get('reservationModel');
      reservationNumber.value = reservationModel.value!.reservationNumber;

      homeInfoModel = reservationModel;
    }

    setStep();
  }

  setStep() {
    userStepTitle.value = stepTitle[homeInfoModel.value.userStep];
    if (reservationModel.value == null) {
      userStepInfo.value = stepInfo[homeInfoModel.value.userStep.toString()];
      return;
    } else {
      if (homeInfoModel.value.userStep == 3) {
        if (reservationModel.value!.isFinishedDeposit == '입금 전' &&
            reservationModel.value!.notifyDepositCost == false) {
          userStepInfo.value = stepInfo["3-1"];
        } else {
          userStepInfo.value = stepInfo["3-2"];
        }
      } else if (homeInfoModel.value.userStep == 5) {
        if (reservationModel.value!.isBirth == true) {
          userStepInfo.value = stepInfo["5-1"];
        } else {
          userStepInfo.value = stepInfo["5-2"];
        }
      } else {
        userStepInfo.value = stepInfo[homeInfoModel.value.userStep.toString()];
      }
    }
  }

  get setWidgetsForStep {
    if (homeInfoModel.value.userStep == 1) {
      return HomeStep1Items();
    } else if (homeInfoModel.value.userStep == 2) {
      return HomeStep2Items();
    } else if (homeInfoModel.value.userStep == 3) {
      return HomeStep3Items();
    } else if (homeInfoModel.value.userStep == 4) {
      return HomeStep4Items();
    } else if (homeInfoModel.value.userStep == 5) {
      if (homeInfoModel.value.isBirth == true) {
        return HomeStep5Items_2();
      } else {
        return HomeStep5Items_1();
      }
    } else if (homeInfoModel.value.userStep == 6) {
      return HomeStep6Items();
    } else if (homeInfoModel.value.userStep == 7) {
      return const HomeStep7Items();
    } else if (homeInfoModel.value.userStep == 8) {
      return const HomeStep8Items();
    } else if (homeInfoModel.value.userStep == 9) {
      return const HomeStep9Items();
    }
  }
}
