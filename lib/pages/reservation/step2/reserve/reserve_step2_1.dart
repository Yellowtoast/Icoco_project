import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/home_controller.dart';
import 'package:app/controllers/reservation/step1/address_controller.dart';

import 'package:app/controllers/reservation/step1/voucher_controller.dart';
import 'package:app/controllers/reservation/step2/substep_controllers/company_controller.dart';

import 'package:app/pages/reservation/step1/substep_voucher/voucher_signed/voucher_signed1.dart';

import 'package:app/pages/reservation/step2/reserve/reserve_step2_2.dart';
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
                margin: const EdgeInsets.symmetric(horizontal: 20),
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
                      onTap: () async {
                        await voucherController.getVoucherCostInfo(
                            authController.reservationModel.value!.voucher!);

                        // voucherController.voucherResult.value =
                        //     await Get.toNamed(Routes.VOUCHER_SIGNED1,
                        //         arguments: {'command': '수정'});

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
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '원하는 업체를 선택해주세요',
                      style: IcoTextStyle.boldTextStyle22B,
                    ),
                    SizedBox(
                      height: 21,
                    ),
                    ListView.builder(
                      itemCount: 4,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return (companyController.companyList[index]
                                    ["address"] !=
                                null)
                            ? Column(
                                children: [
                                  RadioButtonItem(
                                      itemNum: index,
                                      selectedItem:
                                          companyController.companySelected,
                                      mainTitle: companyController
                                              .companyList[index]["title"] ??
                                          "",
                                      subTitle: companyController
                                              .companyList[index]["address"] ??
                                          ""),
                                  SizedBox(
                                    height: 14,
                                  ),
                                ],
                              )
                            : RadioButtonItem(
                                itemNum: index,
                                selectedItem: companyController.companySelected,
                                mainTitle: companyController.companyList[index]
                                        ["title"] ??
                                    "",
                                hasSubtitle: false,
                                hasIcon: false,
                              );
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: IcoButton(
                          onPressed: () async {
                            companyController.updateCompanyToModel(
                                authController.reservationModel);

                            Get.toNamed(Routes.RESERVE_STEP2_2);
                          },
                          active:
                              (companyController.companySelected.value != null)
                                  ? true.obs
                                  : false.obs,
                          buttonColor: IcoColors.primary,
                          textStyle: IcoTextStyle.buttonTextStyleW,
                          text: "다음으로"),
                    ),
                    SizedBox(
                      height: 20,
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
