import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/reservation/step2/substep_controllers/date_info_controller.dart';
import 'package:app/configs/enum.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/button/datepicker_button.dart';
import 'package:app/widgets/button/radio_button/text_radio_button.dart';
import 'package:app/widgets/datepicker.dart';
import 'package:app/widgets/dropdown/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ReserveStep2_3_BeforeBirth extends StatelessWidget {
  ReserveStep2_3_BeforeBirth({Key? key}) : super(key: key);
  DateInfoController dateInfoController = Get.put(DateInfoController());
  AuthController authController = Get.find();

  List<String> careCenterDurationList = [
    '1주',
    '2주',
    '3주',
    '4주',
    '5주',
    '6주',
    '7주',
    '8주'
  ];
  Rx<bool> step1 = false.obs;
  Rx<bool> step2 = false.obs;
  Rx<bool> step3 = false.obs;
  Rx<bool> step4 = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IcoColors.white,
      appBar: IcoAppbar(
        title: '예약하기',
        usePop: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Obx(
          () {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 27,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: IcoSize.height - 210,
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
                            "출산예정일",
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
                                  step1,
                                  null);
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
                                selectedItem:
                                    dateInfoController.useCareCenterSelected,
                                onTap: () {
                                  authController.reservationModel.value!
                                      .useCareCenter = true;
                                  dateInfoController.useCareCenterSelected
                                      .value = usageType.YES;

                                  step2.value = true;
                                  step3.value = false;
                                },
                              ),
                              SizedBox(width: 7),
                              TextRadioButton(
                                item: usageType.NO,
                                itemTitle: "이용안함",
                                selectedItem:
                                    dateInfoController.useCareCenterSelected,
                                onTap: () {
                                  authController.reservationModel.value!
                                      .useCareCenter = false;
                                  dateInfoController.careCenterDuration.value =
                                      null;
                                  dateInfoController.useCareCenterSelected
                                      .value = usageType.NO;
                                  step2.value = true;
                                  step3.value = true;
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      (dateInfoController.useCareCenterSelected.value ==
                              usageType.YES)
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 24,
                                ),
                                Container(
                                  width: IcoSize.width - 40,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: IcoColors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: IcoColors.grey2, width: 1),
                                  ),
                                  child: DropdownButton<String>(
                                    iconSize: 0,
                                    hint: Text(
                                      '조리원 이용기간',
                                      style: IcoTextStyle.mediumTextStyle16G,
                                    ),
                                    value: dateInfoController
                                        .careCenterDuration.value,
                                    style: IcoTextStyle.mediumTextStyle16B,
                                    underline: Container(height: 0),
                                    onChanged: (String? newValue) {
                                      dateInfoController
                                          .careCenterDuration.value = newValue;
                                      step3.value = true;
                                    },
                                    items: careCenterDurationList
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        alignment: Alignment.centerLeft,
                                        value: value,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              value,
                                              style: IcoTextStyle
                                                  .mediumTextStyle16B,
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            )
                          : SizedBox(),
                      SizedBox(
                        height: 24,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "아이코코 서비스 이용기간",
                            style: IcoTextStyle.labelTextStyle,
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          IgnorePointer(
                            ignoring: (authController.reservationModel.value!
                                        .serviceDuration ==
                                    null)
                                ? false
                                : true,
                            child: IcoDropDown(
                              onChanged: (String? newValue) {
                                dateInfoController
                                    .serviceDurationSelected.value = newValue;

                                step4.value = true;
                              },
                              hintText: "이용주수를 선택해주세요",
                              dropDownList:
                                  dateInfoController.serviceDurationTypeList,
                              selectedValue:
                                  dateInfoController.serviceDurationSelected,
                              selectedTextStyle:
                                  IcoTextStyle.mediumTextStyle16B,
                              stepFinished: step4,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: IcoSize.height - (IcoSize.height - 210) - 160,
                  child: IcoButton(
                      width: IcoSize.width - 40,
                      onPressed: () {
                        // dateInfoController.setServiceEndDate(
                        //     dateInfoController.serviceDurationSelected.value);

                        Get.toNamed(Routes.RESERVE_STEP2_5);
                      },
                      active: (step1.value &&
                              step2.value &&
                              step3.value &&
                              step4.value)
                          ? true.obs
                          : false.obs,
                      textStyle: IcoTextStyle.buttonTextStyleW,
                      text: "다음으로"),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
