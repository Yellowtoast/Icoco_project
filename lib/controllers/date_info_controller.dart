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

  Rxn<birthType> birthTypeSelected = Rxn<birthType>();
  Rxn<usageType> useCareCenterSelected = Rxn<usageType>();
  Rxn<usageType> useHospitalSelected = Rxn<usageType>();
  Rx<bool> isButtonValid = false.obs;
  Rx<bool> step1Finished = false.obs;
  Rx<bool> step2Finished = false.obs;
  Rx<bool> step3Finished = false.obs;
  Rx<bool> step4Finished = false.obs;
  Rx<bool> isBirthDateSelected = false.obs;
  Rx<bool> isHospitalDateSelected = false.obs;
  Rx<bool> isCareCenterDateSelected = false.obs;
  Rx<bool> isServiceDateSelected = false.obs;
  Rxn<String> careCenterDuration = Rxn<String>();
  List<String> serviceDurationTypeList = ['1주', '2주', '3주', '4주', '5주'];
  Rxn<String> serviceDurationSelected = Rxn<String>();

  Rxn<DateTime> serviceStartDate = Rxn<DateTime>();
  Rxn<DateTime> serviceEndDate = Rxn<DateTime>();
  Rxn<int> serviceDurationInt = Rxn<int>();
  Rx<bool> step1 = false.obs;
  Rx<bool> step2 = false.obs;
  Rx<bool> step3 = false.obs;
  Rx<bool> step4 = false.obs;

  @override
  void onInit() {
    print('date info controller init');
    super.onInit();
  }

  @override
  void onReady() {
    ever(serviceDurationSelected, serviceDurationToInt);

    super.onReady();
  }

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
    model.value!.birthDate = (birthDate.value != null)
        ? dateFormatWithDot.format(birthDate.value!)
        : null;

    //출산 후 : 병원 이용, 병원 퇴원일 선택
    if (hospitalCheckoutDate.value != null) {
      //병원 입원일은 출산일 다음날(임의지정)
      model.value!.hospitalStartDate = dateFormatWithDot
          .format(birthDate.value!.add(const Duration(days: 1)));
      model.value!.hospitalEndDate = (hospitalCheckoutDate.value != null)
          ? dateFormatWithDot.format(hospitalCheckoutDate.value!)
          : null;
    } else {
      model.value!.hospitalEndDate = null;
    }

    //출산 후 : 조리원 이용, 조리원 퇴원일 선택(조리원 예상이용주수 받지X)
    if (careCenterChekcoutDate.value != null) {
      //조리원 입원일 = 병원입원시 : 병원 퇴원일 다음날 / 병원입원 안할시 : 출산일 다음날
      model.value!.careCenterStartDate = (hospitalCheckoutDate.value == null)
          ? dateFormatWithDot
              .format(birthDate.value!.add(const Duration(days: 1)))
          : dateFormatWithDot
              .format(hospitalCheckoutDate.value!.add(const Duration(days: 1)));
      model.value!.careCenterEndDate =
          dateFormatWithDot.format(careCenterChekcoutDate.value!);
    }

    //출산 전 : 조리원 이용, 조리원 예상이용주수 선택(조리원 퇴원일 받지X)
    if (careCenterDuration.value != null &&
        careCenterChekcoutDate.value == null) {
      model.value!.careCenterDuration = careCenterDuration.value;
    } else {
      model.value!.careCenterDuration = null;
    }
    //출산 전 : 서비스 시작일 받지 않음, 서비스 이용기간(주수)데이터만 받음
    //출산 후 : 서비스 시작일 + 서비스 이용기간(주수)데이터 받음

    model.value!.serviceDuration = serviceDurationSelected.value;
    if (serviceStartDate.value != null) {
      setServiceEndDate(serviceDurationSelected.value);
      model.value!.serviceStartDate = (serviceStartDate.value != null)
          ? dateFormatWithDot.format(serviceStartDate.value!)
          : null;
      model.value!.serviceEndDate = (serviceEndDate.value != null)
          ? dateFormatWithDot.format(serviceEndDate.value!)
          : null;
    }
  }

  setServiceEndDate(String? serviceDuration) {
    if (serviceStartDate.value != null) {
      serviceEndDate.value = serviceStartDate.value!
          .add(Duration(days: serviceDurationInt.value! * 7));
    } else {
      serviceEndDate.value = null;
    }
  }

  serviceDurationToInt(serviceDurationString) {
    if (serviceDurationString != null) {
      var weekString = serviceDurationString.replaceAll('주', '');
      serviceDurationInt.value = int.parse(weekString);
      return serviceDurationInt.value;
    } else {
      return null;
    }
  }
}
