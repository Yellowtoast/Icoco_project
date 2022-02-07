import 'package:app/configs/colors.dart';
import 'package:app/configs/enum.dart';
import 'package:app/controllers/reservation/step2/substep_controllers/birth_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

showDatePickerPop(
  BuildContext context,
  datePickerType pickerType,
  Rxn<DateTime> dateTime,
  Rx<bool> dateSelected,
  DateTime? initialDate,
  Rx<bool> stepFinished,
) {
  var dateFormatForApp = DateFormat('yyyy-MM-dd');
  var dateFormatForDB = DateFormat('yyyy.MM.dd');

  DateInfoController birthInfoController = Get.put(DateInfoController());
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
      dateTime.value = null;
      dateSelected.value = false;
      stepFinished.value = false;
    } else {
      dateTime.value = date;
      dateSelected.value = true;
      stepFinished.value = true;
    }

    birthInfoController.isStepsFinished();
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