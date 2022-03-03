import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/address_controller.dart';
import 'package:app/pages/calculator/calculator.dart';
import 'package:app/widgets/loading/loading.dart';
import 'package:app/pages/reservation/step1/substep_address/address2.dart';
import 'package:app/widgets/button/bigicon_textbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../button/button.dart';

class BottomUpModal extends StatelessWidget {
  BottomUpModal({Key? key, required this.address}) : super(key: key);

  String address;

  @override
  Widget build(BuildContext context) {
    AddressController addressController = Get.put(AddressController());
    AuthController authController = Get.find();
    return Container(
      height: IcoSize.height - 100,
      decoration: BoxDecoration(
        color: IcoColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.topRight,
              child: IconButton(
                iconSize: 26,
                padding: EdgeInsets.zero,
                icon: SvgPicture.asset(
                  "icons/exit_icon.svg",
                ),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            Text(
              "산후도우미 정부지원금\n지금 바로 신청하세요!",
              style: IcoTextStyle.boldTextStyle22B,
            ),
            SizedBox(
              height: 13,
            ),
            Text(
              "[복지로] 웹사이트를 방문 또는 인근 보건소를 방문하시어\n[산모 신생아 건강관리 서비스]를 신청하세요",
              style: IcoTextStyle.mediumTextStyle14B,
            ),
            SizedBox(
              height: 41,
            ),
            Text("현재 입력주소", style: IcoTextStyle.boldTextStyle13B),
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
                  var addressModel =
                      await Get.to(AddressPage2(), preventDuplicates: false);
                  addressController.trimAddressDataModel(addressModel);
                },
                active: true.obs,
                buttonColor: IcoColors.grey1,
                textStyle: IcoTextStyle.mediumTextStyle15P,
                text: addressController.address.value!),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: BigIconTextButton(
                    icon: SvgPicture.asset(
                      "icons/public_health_building.svg",
                      width: 84,
                    ),
                    mainLabel: "보건소 현장신청",
                    subLabel: "안내보기",
                  ),
                ),
                SizedBox(
                  width: 19,
                ),
                Expanded(
                  child: BigIconTextButton(
                    icon: SvgPicture.asset(
                      "icons/computer.svg",
                      width: 72,
                    ),
                    mainLabel: "온라인 신청",
                    subLabel: "안내보기",
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 33,
            ),
            Expanded(
              child: Container(
                // margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IcoButton(
                        icon: false,
                        iconColor: IcoColors.white,
                        onPressed: () async {
                          Get.to(CalculatorPage());
                        },
                        active: true.obs,
                        buttonColor: IcoColors.primary,
                        textStyle: IcoTextStyle.buttonTextStyleW,
                        text: "요금계산기"),
                    SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await authController.setModelInfo();
                        Get.offAllNamed(Routes.HOME);
                      },
                      child: Text.rich(
                        TextSpan(
                          text: "메인화면으로 이동",
                          style: IcoTextStyle.mediumLinedTextStyle14G,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
