import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/home_controller.dart';
import 'package:app/controllers/reservation/step1/address_controller.dart';

import 'package:app/controllers/reservation/step1/voucher_controller.dart';
import 'package:app/controllers/reservation/step2/substep_controllers/company_controller.dart';
import 'package:app/controllers/review_controller.dart';
import 'package:app/pages/company/company_detail.dart';

import 'package:app/pages/reservation/step1/substep_voucher/voucher_signed/voucher_signed1.dart';

import 'package:app/pages/reservation/step2/reserve/reserve_step2_2.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/appbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../loading.dart';

class ReserveStep2_1_No extends StatelessWidget {
  ReserveStep2_1_No({Key? key}) : super(key: key);
  CompanyController companyController = Get.find();
  AddressController addressController = Get.find();
  VoucherController voucherController = Get.find();
  AuthController authController = Get.find();
  ReviewController reviewController = Get.find();

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
                      '파견업체를 선택해주세요',
                      style: IcoTextStyle.boldTextStyle22B,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      '해당 리스트를 클릭히사면 세부정보를 확인할 수 있습니다.',
                      style: IcoTextStyle.mediumTextStyle13P,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: (135) *
                          companyController.companyModelList.length.toDouble(),
                      child: ListView.builder(
                        itemCount: companyController.companyModelList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Container(
                                height: 111,
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: IcoColors.grey2, width: 1),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: SizedBox(
                                            width: 89,
                                            height: 89,
                                            child: Image.network(
                                              companyController
                                                      .companyModelList[index]
                                                      .value!
                                                      .thumbnail ??
                                                  'https://t1.daumcdn.net/cfile/tistory/2446863653FC18972F',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text.rich(
                                              TextSpan(
                                                text:
                                                    "${companyController.companyModelList[index].value!.companyName}\n",
                                                style: IcoTextStyle
                                                    .boldTextStyle19B,
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: companyController
                                                          .companyModelList[
                                                              index]
                                                          .value!
                                                          .address
                                                          .split("/")[0],
                                                      style: IcoTextStyle
                                                          .mediumTextStyle12Grey4),
                                                ],
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(
                                              height: 7,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 63,
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 1,
                                                          color:
                                                              IcoColors.grey2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SvgPicture.asset(
                                                        'icons/star_full.svg',
                                                        height: 15,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        (companyController
                                                                    .companyModelList[
                                                                        index]
                                                                    .value!
                                                                    .totalReviewRate ==
                                                                0)
                                                            ? "0"
                                                            : "${(companyController.companyModelList[index].value!.totalReviewRate! ~/ companyController.companyModelList[index].value!.totalReview!).toDouble()}",
                                                        style: IcoTextStyle
                                                            .regularTextStyle12B,
                                                      ),
                                                      SizedBox(
                                                        width: 2,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 11,
                                                ),
                                                Container(
                                                  width: 63,
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 1,
                                                          color:
                                                              IcoColors.grey2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "리뷰 ${companyController.companyModelList[index].value!.totalReview!}+",
                                                        style: IcoTextStyle
                                                            .regularTextStyle12Grey4,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.to(CompanyDetailPage(),
                                            arguments: 0);
                                      },
                                      child: SizedBox(
                                        width: 50,
                                        height: double.infinity,
                                        child: SizedBox(
                                          child: SvgPicture.asset(
                                            'icons/button_arrow.svg',
                                            color: IcoColors.grey3,
                                            width: 16,
                                            fit: BoxFit.none,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 14,
                              ),
                            ],
                          );
                          /*         : RadioButtonItem(
                                  height: 80,
                                  itemNum: index,
                                  selectedItem:
                                      companyController.companySelected,
                                  mainTitle: companyController
                                          .companyList[index]["title"] ??
                                      "",
                                  hasSubtitle: false,
                                  hasIcon: false,
                                  onTapArrow: () {},
                                );
                                */
                        },
                      ),
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
    this.height = 80,
    required this.itemNum,
    required this.selectedItem,
    required this.onTapArrow,
  }) : super(key: key);

  bool hasSubtitle;
  String mainTitle;
  String subTitle;
  bool hasIcon;
  int itemNum;
  Rxn<int> selectedItem;
  double height;
  void Function() onTapArrow;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
        onTap: () {
          selectedItem.value = itemNum;
        },
        child: Container(
          height: height,
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
                        onPressed: onTapArrow,
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
