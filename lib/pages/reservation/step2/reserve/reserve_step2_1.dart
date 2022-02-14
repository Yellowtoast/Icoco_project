import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/reservation/step1/address_controller.dart';

import 'package:app/controllers/reservation/step1/voucher_controller.dart';
import 'package:app/controllers/company_controller.dart';
import 'package:app/controllers/reservation/step2/substep_controllers/additional_fee_controller.dart';
import 'package:app/controllers/reservation/step2/substep_controllers/date_info_controller.dart';
import 'package:app/controllers/reservation/step2/substep_controllers/service_info_controller.dart';
import 'package:app/pages/loading.dart';

import 'package:app/pages/reservation/step1/substep_voucher/voucher_signed/voucher_signed1.dart';
import 'package:app/pages/reservation/step2/reserve/reserve_step2_1_company_no.dart';
import 'package:app/pages/reservation/step2/reserve/reserve_step2_1_company_yes.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/appbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ReserveStep2_1 extends StatelessWidget {
  ReserveStep2_1({Key? key}) : super(key: key);
  CompanyController companyController = Get.find();
  AddressController addressController = Get.find();
  VoucherController voucherController = Get.find();
  AuthController authController = Get.find();
  AdditionalFeeController additionalFeeController = Get.find();
  ServiceInfoController serviceInfoController = Get.find();
  // DateInfoController dateInfoController = Get.find();

  @override
  Widget build(BuildContext context) {
    voucherController.voucherResult.value =
        authController.reservationModel.value!.voucher;
    return Scaffold(
      backgroundColor: IcoColors.white,
      appBar: IcoAppbar(
        title: '예약하기',
        tapFunction: () async {
          await authController.setModelInfo();
          Get.offAllNamed(Routes.HOME);
        },
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Obx(() {
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 27,
              ),
              Container(
                width: IcoSize.width,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '예약 전 정보를 확인해주세요',
                      style: IcoTextStyle.boldTextStyle22B,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      '바우처 등급은 이후 변경이 불가하니 신중하게 선택해주세요',
                      style: IcoTextStyle.mediumTextStyle13P,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    EditButtonBox(
                      title: "주소",
                      contents: authController.reservationModel.value!.address,
                      onTap: () async {
                        authController.reservationModel.value!.address =
                            await Get.toNamed(Routes.ADDRESS_1,
                                arguments: "from ReserveStep1");
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    EditButtonBox(
                      title: "바우처 등급",
                      contents: voucherController.voucherResult.value!,
                      onTap: () {
                        voucherController.setDropDownList(null);
                        voucherController.setVoucherInfo(
                            voucherController.voucherResult.value, 0);
                        Get.toNamed(Routes.VOUCHER_SIGNED1,
                            arguments: {'command': '수정'});
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              DividerLineWidget(),
              SizedBox(
                height: 30,
              ),
              Container(
                width: IcoSize.width,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '이미 전화로 예약한\n산후도우미 업체가 있나요?',
                      style: IcoTextStyle.boldTextStyle22B,
                    ),
                    SizedBox(
                      height: 21,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              startLoadingIndicator();
                              await companyController
                                  .getCompanyAllDocsFirebase();
                              finishLoadingIndicator();
                              Get.toNamed(Routes.RESERVE_STEP2_COMPANY_YES);
                            },
                            child: Container(
                              height: 174,
                              decoration: BoxDecoration(
                                color: IcoColors.white,
                                border: Border.all(
                                    color: IcoColors.grey2, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'icons/yes_girl.svg',
                                    height: 71,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '네! 있어요',
                                    style: IcoTextStyle.boldTextStyle15P,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '해당 업체 찾기',
                                        style: IcoTextStyle.mediumTextStyle13B,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      SvgPicture.asset(
                                        'icons/arrow_right_filled.svg',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 19,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              startLoadingIndicator();

                              await companyController
                                  .getCompanyAllDocsFirebase();
                              finishLoadingIndicator();
                              Get.toNamed(Routes.RESERVE_STEP2_COMPANY_NO);
                            },
                            child: Container(
                              height: 174,
                              decoration: BoxDecoration(
                                color: IcoColors.white,
                                border: Border.all(
                                    color: IcoColors.grey2, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'icons/no_girl.svg',
                                    height: 71,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '아니요! 없어요',
                                    style: IcoTextStyle.boldTextStyle15P,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '파견업체 둘러보기',
                                        style: IcoTextStyle.mediumTextStyle13B,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      SvgPicture.asset(
                                        'icons/arrow_right_filled.svg',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class EditButtonBox extends StatelessWidget {
  EditButtonBox(
      {Key? key,
      required this.title,
      required this.contents,
      required this.onTap})
      : super(key: key);

  String title;
  String contents;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 83,
      decoration: BoxDecoration(
          color: IcoColors.grey1, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.fromLTRB(17, 17, 0, 17),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: IcoTextStyle.boldTextStyle13Grey4,
                    ),
                    Text(
                      contents,
                      style: IcoTextStyle.mediumTextStyle17B,
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 1,
              child: TextButton(
                style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
                onPressed: onTap,
                child: Container(
                  padding: EdgeInsets.only(right: 17),
                  alignment: Alignment.centerRight,
                  child: Text(
                    "수정",
                    style: IcoTextStyle.boldTextStyle13Grey4,
                    textAlign: TextAlign.right,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

class RadioButtonItem extends StatelessWidget {
  RadioButtonItem({
    Key? key,
    required this.mainTitle,
    this.hasSubtitle = true,
    this.hasIcon = true,
    this.subTitle = "",
    required this.itemNum,
    required this.selectedItem,
  }) : super(key: key);

  bool hasSubtitle;
  String mainTitle;
  String subTitle;
  bool hasIcon;
  int itemNum;
  Rxn<int> selectedItem;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
        onTap: () {
          selectedItem.value = itemNum;
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(17, 13, 17, 13),
          decoration: BoxDecoration(
              color: (selectedItem.value == itemNum)
                  ? IcoColors.purple1
                  : IcoColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: (selectedItem.value == itemNum)
                      ? IcoColors.primary
                      : IcoColors.grey2)),
          child: Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Container(
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        (selectedItem.value == itemNum)
                            ? SvgPicture.asset("icons/checked.svg")
                            : SvgPicture.asset("icons/unchecked.svg"),
                        SizedBox(
                          width: 9,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mainTitle,
                              style: IcoTextStyle.boldTextStyle16B,
                            ),
                            (hasSubtitle)
                                ? SizedBox(
                                    height: 3,
                                  )
                                : SizedBox(),
                            (hasSubtitle)
                                ? Text(
                                    subTitle,
                                    style: IcoTextStyle.regularTextStyle14Grey4,
                                  )
                                : Container(),
                          ],
                        ),
                      ],
                    ),
                  )),
              (hasIcon)
                  ? Expanded(
                      flex: 1,
                      child: TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
                        onPressed: () {},
                        child: Container(
                            alignment: Alignment.centerRight,
                            child: SvgPicture.asset('icons/button_arrow.svg',
                                color: IcoColors.grey3)),
                      ))
                  : SizedBox(),
            ],
          ),
        ),
      );
    });
  }
}
