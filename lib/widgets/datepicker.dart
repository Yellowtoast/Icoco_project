import 'package:app/configs/colors.dart';
import 'package:app/configs/enum.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/reservation/step2/substep_controllers/date_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

showDatePickerPop(
  BuildContext context,
  datePickerType pickerType,
  Rxn<DateTime> dateToBeSet,
  Rx<bool> dateSelected,
  DateTime? initialDate,
  Rx<bool> stepFinished,
  WebViewController? webViewController,
) {
  DateInfoController dateInfoController = Get.find();
  AuthController authController = Get.find();
  Future<DateTime?> selectedDate = showDatePicker(
    locale: const Locale('ko', 'KR'),
    context: context,
    initialDate: initialDate!,
    firstDate: initialDate,
    lastDate: DateTime(2090), //마지막일
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: IcoColors.primary,
          splashColor: IcoColors.primary,
        ), //다크 테마
        child: child!,
      );
    },
  );
  selectedDate.then((date) {
    if (date == null) {
      dateToBeSet.value = null;
      dateSelected.value = false;
      stepFinished.value = false;
    } else {
      dateToBeSet.value = date;
      dateSelected.value = true;
      stepFinished.value = true;
    }

    if (webViewController != null) {
      dateInfoController.setServiceEndDate(
          authController.reservationModel.value!.serviceDuration);
      webViewController.reload();
    }
    dateInfoController.isStepsFinished();
  });
}


  // switch (pickerType) {
  //     case datePickerType.BIRTH:
  //       if (date != null) {
  //         if (birthInfoController.initalDateTime.value != null) {
  //           birthInfoController.initalDateTime.value =
  //               birthInfoController.setInitialDateTime(
  //                   birthInfoController.initalDateTime.value!, date);
  //         } else {
  //           birthInfoController.initalDateTime.value = date;
  //         }

  //         dateModel.value.birthExpectedDate = dateFormatForDB.format(date);
  //         dateValue.value = dateFormatForApp.format(date);
  //         birthInfoController.step1Finished.value = true;
  //         birthInfoController.isAllStepFinished();
  //       } else {
  //         dateValue.value = null;
  //         dateModel.value!.birthExpectedDate = null;
  //       }
  //       break;
  //     case datePickerType.HOSPITAL_CHECKOUT:
  //       if (date != null) {
  //         if (birthInfoController.initalDateTime.value != null) {
  //           birthInfoController.initalDateTime.value =
  //               birthInfoController.setInitialDateTime(
  //                   birthInfoController.initalDateTime.value!, date);
  //         } else {
  //           birthInfoController.initalDateTime.value = date;
  //         }
  //         dateModel.value!.hospitalEndDate = dateFormatForDB.format(date);
  //         dateValue.value = dateFormatForApp.format(date);
  //         birthInfoController.step2Finished.value = true;
  //         birthInfoController.isAllStepFinished();
  //       } else {
  //         dateModel.value!.hospitalEndDate = null;
  //         dateValue.value = null;
  //       }
  //       break;
  //     case datePickerType.CARECENTER_CHECKOUT:
  //       if (date != null) {
  //         if (birthInfoController.initalDateTime.value != null) {
  //           birthInfoController.initalDateTime.value =
  //               birthInfoController.setInitialDateTime(
  //                   birthInfoController.initalDateTime.value!, date);
  //         } else {
  //           birthInfoController.initalDateTime.value = date;
  //         }

  //         dateModel.value!.careCenterEndDate = dateFormatForDB.format(date);
  //         dateValue.value = dateFormatForApp.format(date);
  //         birthInfoController.step3Finished.value = true;
  //         birthInfoController.isAllStepFinished();
  //       } else {
  //         dateModel.value!.careCenterEndDate = null;
  //         dateValue.value = null;
  //       }
  //       break;
  //     case datePickerType.SERVICE_START_DATE:
  //       if (date != null) {
  //         dateModel.value!.serviceStartDate = dateFormatForDB.format(date);
  //         dateValue.value = dateFormatForApp.format(date);
  //         // birthInfoController.isAllStepFinished();
  //       } else {
  //         dateModel.value!.serviceStartDate = null;
  //         dateValue.value = null;
  //       }
  //       break;

  //     default:
  //   }