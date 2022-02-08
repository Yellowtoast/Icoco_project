import 'package:app/configs/enum.dart';
import 'package:app/helpers/formatter.dart';
import 'package:app/models/reservation.dart';
import 'package:get/get.dart';

// ignore: constant_identifier_names
enum stepType { STEP1, STEP2, STEP3 }

class DateInfoController extends GetxController {
  Rxn<DateTime> birthDate = Rxn<DateTime>();
  Rxn<DateTime> hospitalCheckoutDate = Rxn<DateTime>();
  Rxn<DateTime> careCenterChekcoutDate = Rxn<DateTime>();
  Rxn<DateTime> initialDateTime = Rxn<DateTime>();
  Rxn<DateTime> serviceStartDate = Rxn<DateTime>();
  Rxn<birthType> birthTypeSelected = Rxn<birthType>();
  Rxn<usageType> useCareCenterSelected = Rxn<usageType>();
  Rxn<usageType> useHospitalSelected = Rxn<usageType>();
  Rx<bool> isButtonValid = false.obs;
  Rx<bool> step1Finished = false.obs;
  Rx<bool> step2Finished = false.obs;
  Rx<bool> step3Finished = false.obs;
  Rx<bool> isBirthDateSelected = false.obs;
  Rx<bool> isHospitalDateSelected = false.obs;
  Rx<bool> isCareCenterDateSelected = false.obs;
  Rx<bool> isServiceDateSelected = false.obs;
  Rxn<String> careCenterDuration = Rxn<String>();

  setInitialDateTime(datePickerType dateType) {
    switch (dateType) {
      case datePickerType.BIRTH:
        break;
      case datePickerType.HOSPITAL_CHECKOUT:
        initialDateTime.value = birthDate.value!;
        break;
      case datePickerType.CARECENTER_CHECKOUT:
        if (hospitalCheckoutDate.value != null) {
          initialDateTime.value = hospitalCheckoutDate.value!;
        } else {
          initialDateTime.value = birthDate.value!;
        }
        break;
      case datePickerType.SERVICE_START_DATE:
        if (birthDate.value != null) {
          initialDateTime.value = birthDate.value;
        }
        if (hospitalCheckoutDate.value != null &&
            initialDateTime.value!.isBefore(hospitalCheckoutDate.value!)) {
          initialDateTime.value = hospitalCheckoutDate.value;
        }
        if (careCenterChekcoutDate.value != null &&
            initialDateTime.value!.isBefore(careCenterChekcoutDate.value!)) {
          initialDateTime.value = careCenterChekcoutDate.value;
        }
        break;
    }
  }

  isStep1Finished() {
    if (birthTypeSelected.value != null && birthDate.value != null) {
      step1Finished.value = true;
    } else {
      step1Finished.value = false;
    }
  }

  isStep2Finished() {
    if (useHospitalSelected.value == usageType.NO) {
      hospitalCheckoutDate.value = null;
      step2Finished.value = true;
    } else if (useHospitalSelected.value == usageType.YES &&
        hospitalCheckoutDate.value != null) {
      step2Finished.value = true;
    } else {
      step2Finished.value = false;
    }
  }

  isStep3Finished() {
    if (useCareCenterSelected.value == usageType.NO) {
      careCenterChekcoutDate.value = null;

      step3Finished.value = true;
    } else if (useCareCenterSelected.value == usageType.YES &&
        careCenterChekcoutDate.value != null) {
      step3Finished.value = true;
    } else {
      step3Finished.value = false;
    }
  }

  isStepsFinished() async {
    await isStep1Finished();
    await isStep2Finished();
    await isStep3Finished();
    if (step1Finished.value && step2Finished.value && step3Finished.value) {
      isButtonValid.value = true;
    } else {
      isButtonValid.value = false;
    }
  }

  clearSelectedInfo(Rxn<DateTime> dateSelected, dynamic optionSelected) {
    if (dateSelected.value == null) {
      optionSelected.value = null;
    } else {
      dateSelected.value = null;
      optionSelected.value = null;
    }
  }

  updateDateInfoToModel(Rxn<ReservationModel?> model) {
    model.value!.birthExpectedDate = (birthDate.value != null)
        ? dateFormatWithDot.format(birthDate.value!)
        : null;

    model.value!.hospitalEndDate = (hospitalCheckoutDate.value != null)
        ? dateFormatWithDot.format(hospitalCheckoutDate.value!)
        : null;

    model.value!.careCenterEndDate = (careCenterChekcoutDate.value != null)
        ? dateFormatWithDot.format(careCenterChekcoutDate.value!)
        : null;

    if (careCenterChekcoutDate.value != null) {
      model.value!.careCenterEndDate = dateFormatWithDot
          .format(careCenterChekcoutDate.value!.subtract(Duration(days: 21)));
    }

    model.value!.serviceStartDate = (serviceStartDate.value != null)
        ? dateFormatWithDot.format(serviceStartDate.value!)
        : null;

    model.value!.careCenterDuration =
        (careCenterDuration.value != null) ? careCenterDuration.value : null;
  }
}
