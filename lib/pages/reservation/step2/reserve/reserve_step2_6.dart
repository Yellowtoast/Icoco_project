import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/reservation/step1/voucher_controller.dart';
import 'package:app/controllers/reservation/step2/substep_controllers/date_info_controller.dart';
import 'package:app/configs/enum.dart';

import 'package:app/models/reservation.dart';
import 'package:app/pages/reservation/step1/substep_voucher/voucher_signed/voucher_signed1.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/button/datepicker_button.dart';
import 'package:app/widgets/datepicker.dart';
import 'package:app/widgets/dropdown/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReserveStep2_6 extends StatelessWidget {
  ReserveStep2_6({Key? key}) : super(key: key);

  Rx<bool> step1 = false.obs;
  Rx<bool> step2 = false.obs;
  @override
  Widget build(BuildContext context) {
    DateInfoController dateInfoController = Get.find();
    AuthController authController = Get.find();
    Rxn<ReservationModel?> reservationModel = authController.reservationModel;
    VoucherController voucherController = Get.find();
    dateInfoController.serviceDurationSelected.value =
        authController.reservationModel.value!.serviceDuration;

    return Scaffold(
        backgroundColor: IcoColors.white,
        appBar: IcoAppbar(title: '예약하기'),
        body: Obx(() {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 27,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '산후도우미 서비스 일자를\n입력해주세요',
                      style: IcoTextStyle.boldTextStyle24B,
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      "일정은 이후에 파견업체와 상담하여 변경할 수 있습니다.",
                      style: IcoTextStyle.mediumTextStyle13Grey4,
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "서비스 시작일",
                          style: IcoTextStyle.labelTextStyle,
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        DatePickerButton(
                          date: dateInfoController.serviceStartDate,
                          onTap: () {
                            dateInfoController.setInitialDateTime(
                                datePickerType.SERVICE_START_DATE);
                            showDatePickerPop(
                                context,
                                datePickerType.SERVICE_START_DATE,
                                dateInfoController.serviceStartDate,
                                dateInfoController.isServiceDateSelected,
                                dateInfoController.initialDateTime.value,
                                step1);
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "이용기간",
                          style: IcoTextStyle.labelTextStyle,
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        IgnorePointer(
                          ignoring:
                              (reservationModel.value!.serviceDuration == null)
                                  ? false
                                  : true,
                          child: IcoDropDown(
                            onChanged: (String? newValue) {
                              dateInfoController.serviceDurationSelected.value =
                                  newValue;
                              dateInfoController.setServiceEndDate(newValue);
                              step2.value = true;
                            },
                            hintText: "이용주수를 선택해주세요",
                            dropDownList:
                                dateInfoController.serviceDurationTypeList,
                            selectedValue:
                                dateInfoController.serviceDurationSelected,
                            selectedTextStyle:
                                (reservationModel.value!.serviceDuration ==
                                        null)
                                    ? IcoTextStyle.mediumTextStyle16B
                                    : IcoTextStyle.mediumTextStyle16Grey4,
                            stepFinished: step2,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 27,
              ),
              DividerLineWidget(),
              SizedBox(
                height: 27,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IcoButton(
                          onPressed: () {
                            if (authController.reservationModel.value != null &&
                                authController
                                        .reservationModel.value!.voucher !=
                                    null &&
                                authController.reservationModel.value!
                                        .serviceDuration !=
                                    null) {
                              dateInfoController.serviceDurationInt.value =
                                  dateInfoController.serviceDurationToInt(
                                      authController.reservationModel.value!
                                          .serviceDuration!);
                              voucherController.voucherResult.value =
                                  authController
                                      .reservationModel.value!.serviceDuration;
                            }

                            if (reservationModel.value!.isBirth != true) {
                              Get.toNamed(Routes.RESERVE_STEP2_REGISTERED);
                            } else {
                              Get.toNamed(Routes.RESERVE_STEP2_7);
                            }
                          },
                          active: (dateInfoController.serviceStartDate.value !=
                                  null)
                              ? true.obs
                              : false.obs,
                          textStyle: IcoTextStyle.buttonTextStyleW,
                          text: "다음으로"),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        }));
  }
}
