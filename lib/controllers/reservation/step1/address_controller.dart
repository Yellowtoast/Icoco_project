// ignore_for_file: avoid_print

import 'package:app/models/reservation.dart';
import 'package:daum_postcode_search/data_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  RxBool isButtonValid = false.obs;
  Rxn<String> completeAddress = Rxn<String>();
  Rxn<String> address = Rxn<String>();
  Rxn<String> sido = Rxn<String>();
  Rxn<String> gungu = Rxn<String>();
  Rxn<String> dongEupMyeon = Rxn<String>();
  Rxn<String> additionalAddress = Rxn<String>();
  DataModel? addressModel;
  Rxn<TextEditingController> addressTextController =
      Rxn<TextEditingController>();
  Rxn<ReservationModel?> reservationModel = Rxn<ReservationModel>();
  @override
  void onInit() async {
    getAddress(reservationModel);
  }

  trimAddressDataModel(model) async {
    address.value = model.jibunAddress;
    if (kDebugMode) {
      print(address);
    }
    sido.value = model.sido;
    if (kDebugMode) {
      print(sido.value);
    }
    gungu.value = modifyGunguFormat(model.sigungu);
    if (kDebugMode) {
      print(gungu.value);
    }
    dongEupMyeon.value = modifyDongEupLeeFormat(model.jibunAddress);
    if (kDebugMode) {
      print(dongEupMyeon.value);
    }
  }

  String modifyGunguFormat(address) {
    List<String>? addressStrList = address.split(" ");
    String gungu = '';

    for (var element in addressStrList!) {
      if (element.contains("군") || element.contains("구")) {
        gungu = element;
      }
    }
    return gungu;
  }

  String modifyDongEupLeeFormat(address) {
    List<String>? addressStrList = address.split(" ");
    String dongEupMyeon = '';

    for (var element in addressStrList!) {
      if (element.contains("동") ||
          element.contains("면") ||
          element.contains("읍")) {
        dongEupMyeon = element;
      }
    }
    return dongEupMyeon;
  }

  setCompleteAddress() {
    completeAddress.value = address.value! + "/" + additionalAddress.value!;
  }

  updateAddressToModel(Rxn<dynamic> model) {
    model.value.address = completeAddress.value;
  }

  getAddress(Rxn<ReservationModel?> reservationModel) {
    if (reservationModel.value == null) {
      address.value = null;
    } else {
      address.value = reservationModel.value!.address;
    }
  }
}
