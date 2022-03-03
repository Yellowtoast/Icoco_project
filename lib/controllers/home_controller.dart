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
import 'package:get/get.dart';

class HomeController extends GetxController {
  Rxn<String> reservationNumber = Rxn<String>();
  Rxn<String> userStepTitle = Rxn<String>();
  Rxn<String> userStepInfo = Rxn<String>();
  Rxn<dynamic> homeInfoModel = Rxn<dynamic>();
  Rxn<ReservationModel?> reservationModel = Rxn<ReservationModel?>();
  Rxn<UserModel?> userModel = Rxn<UserModel?>();
  RxInt noticeLength = 0.obs;
  RxInt eventLength = 0.obs;
  RxInt totalInfoLength = 0.obs;
  RxInt userStep = 1.obs;

  @override
  void onInit() {
    if (userModel.value == null && reservationModel.value == null) {
      setInfoFromModel();
    }

    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  setNoticeEventCount(int allNoticeNum, int allEventNum) {
    noticeLength.value = (allNoticeNum > 2) ? 2 : allNoticeNum;
    eventLength.value = (allEventNum > 3) ? 3 : allEventNum;
    totalInfoLength.value = allNoticeNum + allEventNum;
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

    userStep.value = homeInfoModel.value.userStep;
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
      return HomeStep7Items();
    } else if (homeInfoModel.value.userStep == 8) {
      return HomeStep8Items();
    } else if (homeInfoModel.value.userStep == 9) {
      return HomeStep9Items();
    }
  }
}
