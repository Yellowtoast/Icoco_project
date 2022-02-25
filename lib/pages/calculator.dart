import 'package:app/configs/colors.dart';
import 'package:app/configs/constants.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/calculator_controller.dart';
import 'package:app/controllers/home_controller.dart';
import 'package:app/controllers/reservation/step1/address_controller.dart';
import 'package:app/helpers/url_launcher.dart';
import 'package:app/pages/reservation/step1/substep_address/address2.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/button/radio_button/text_radio_button2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalculatorPage extends StatelessWidget {
  CalculatorPage({Key? key}) : super(key: key);
  CalculatorController calculatorController = Get.put(CalculatorController());
  HomeController homeController = Get.find();
  AddressController addressController = Get.put(AddressController());

  String numberWithComma(int param) {
    return NumberFormat('###,###,###,###,###,###,###,###,###').format(param);
  }

  @override
  Widget build(BuildContext context) {
    addressController.reservationModel = homeController.reservationModel;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Obx(() {
        return Scaffold(
          backgroundColor: IcoColors.white,
          appBar: IcoAppbar(title: '요금계산기', usePop: false),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 27,
                        ),
                        Text(
                          '정부지원\n산후도우미 요금계산기',
                          style: IcoTextStyle.boldTextStyle22B,
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          "아래 내용을 입력하시면 정부지원\n산후도우미 지원사항을 알 수 있습니다",
                          style: IcoTextStyle.mediumTextStyle13Grey4,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Text("가구원수", style: IcoTextStyle.boldTextStyle13B),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: IcoColors.grey2,
                          width: 1,
                        )),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: TextField(
                            onChanged: (value) {
                              calculatorController.familyNumber =
                                  int.tryParse(value);
                              (value == '')
                                  ? calculatorController.stepList[0] = false.obs
                                  : calculatorController.stepList[0] = true.obs;
                              // calculatorController.stepList.refresh();
                            },
                            keyboardType: TextInputType.number,
                            controller:
                                calculatorController.familyNumberTextController,
                            maxLength: 1,
                            style: IcoTextStyle.mediumTextStyle16B,
                            decoration: InputDecoration(
                                counterText: '',
                                border: InputBorder.none,
                                hintText: "가구원수",
                                hintStyle: IcoTextStyle.mediumTextStyle16Grey3),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Text("인",
                                textAlign: TextAlign.right,
                                style: IcoTextStyle.mediumTextStyle16B)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("보험 가입 유형",
                                style: IcoTextStyle.boldTextStyle13B),
                            SizedBox(
                              height: 9,
                            ),
                            Row(
                              children: [
                                TextRadioButton2(
                                  isMultiple: false,
                                  item: calculatorController.insuranceType[0],
                                  selectedItem: calculatorController
                                      .insuranceTypeSelected,
                                  activeTextStyle:
                                      IcoTextStyle.mediumTextStyle14P,
                                  inactiveTextStyle:
                                      IcoTextStyle.mediumTextStyle14B,
                                  radiusBottomRight: false,
                                  radiusTopRight: false,
                                  stepList: calculatorController.stepList,
                                  stepNum: 1,
                                ),
                                TextRadioButton2(
                                  isMultiple: false,
                                  item: calculatorController.insuranceType[1],
                                  selectedItem: calculatorController
                                      .insuranceTypeSelected,
                                  activeTextStyle:
                                      IcoTextStyle.mediumTextStyle14P,
                                  inactiveTextStyle:
                                      IcoTextStyle.mediumTextStyle14B,
                                  radiusBottomRight: false,
                                  radiusTopRight: false,
                                  radiusBottomLeft: false,
                                  radiusTopLeft: false,
                                  horizontalBorder: false,
                                  stepList: calculatorController.stepList,
                                  stepNum: 1,
                                ),
                                TextRadioButton2(
                                  isMultiple: false,
                                  item: calculatorController.insuranceType[2],
                                  selectedItem: calculatorController
                                      .insuranceTypeSelected,
                                  activeTextStyle:
                                      IcoTextStyle.mediumTextStyle14P,
                                  inactiveTextStyle:
                                      IcoTextStyle.mediumTextStyle14B,
                                  radiusBottomLeft: false,
                                  radiusTopLeft: false,
                                  stepList: calculatorController.stepList,
                                  stepNum: 1,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  Text("건강보험료 본인부담금", style: IcoTextStyle.boldTextStyle13B),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: IcoColors.grey2,
                          width: 1,
                        )),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: TextFormField(
                            onChanged: (value) {
                              String valueWithoutComma = value;
                              String newValue = value;
                              if (value != '') {
                                valueWithoutComma = value.replaceAll(',', '');
                                calculatorController.insuranceFee =
                                    int.parse(valueWithoutComma);
                                newValue = numberWithComma(
                                    int.parse(valueWithoutComma));
                              }

                              calculatorController.insuranceFeeTextController
                                  .value = TextEditingValue(
                                text: newValue,
                                selection: TextSelection.fromPosition(
                                  TextPosition(offset: newValue.length),
                                ),
                              );

                              (value == '')
                                  ? calculatorController.stepList[2] = false.obs
                                  : calculatorController.stepList[2] = true.obs;

                              // calculatorController.stepList.refresh();
                            },
                            keyboardType: TextInputType.number,
                            controller:
                                calculatorController.insuranceFeeTextController,
                            maxLength: 25,
                            style: IcoTextStyle.mediumTextStyle16B,
                            decoration: InputDecoration(
                                counterText: '',
                                border: InputBorder.none,
                                hintText: "예상치입력",
                                hintStyle: IcoTextStyle.mediumTextStyle16Grey3),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Text("원",
                                textAlign: TextAlign.right,
                                style: IcoTextStyle.mediumTextStyle16B)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    height: 161,
                    width: IcoSize.width - 40,
                    decoration: BoxDecoration(
                      color: IcoColors.grey1,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'M건강보험으로 건강보험료 확인하세요',
                          style: IcoTextStyle.boldTextStyle14B,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            LinkButton(
                              iconUrl: 'icons/iphone.svg',
                              onTap: () {
                                UrlLauncher()
                                    .launchURL(UrlLauncher.INSURANCE_APP_IOS);
                              },
                              text: 'IOS',
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            LinkButton(
                              iconUrl: 'icons/android.svg',
                              onTap: () {
                                UrlLauncher().launchURL(
                                    UrlLauncher.INSURANCE_APP_ANDROID);
                              },
                              text: 'Android',
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            LinkButton(
                              iconUrl: 'icons/pc.svg',
                              onTap: () {},
                              text: 'PC',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          "IOS, ANDROID 공통\n설치후 : [보험료>개인별조회]에서 확인 가능",
                          style: IcoTextStyle.mediumTextStyle12Grey4,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  Text("거주지역", style: IcoTextStyle.boldTextStyle13B),
                  SizedBox(
                    height: 7,
                  ),
                  IcoButton(
                      icon: true,
                      border: true,
                      textAlign: MainAxisAlignment.start,
                      borderColor: IcoColors.grey2,
                      iconColor: IcoColors.grey3,
                      onPressed: () async {
                        var addressModel = await Get.to(AddressPage2(),
                            preventDuplicates: false);
                        await addressController
                            .trimAddressDataModel(addressModel);
                      },
                      active: true.obs,
                      buttonColor: (addressController.address.value == null)
                          ? IcoColors.white
                          : IcoColors.grey1,
                      textStyle: (addressController.address.value == null)
                          ? IcoTextStyle.mediumTextStyle15B
                          : IcoTextStyle.mediumTextStyle15P,
                      text: addressController.address.value ?? '거주지역'),
                  SizedBox(
                    height: 28,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("태아 유형", style: IcoTextStyle.boldTextStyle13B),
                      SizedBox(
                        height: 9,
                      ),
                      Row(
                        children: [
                          TextRadioButton2(
                            relatedItemList: [
                              calculatorController.numberOfChildSelected,
                              calculatorController.numberofHelperSelected
                            ].obs,
                            relatedStepNum: 4,
                            isMultiple: true,
                            item: calculatorController.babyType[0],
                            multipleAllowItem: calculatorController.babyType[3],
                            selectedItemList:
                                calculatorController.babyTypeSelectedList,
                            activeTextStyle: IcoTextStyle.boldTextStyle13P,
                            inactiveTextStyle: IcoTextStyle.mediumTextStyle13B,
                            stepList: calculatorController.stepList,
                            stepNum: 3,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          TextRadioButton2(
                            relatedItemList: [
                              calculatorController.numberOfChildSelected,
                              calculatorController.numberofHelperSelected
                            ].obs,
                            relatedStepNum: 4,
                            isMultiple: true,
                            item: calculatorController.babyType[1],
                            multipleAllowItem: calculatorController.babyType[3],
                            selectedItemList:
                                calculatorController.babyTypeSelectedList,
                            activeTextStyle: IcoTextStyle.boldTextStyle13P,
                            inactiveTextStyle: IcoTextStyle.mediumTextStyle13B,
                            stepList: calculatorController.stepList,
                            stepNum: 3,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      Row(
                        children: [
                          TextRadioButton2(
                            relatedItemList: [
                              calculatorController.numberOfChildSelected,
                              calculatorController.numberofHelperSelected
                            ].obs,
                            relatedStepNum: 4,
                            isMultiple: true,
                            item: calculatorController.babyType[2],
                            multipleAllowItem: calculatorController.babyType[3],
                            selectedItemList:
                                calculatorController.babyTypeSelectedList,
                            activeTextStyle: IcoTextStyle.boldTextStyle13P,
                            inactiveTextStyle: IcoTextStyle.mediumTextStyle13B,
                            stepList: calculatorController.stepList,
                            stepNum: 3,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          TextRadioButton2(
                            relatedItemList: [
                              calculatorController.numberOfChildSelected,
                              calculatorController.numberofHelperSelected
                            ].obs,
                            relatedStepNum: 4,
                            isMultiple: true,
                            item: calculatorController.babyType[3],
                            multipleAllowItem: calculatorController.babyType[3],
                            selectedItemList:
                                calculatorController.babyTypeSelectedList,
                            activeTextStyle: IcoTextStyle.boldTextStyle13P,
                            inactiveTextStyle: IcoTextStyle.mediumTextStyle13B,
                            stepList: calculatorController.stepList,
                            stepNum: 3,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  (calculatorController.babyTypeSelectedList.contains('쌍태아'))
                      ? DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            buttonWidth: IcoSize.width - 40,
                            buttonHeight: 50,
                            buttonPadding: EdgeInsets.all(10),
                            buttonDecoration: BoxDecoration(
                                color: IcoColors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: IcoColors.grey2,
                                  width: 1,
                                )),
                            style: IcoTextStyle.mediumTextStyle15B,
                            value: calculatorController
                                .numberofHelperSelected.value,
                            icon: SvgPicture.asset("icons/dropdown_arrow.svg"),
                            hint: Text(
                              '몇명의 산후도우미를 사용하실 예정인가요?',
                              style: IcoTextStyle.mediumTextStyle15Grey4,
                            ),
                            items: calculatorController.numberOfHelperType
                                .map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (item) {
                              calculatorController.numberofHelperSelected
                                  .value = item.toString();
                              (calculatorController
                                          .numberofHelperSelected.value !=
                                      null)
                                  ? calculatorController.stepList[4] = true.obs
                                  : calculatorController.stepList[4] =
                                      false.obs;
                            },
                          ),
                        )
                      : DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            buttonWidth: IcoSize.width - 40,
                            buttonHeight: 50,
                            buttonPadding: EdgeInsets.all(10),
                            buttonDecoration: BoxDecoration(
                                color: IcoColors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: IcoColors.grey2,
                                  width: 1,
                                )),
                            style: IcoTextStyle.mediumTextStyle15B,
                            value: calculatorController
                                .numberOfChildSelected.value,
                            icon: SvgPicture.asset("icons/dropdown_arrow.svg"),
                            hint: Text(
                              '이번 아이가 몇번째 아이인가요?',
                              style: IcoTextStyle.mediumTextStyle15Grey4,
                            ),
                            items: calculatorController.numberOfChildType
                                .map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (item) {
                              calculatorController.numberOfChildSelected.value =
                                  item.toString();
                              print(calculatorController.stepList);
                              (calculatorController
                                          .numberOfChildSelected.value !=
                                      null)
                                  ? calculatorController.stepList[4] = true.obs
                                  : calculatorController.stepList[4] =
                                      false.obs;
                            },
                          ),
                        ),
                  SizedBox(
                    height: 80,
                  ),
                  IcoButton(
                      onPressed: () {
                        var voucher = calculatorController.getAllVoucherCode();
                        Get.toNamed(Routes.CALCULATOR_RESULT,
                            arguments: voucher);
                      },
                      active: (calculatorController.isButtonValid.value &&
                              (calculatorController
                                          .numberofHelperSelected.value !=
                                      null ||
                                  calculatorController
                                          .numberOfChildSelected.value !=
                                      null))
                          ? true.obs
                          : false.obs,
                      textStyle: IcoTextStyle.boldTextStyle17W,
                      text: "간이요금 계산하기"),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class LinkButton extends StatelessWidget {
  LinkButton(
      {Key? key,
      required this.iconUrl,
      required this.text,
      required this.onTap})
      : super(key: key);

  String iconUrl;
  String text;
  void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: onTap,
        child: Container(
          // padding: EdgeInsets.all(20),
          height: 44,
          decoration: BoxDecoration(
            color: IcoColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: IcoColors.grey2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                iconUrl,
                height: 23,
                width: 23,
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                text,
                style: IcoTextStyle.mediumTextStyle14Grey4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
