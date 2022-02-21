import 'dart:io';

import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/reservation/step1/voucher_controller.dart';
import 'package:app/controllers/reservation/step2/substep_controllers/additional_fee_controller.dart';
import 'package:app/controllers/reservation/step2/substep_controllers/date_info_controller.dart';
import 'package:app/configs/enum.dart';
import 'package:app/controllers/reservation/step2/substep_controllers/service_info_controller.dart';

import 'package:app/models/reservation.dart';
import 'package:app/pages/reservation/step1/substep_voucher/voucher_signed/voucher_signed1.dart';
import 'package:app/pages/reservation/step2/reserve/reserve_step2_7_novoucher.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/button/datepicker_button.dart';
import 'package:app/widgets/datepicker.dart';
import 'package:app/widgets/dropdown/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../helpers/formatter.dart';

class ReserveStep2_6 extends StatelessWidget {
  ReserveStep2_6({Key? key}) : super(key: key);

  Rx<bool> step1 = false.obs;
  Rx<bool> step2 = false.obs;

  DateInfoController dateInfoController = Get.find();
  ServiceInfoController serviceInfoController = Get.find();
  AdditionalFeeController additionalFeeController = AdditionalFeeController();
  AuthController authController = Get.find();
  VoucherController voucherController = Get.find();
  WebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    if (authController.reservationModel.value!.serviceDuration != null) {
      dateInfoController.serviceDurationSelected.value =
          authController.reservationModel.value!.serviceDuration;
    }

    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }

    return Scaffold(
        backgroundColor: IcoColors.white,
        appBar: IcoAppbar(title: '예약하기'),
        body: Obx(() {
          return SingleChildScrollView(
            child: SafeArea(
              child: Column(
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
                                    step1,
                                    webViewController);
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
                              ignoring: (authController.reservationModel.value!
                                          .serviceDuration ==
                                      null)
                                  ? false
                                  : true,
                              child: IcoDropDown(
                                onChanged: (String? newValue) {
                                  dateInfoController
                                      .serviceDurationSelected.value = newValue;
                                  dateInfoController
                                      .setServiceEndDate(newValue);
                                  step2.value = true;
                                  webViewController!.reload();
                                },
                                hintText: "이용주수를 선택해주세요",
                                dropDownList:
                                    dateInfoController.serviceDurationTypeList,
                                selectedValue:
                                    dateInfoController.serviceDurationSelected,
                                selectedTextStyle: (authController
                                            .reservationModel
                                            .value!
                                            .serviceDuration ==
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
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 480,
                        child: WebView(
                          initialUrl:
                              'https://icoco2022-erpweb.vercel.app/calendar',
                          onWebViewCreated: (controller) {
                            this.webViewController = controller;
                            print('webview created');
                          },
                          onPageStarted: (String url) {
                            print('webview page started loading: $url');
                          },
                          onPageFinished: (String url) {
                            print('webview page finished loading: $url');
                            print(dateFormatWithDot
                                .format(dateInfoController.birthDate.value!));

                            print(dateFormatWithDot.format(dateInfoController
                                .hospitalCheckoutDate.value!));
                            print(dateFormatWithDot.format(dateInfoController
                                .careCenterChekcoutDate.value!));
                            print(dateFormatWithDot.format(
                                dateInfoController.serviceStartDate.value!));
                            print(dateFormatWithDot.format(
                                dateInfoController.serviceEndDate.value!));

                            dateFormatWithDot.format(
                                dateInfoController.hospitalCheckoutDate.value!);

                            webViewController!.runJavascriptReturningResult(
                                "postMessage(JSON.stringify({'birthExpectedDate': '${dateInfoController.birthDate.value == null ? '' : dateFormatWithDot.format(dateInfoController.birthDate.value!)}','careCenterEndDate': '${dateInfoController.careCenterChekcoutDate.value == null ? '' : dateFormatWithDot.format(dateInfoController.careCenterChekcoutDate.value!)}', 'careCenterStartDate': '', 'dispatchExpectedDate': '${dateInfoController.serviceStartDate.value == null ? '' : dateFormatWithDot.format(dateInfoController.serviceStartDate.value!)}', 'hospitalEndDate': '${dateInfoController.hospitalCheckoutDate.value == null ? '' : dateFormatWithDot.format(dateInfoController.hospitalCheckoutDate.value!)}', 'serviceEndDate': '${dateInfoController.serviceEndDate.value == null ? '' : dateFormatWithDot.format(dateInfoController.serviceEndDate.value!)}'}));");
                          },
                          javascriptMode: JavascriptMode.unrestricted,
                        ),
                      ),
                      IcoButton(
                          width: IcoSize.width - 40,
                          onPressed: () {
                            if (authController
                                    .reservationModel.value!.userStep >
                                2) {
                              Get.toNamed(Routes.RESERVE_STEP2_FINISHED);
                            } else {
                              if (authController
                                      .reservationModel.value!.voucher ==
                                  '일반서비스') {
                                voucherController.setVoucherInfo(
                                    voucherController.voucherResult.value,
                                    additionalFeeController.totalAdditionalFee);
                                Get.to(ReserveStep2_7_Novoucher());
                              } else {
                                additionalFeeController = Get.find();

                                voucherController.voucherResult.value =
                                    authController
                                        .reservationModel.value!.voucher;
                                voucherController.setDropDownList(null);
                                voucherController.setVoucherInfo(
                                    voucherController.voucherResult.value,
                                    additionalFeeController.totalAdditionalFee);
                                Get.toNamed(Routes.RESERVE_STEP2_7,
                                    preventDuplicates: false);
                              }
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
                  )
                ],
              ),
            ),
          );
        }));
  }
}
