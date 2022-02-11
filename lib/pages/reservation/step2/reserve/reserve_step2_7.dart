import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/reservation/step1/voucher_controller.dart';
import 'package:app/controllers/reservation/step2/substep_controllers/date_info_controller.dart';
import 'package:app/controllers/reservation/step2/substep_controllers/service_info_controller.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/cost_info_selection_box.dart';
import 'package:app/widgets/dropdown/voucher_dropdown.dart';
import 'package:app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:app/configs/enum.dart';

class ReserveStep2_7 extends StatelessWidget {
  ReserveStep2_7({Key? key}) : super(key: key);
  VoucherController voucherController = Get.find();
  ServiceInfoController serviceInfoController = Get.find();
  DateInfoController dateInfoController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: IcoButton(
            width: IcoSize.width - 40,
            onPressed: () async {
              Get.toNamed(Routes.RESERVE_STEP2_REGISTERED);
            },
            active: true.obs,
            textStyle: IcoTextStyle.buttonTextStyleW,
            text: "다음으로"),
        backgroundColor: IcoColors.white,
        appBar: IcoAppbar(
          title: "예약하기",
          usePop: true,
        ),
        body: Obx(() {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 27,
                    ),
                    Text(
                      "바우처 등급을 확인해주세요",
                      style: IcoTextStyle.boldTextStyle24B,
                    ),
                    SizedBox(
                      height: 19,
                    ),
                    SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                            child: VoucherDropdown(
                              dropDownList: voucherController.voucherType1List,
                              selectedVoucherType:
                                  voucherController.voucherType1,
                              selectedTextStyle:
                                  IcoTextStyle.mediumTextStyle16B,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: VoucherDropdown(
                              dropDownList: voucherController.voucherType2List,
                              selectedVoucherType:
                                  voucherController.voucherType2,
                              selectedTextStyle:
                                  IcoTextStyle.mediumTextStyle16B,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: VoucherDropdown(
                              dropDownList: voucherController.voucherType3List,
                              selectedVoucherType:
                                  voucherController.voucherType3,
                              selectedTextStyle:
                                  IcoTextStyle.mediumTextStyle16B,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CheckBoxText(
                      onTap: () {
                        if (voucherController.isVoucherUsed.value == true) {
                          voucherController.isVoucherUsed.value = false;
                        } else {
                          voucherController.isVoucherUsed.value = true;
                        }
                      },
                      isChecked:
                          (voucherController.isVoucherUsed.value == false)
                              ? false.obs
                              : true.obs,
                      iconChecked: "icons/check.svg",
                      iconUnchecked: "icons/unchecked.svg",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              DividerLineWidget(),
              (voucherController.showResult.value == false)
                  ? Container(
                      alignment: Alignment.center,
                      height: 80,
                      width: double.infinity,
                      child: Text(
                        "등급 유형을 모두 선택하시면 요금이 표시됩니다.",
                        style: IcoTextStyle.mediumTextStyle15Grey4,
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              dateInfoController.serviceDurationInt.value,
                          itemBuilder: (BuildContext context, int index) {
                            late serviceDurationType durationType;

                            switch (index) {
                              case 0:
                                durationType = serviceDurationType.ONEWEEK;
                                break;
                              case 1:
                                durationType = serviceDurationType.TWOWEEK;
                                break;
                              case 2:
                                durationType = serviceDurationType.THREEWEEK;
                                break;
                              case 3:
                                durationType = serviceDurationType.FOURWEEK;
                                break;
                              case 4:
                                durationType = serviceDurationType.FIVEWEEK;
                                break;
                              default:
                            }
                            print(durationType);
                            return Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    serviceInfoController
                                        .voucherUseDurationSelected
                                        .value = durationType;
                                  },
                                  child: CostInfoSelectionBox(
                                    feeTypeIndex: index,
                                    isVoucherUsed: (voucherController
                                                .isVoucherUsed.value ==
                                            true)
                                        ? false.obs
                                        : true.obs,
                                    totalFee: voucherController.totalFeeList,
                                    userFee: voucherController.userFeeList,
                                    govermentFee:
                                        voucherController.govermentFeeList,
                                    depositFee:
                                        voucherController.depositFeeList,
                                    remainingFee:
                                        voucherController.remainingFeeList,
                                    title: "${index + 1}주 사용",
                                    titleStyle: IcoTextStyle.boldTextStyle18B,
                                    dateType: durationType.obs,
                                    useDateSelected: serviceInfoController
                                        .voucherUseDurationSelected,
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
              // : Container(
              //     alignment: Alignment.center,
              //     height: 40,
              //     width: double.infinity,
              //     child: Text(
              //       "등급 유형을 모두 선택하시면 요금이 표시됩니다.",
              //       style: IcoTextStyle.mediumTextStyle15Grey4,
              //     ),
              //   ),
              SizedBox(
                height: 80,
              )
            ],
          );
        }));
  }
}

class CheckBoxText extends StatelessWidget {
  CheckBoxText(
      {Key? key,
      required this.iconUnchecked,
      required this.iconChecked,
      required this.isChecked,
      this.onTap})
      : super(key: key);

  void Function()? onTap;
  String iconUnchecked;
  String iconChecked;
  String? text;
  Rx<bool> isChecked;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset((isChecked.value) ? iconChecked : iconUnchecked),
            SizedBox(
              width: 9,
            ),
            Text(
              "바우처를 사용하지 않습니다",
              style: IcoTextStyle.mediumTextStyle16B,
            ),
          ],
        ),
      );
    });
  }
}
