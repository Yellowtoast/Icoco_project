import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/reservation/step2/substep_controllers/date_info_controller.dart';
import 'package:app/configs/enum.dart';

import 'package:app/pages/reservation/step1/substep_voucher/voucher_signed/voucher_signed1.dart';
import 'package:app/pages/reservation/step2/reserve/reserve_step2_4.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/button/datepicker_button.dart';
import 'package:app/widgets/button/radio_button/text_radio_button.dart';
import 'package:app/widgets/datepicker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ReserveStep2_3_AfterBirth extends StatelessWidget {
  ReserveStep2_3_AfterBirth({Key? key}) : super(key: key);
  DateInfoController dateInfoController = Get.put(DateInfoController());
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    Rx<bool> step1 = false.obs;
    Rx<bool> step2 = false.obs;
    Rx<bool> step3 = false.obs;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          backgroundColor: IcoColors.white,
          appBar: IcoAppbar(
            title: '예약하기',
            tapFunction: () {
              authController.setModelInfo();
              Get.back();
            },
          ),
          body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Obx(() {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 27,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset("icons/mother_human.svg"),
                          Text(
                            '${authController.reservationModel.value!.userName} 산모님의\n출산정보를 입력해주세요',
                            style: IcoTextStyle.boldTextStyle24B,
                          ),
                          SizedBox(
                            height: 23,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "출산일",
                                style: IcoTextStyle.labelTextStyle,
                              ),
                              SizedBox(
                                height: 9,
                              ),
                              DatePickerButton(
                                date: dateInfoController.birthDate,
                                onTap: () async {
                                  dateInfoController
                                      .setInitialDateTime(datePickerType.BIRTH);
                                  await showDatePickerPop(
                                      context,
                                      datePickerType.BIRTH,
                                      dateInfoController.birthDate,
                                      dateInfoController.isBirthDateSelected,
                                      DateTime.now(),
                                      step1);
                                  dateInfoController.clearSelectedInfo(
                                      dateInfoController.hospitalCheckoutDate,
                                      dateInfoController.useHospitalSelected);
                                  dateInfoController.clearSelectedInfo(
                                      dateInfoController.careCenterChekcoutDate,
                                      dateInfoController.useCareCenterSelected);
                                  dateInfoController.isStepsFinished();
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
                                "출산형태",
                                style: IcoTextStyle.labelTextStyle,
                              ),
                              SizedBox(
                                height: 9,
                              ),
                              Row(
                                children: [
                                  TextRadioButton(
                                    item: birthType.NATURAL,
                                    itemTitle: "자연분만",
                                    selectedItem:
                                        dateInfoController.birthTypeSelected,
                                    onTap: () {
                                      authController.reservationModel.value!
                                          .birthType = "자연분만";
                                      dateInfoController.birthTypeSelected
                                          .value = birthType.NATURAL;
                                      dateInfoController.clearSelectedInfo(
                                          dateInfoController
                                              .hospitalCheckoutDate,
                                          dateInfoController
                                              .useHospitalSelected);
                                      dateInfoController.clearSelectedInfo(
                                          dateInfoController
                                              .careCenterChekcoutDate,
                                          dateInfoController
                                              .useCareCenterSelected);
                                      dateInfoController.isStepsFinished();
                                    },
                                  ),
                                  SizedBox(width: 7),
                                  TextRadioButton(
                                    item: birthType.CAESAREAN,
                                    itemTitle: "제왕절개",
                                    selectedItem:
                                        dateInfoController.birthTypeSelected,
                                    onTap: () {
                                      authController.reservationModel.value!
                                          .birthType = "제왕절개";
                                      dateInfoController.birthTypeSelected
                                          .value = birthType.CAESAREAN;
                                      dateInfoController.clearSelectedInfo(
                                          dateInfoController
                                              .hospitalCheckoutDate,
                                          dateInfoController
                                              .useHospitalSelected);
                                      dateInfoController.clearSelectedInfo(
                                          dateInfoController
                                              .careCenterChekcoutDate,
                                          dateInfoController
                                              .useCareCenterSelected);
                                      dateInfoController.isStepsFinished();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    DividerLineWidget(),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (dateInfoController.step1Finished.value)
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "병원입원",
                                      style: IcoTextStyle.labelTextStyle,
                                    ),
                                    SizedBox(
                                      height: 9,
                                    ),
                                    Row(
                                      children: [
                                        TextRadioButton(
                                          item: usageType.YES,
                                          itemTitle: "이용함",
                                          selectedItem: dateInfoController
                                              .useHospitalSelected,
                                          onTap: () {
                                            authController.reservationModel
                                                .value!.useHospital = true;
                                            dateInfoController
                                                .useHospitalSelected
                                                .value = usageType.YES;
                                            dateInfoController
                                                .clearSelectedInfo(
                                                    dateInfoController
                                                        .careCenterChekcoutDate,
                                                    dateInfoController
                                                        .useCareCenterSelected);

                                            dateInfoController
                                                .isStepsFinished();
                                          },
                                        ),
                                        SizedBox(width: 7),
                                        TextRadioButton(
                                          item: usageType.NO,
                                          itemTitle: "이용안함",
                                          selectedItem: dateInfoController
                                              .useHospitalSelected,
                                          onTap: () {
                                            authController.reservationModel
                                                .value!.useHospital = false;
                                            authController.reservationModel
                                                .value!.hospitalEndDate = null;
                                            dateInfoController
                                                .useHospitalSelected
                                                .value = usageType.NO;
                                            dateInfoController
                                                .clearSelectedInfo(
                                                    dateInfoController
                                                        .careCenterChekcoutDate,
                                                    dateInfoController
                                                        .useCareCenterSelected);
                                            dateInfoController
                                                .isStepsFinished();
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : InactivePickerWidget(
                                  index: "병원입원",
                                  button1Title: "이용함",
                                  button2Title: "이용안함"),
                          (dateInfoController.useHospitalSelected.value ==
                                  usageType.YES)
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 24,
                                    ),
                                    Text(
                                      "퇴원일",
                                      style: IcoTextStyle.labelTextStyle,
                                    ),
                                    SizedBox(
                                      height: 9,
                                    ),
                                    DatePickerButton(
                                      date: dateInfoController
                                          .hospitalCheckoutDate,
                                      onTap: () async {
                                        dateInfoController.setInitialDateTime(
                                            datePickerType.HOSPITAL_CHECKOUT);
                                        await showDatePickerPop(
                                            context,
                                            datePickerType.HOSPITAL_CHECKOUT,
                                            dateInfoController
                                                .hospitalCheckoutDate,
                                            dateInfoController
                                                .isHospitalDateSelected,
                                            dateInfoController
                                                .initialDateTime.value,
                                            step2);
                                        dateInfoController.clearSelectedInfo(
                                            dateInfoController
                                                .careCenterChekcoutDate,
                                            dateInfoController
                                                .useCareCenterSelected);
                                      },
                                    ),
                                  ],
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    DividerLineWidget(),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (dateInfoController.step2Finished.value)
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "조리원 이용",
                                      style: IcoTextStyle.labelTextStyle,
                                    ),
                                    SizedBox(
                                      height: 9,
                                    ),
                                    Row(
                                      children: [
                                        TextRadioButton(
                                          item: usageType.YES,
                                          itemTitle: "이용함",
                                          selectedItem: dateInfoController
                                              .useCareCenterSelected,
                                          onTap: () {
                                            authController.reservationModel
                                                .value!.useCareCenter = true;
                                            dateInfoController
                                                .useCareCenterSelected
                                                .value = usageType.YES;
                                            dateInfoController
                                                .serviceStartDate.value = null;
                                            dateInfoController
                                                .isStepsFinished();
                                          },
                                        ),
                                        SizedBox(width: 7),
                                        TextRadioButton(
                                          item: usageType.NO,
                                          itemTitle: "이용안함",
                                          selectedItem: dateInfoController
                                              .useCareCenterSelected,
                                          onTap: () {
                                            authController.reservationModel
                                                .value!.useCareCenter = false;
                                            authController
                                                .reservationModel
                                                .value!
                                                .careCenterEndDate = null;
                                            dateInfoController
                                                .useCareCenterSelected
                                                .value = usageType.NO;
                                            dateInfoController
                                                .serviceStartDate.value = null;
                                            dateInfoController
                                                .isStepsFinished();
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : InactivePickerWidget(
                                  index: "조리원 이용",
                                  button1Title: "이용함",
                                  button2Title: "이용안함"),
                          (dateInfoController.useCareCenterSelected.value ==
                                  usageType.YES)
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 24,
                                    ),
                                    Text(
                                      "퇴원일",
                                      style: IcoTextStyle.labelTextStyle,
                                    ),
                                    SizedBox(
                                      height: 9,
                                    ),
                                    DatePickerButton(
                                      date: dateInfoController
                                          .careCenterChekcoutDate,
                                      onTap: () async {
                                        dateInfoController.setInitialDateTime(
                                            datePickerType.CARECENTER_CHECKOUT);
                                        await showDatePickerPop(
                                            context,
                                            datePickerType.CARECENTER_CHECKOUT,
                                            dateInfoController
                                                .careCenterChekcoutDate,
                                            dateInfoController
                                                .isCareCenterDateSelected,
                                            dateInfoController
                                                .initialDateTime.value,
                                            step3);
                                        dateInfoController
                                            .serviceStartDate.value = null;
                                      },
                                    ),
                                  ],
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 77,
                          ),
                          IcoButton(
                              onPressed: () {
                                // reservationController
                                //     .updateReservationFirestore();
                                Get.toNamed(Routes.RESERVE_STEP2_4);
                              },
                              active: dateInfoController.isButtonValid,
                              textStyle: IcoTextStyle.buttonTextStyleW,
                              text: "다음으로"),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }))),
    );
  }
}

class InactivePickerWidget extends StatelessWidget {
  InactivePickerWidget(
      {Key? key,
      required this.index,
      required this.button1Title,
      required this.button2Title})
      : super(key: key);
  String index;
  String button1Title;
  String button2Title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              index,
              style: IcoTextStyle.labelTextStyle,
            ),
            SizedBox(
              height: 9,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    decoration: BoxDecoration(
                      color: IcoColors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: IcoColors.grey2,
                        width: 1,
                      ),
                    ),
                    child: Text(button1Title,
                        style: IcoTextStyle.mediumTextStyle16Grey3),
                  ),
                ),
                SizedBox(width: 7),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    decoration: BoxDecoration(
                      color: IcoColors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: IcoColors.grey2,
                        width: 1,
                      ),
                    ),
                    child: Text(button2Title,
                        style: IcoTextStyle.mediumTextStyle16Grey3),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
