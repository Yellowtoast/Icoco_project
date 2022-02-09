import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/reservation/step2/substep_controllers/date_info_controller.dart';
import 'package:app/configs/enum.dart';
import 'package:app/controllers/reservation/step2/substep_controllers/service_info_controller.dart';

import 'package:app/models/reservation.dart';
import 'package:app/pages/reservation/step1/substep_voucher/voucher_signed/voucher_signed1.dart';
import 'package:app/pages/reservation/step2/reserve/reserve_step2_5.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/button/radio_button/text_radio_button.dart';
import 'package:app/widgets/text_label/icon_text_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ReserveStep2_4 extends StatelessWidget {
  ReserveStep2_4({Key? key}) : super(key: key);
  ServiceInfoController serviceController = Get.find();
  AuthController authController = Get.find();
  String orderNum = "two";
  @override
  Widget build(BuildContext context) {
    Rxn<ReservationModel?> reservationModel = authController.reservationModel;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: IcoColors.white,
        appBar: IcoAppbar(
          title: '예약하기',
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                      '예약시 추가요청사항을\n아이코코에게 전달해주세요',
                      style: IcoTextStyle.boldTextStyle22B,
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    Column(
                      children: [
                        IconTextLabel(
                          text: "수유형태",
                          icon: SvgPicture.asset("icons/lactarion_icon.svg"),
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: IcoColors.grey2)),
                          child: Row(
                            children: [
                              TextRadioButton(
                                item: lactationType.BREAST_FEEDING,
                                itemTitle: "모유",
                                selectedItem:
                                    serviceController.lactationTypeSelected,
                                radiusTopRight: false,
                                radiusBottomRight: false,
                                hasBorder: false,
                                onTap: () {
                                  serviceController.lactationTypeSelected
                                      .value = lactationType.BREAST_FEEDING;
                                },
                              ),
                              OptionDividerLine(),
                              TextRadioButton(
                                item: lactationType.BOTTLE_FEEDING,
                                itemTitle: "분유",
                                selectedItem:
                                    serviceController.lactationTypeSelected,
                                radiusTopRight: false,
                                radiusBottomRight: false,
                                radiusTopLeft: false,
                                radiusBottomLeft: false,
                                hasBorder: false,
                                onTap: () {
                                  serviceController.lactationTypeSelected
                                      .value = lactationType.BOTTLE_FEEDING;
                                },
                              ),
                              OptionDividerLine(),
                              TextRadioButton(
                                item: lactationType.MIX_FEEDING,
                                itemTitle: "혼합형",
                                radiusTopLeft: false,
                                radiusBottomLeft: false,
                                hasBorder: false,
                                selectedItem:
                                    serviceController.lactationTypeSelected,
                                onTap: () {
                                  serviceController.lactationTypeSelected
                                      .value = lactationType.MIX_FEEDING;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 28,
              ),
              DividerLineWidget(),
              SizedBox(
                height: 28,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        IconTextLabel(
                          text: "조리장소",
                          icon: SvgPicture.asset("icons/home_icon.svg"),
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: IcoColors.grey2)),
                          child: Row(
                            children: [
                              TextRadioButton(
                                item: carePlaceType.OWN_HOUSE,
                                itemTitle: "자가",
                                selectedItem:
                                    serviceController.carePlaceTypeSelected,
                                radiusTopRight: false,
                                radiusBottomRight: false,
                                hasBorder: false,
                                onTap: () {
                                  serviceController.carePlaceTypeSelected
                                      .value = carePlaceType.OWN_HOUSE;
                                },
                              ),
                              OptionDividerLine(),
                              TextRadioButton(
                                item: carePlaceType.PARENTS_HOUSE,
                                itemTitle: "친정댁",
                                selectedItem:
                                    serviceController.carePlaceTypeSelected,
                                radiusTopRight: false,
                                radiusBottomRight: false,
                                radiusTopLeft: false,
                                radiusBottomLeft: false,
                                hasBorder: false,
                                onTap: () {
                                  serviceController.carePlaceTypeSelected
                                      .value = carePlaceType.PARENTS_HOUSE;
                                },
                              ),
                              OptionDividerLine(),
                              TextRadioButton(
                                item: carePlaceType.IN_LAW_HOUSE,
                                itemTitle: "시댁",
                                radiusTopLeft: false,
                                radiusBottomLeft: false,
                                hasBorder: false,
                                selectedItem:
                                    serviceController.carePlaceTypeSelected,
                                onTap: () {
                                  serviceController.carePlaceTypeSelected
                                      .value = carePlaceType.IN_LAW_HOUSE;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 28,
              ),
              DividerLineWidget(),
              SizedBox(
                height: 28,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        IconTextLabel(
                          text: "애완동물",
                          icon: SvgPicture.asset("icons/pet_icon.svg"),
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: IcoColors.grey2)),
                          child: Row(
                            children: [
                              TextRadioButton(
                                item: petType.DOG,
                                itemTitle: "강아지",
                                selectedItem: serviceController.petTypeSelected,
                                radiusTopRight: false,
                                radiusBottomRight: false,
                                hasBorder: false,
                                onTap: () {
                                  serviceController.petTypeSelected.value =
                                      petType.DOG;
                                  serviceController.setPetType();
                                },
                              ),
                              OptionDividerLine(),
                              TextRadioButton(
                                item: petType.CAT,
                                itemTitle: "고양이",
                                selectedItem: serviceController.petTypeSelected,
                                radiusTopRight: false,
                                radiusBottomRight: false,
                                radiusTopLeft: false,
                                radiusBottomLeft: false,
                                hasBorder: false,
                                onTap: () {
                                  serviceController.petTypeSelected.value =
                                      petType.CAT;
                                  serviceController.setPetType();
                                },
                              ),
                              OptionDividerLine(),
                              TextRadioButton(
                                item: petType.ETC,
                                itemTitle: "기타",
                                radiusTopRight: false,
                                radiusBottomRight: false,
                                radiusTopLeft: false,
                                radiusBottomLeft: false,
                                hasBorder: false,
                                selectedItem: serviceController.petTypeSelected,
                                onTap: () {
                                  serviceController.petTypeSelected.value =
                                      petType.ETC;
                                  serviceController.setPetType();
                                },
                              ),
                              OptionDividerLine(),
                              TextRadioButton(
                                item: petType.NONE,
                                itemTitle: "없음",
                                radiusTopLeft: false,
                                radiusBottomLeft: false,
                                hasBorder: false,
                                selectedItem: serviceController.petTypeSelected,
                                onTap: () {
                                  serviceController.petTypeSelected.value =
                                      petType.NONE;
                                  serviceController.setPetType();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 28,
              ),
              DividerLineWidget(),
              SizedBox(
                height: 28,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconTextLabel(text: "선호순위"),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      "중요도 순서대로 눌러 순위를 정할 수 있습니다.\n해당 선호순위를 파악해 업체가 적합한 도우미를 추천합니다.",
                      style: IcoTextStyle.mediumTextStyle13P,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        OrderSelectionButton(
                          width: IcoSize.width / 2 - 20 - 4,
                          onTap: () {
                            //  serviceController.carePriorityList();
                            serviceController.carePriorityButtonController(
                                carePriority.CLEANING);
                          },
                          icon: SvgPicture.asset("icons/cleaning_icon.svg"),
                          selectionList: serviceController.carePriorityList,
                          selectionType: carePriority.CLEANING,
                          text: '정리정돈',
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        OrderSelectionButton(
                          width: IcoSize.width / 2 - 20 - 4,
                          onTap: () {
                            serviceController.carePriorityButtonController(
                                carePriority.COOKING);
                          },
                          icon: SvgPicture.asset("icons/cooking_icon.svg"),
                          selectionList: serviceController.carePriorityList,
                          selectionType: carePriority.COOKING,
                          text: '요리',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        OrderSelectionButton(
                          width: IcoSize.width / 2 - 20 - 4,
                          onTap: () {
                            serviceController.carePriorityButtonController(
                                carePriority.MOTHERCARE);
                          },
                          icon:
                              SvgPicture.asset("icons/mother_caring_icon.svg"),
                          selectionList: serviceController.carePriorityList,
                          selectionType: carePriority.MOTHERCARE,
                          text: '산모케어',
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        OrderSelectionButton(
                          width: IcoSize.width / 2 - 20 - 4,
                          onTap: () {
                            serviceController.carePriorityButtonController(
                                carePriority.BABYCARE);
                          },
                          icon: SvgPicture.asset("icons/baby_caring_icon.svg"),
                          selectionList: serviceController.carePriorityList,
                          selectionType: carePriority.BABYCARE,
                          text: '신생아케어',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 28,
              ),
              DividerLineWidget(),
              SizedBox(
                height: 28,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "기타 요청 사항",
                        style: IcoTextStyle.boldTextStyle15B,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        height: 163,
                        padding: EdgeInsets.fromLTRB(17, 9, 17, 9),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: IcoColors.grey2,
                              width: 1,
                            )),
                        child: TextField(
                          controller: serviceController.extraRequestsController,
                          keyboardType: TextInputType.multiline,
                          style: IcoTextStyle.mediumTextStyle13B,
                          minLines: 10,
                          maxLines: 20,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 74,
                      ),
                      IcoButton(
                          onPressed: () {
                            if (reservationModel.value!.isFinishedDeposit ==
                                    "입금완료" ||
                                reservationModel.value!.isBirth != true) {
                              Get.toNamed(Routes.RESERVE_STEP2_6);
                            } else {
                              Get.toNamed(Routes.RESERVE_STEP2_5);
                            }
                          },
                          active: serviceController.isButtonValid,
                          textStyle: IcoTextStyle.buttonTextStyleW,
                          text: "제출하기"),
                      SizedBox(
                        height: 20,
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderSelectionButton extends StatelessWidget {
  OrderSelectionButton({
    Key? key,
    required this.selectionType,
    required this.selectionList,
    required this.icon,
    required this.text,
    required this.onTap,
    this.width,
    this.height,
  }) : super(key: key);

  Enum selectionType;
  RxList<dynamic> selectionList;
  Widget icon;
  String text;
  void Function()? onTap;
  double? width;
  double? height;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              height: height ?? 92,
              width: width ?? double.maxFinite,
              decoration: BoxDecoration(
                color: IcoColors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: IcoColors.grey2,
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  icon,
                  SizedBox(
                    height: 5,
                  ),
                  Text(text, style: IcoTextStyle.mediumTextStyle16B)
                ],
              ),
            ),
            Visibility(
              visible: (selectionList.contains(selectionType)) ? true : false,
              child: Positioned.fill(
                child: Container(
                  padding: EdgeInsets.all(26),
                  child: SvgPicture.asset(
                    "icons/${selectionList.indexOf(selectionType) + 1}.svg",
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}

class OptionDividerLine extends StatelessWidget {
  const OptionDividerLine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 50,
      color: IcoColors.grey2,
    );
  }
}
