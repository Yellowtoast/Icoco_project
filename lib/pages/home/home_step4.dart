import 'package:app/configs/colors.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/company_controller.dart';
import 'package:app/helpers/formatter.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/home_controller.dart';
import 'package:app/pages/guide_page/fee_guide.dart';
import 'package:app/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/button/contents_button/costinfo_select_button.dart';

class HomeStep4Items extends StatelessWidget {
  HomeStep4Items({Key? key}) : super(key: key);
  HomeController homeController = Get.find();
  CompanyController companyController = Get.find();
  AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                (homeController.reservationModel.value!.voucher!.contains("일반"))
                    ? ""
                    : "바우처 ",
                style: IcoTextStyle.boldTextStyle15P,
              ),
              Text(
                "${homeController.reservationModel.value!.voucher} (${homeController.reservationModel.value!.serviceDuration})",
                style: IcoTextStyle.boldTextStyle15P,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("총 요금", style: IcoTextStyle.mediumTextStyle13Grey4),
              Text(
                  "${numFormat.format(homeController.reservationModel.value!.totalCost)} 원",
                  style: IcoTextStyle.mediumTextStyle16Grey3),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("정부지원금", style: IcoTextStyle.mediumTextStyle13Grey4),
              Text(
                  "${numFormat.format(homeController.reservationModel.value!.revenueCost)} 원",
                  style: IcoTextStyle.mediumTextStyle16Grey3),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          DividerLineWidget(height: 1, color: IcoColors.grey2),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("본인부담금", style: IcoTextStyle.mediumTextStyle13Grey4),
              Text(
                  "${numFormat.format(homeController.reservationModel.value!.userCost)} 원",
                  style: IcoTextStyle.boldTextStyle18B),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          Container(
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: IcoColors.purple1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "예약금",
                      style: IcoTextStyle.mediumTextStyle13Grey4,
                    ),
                    const SizedBox(
                      width: 11,
                    ),
                    Text(
                      "${numFormat.format(homeController.reservationModel.value!.depositCost)} 원 입금",
                      style: IcoTextStyle.lineBoldTextStyle15Grey4,
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "잔금",
                      style: IcoTextStyle.mediumTextStyle13P,
                    ),
                    const SizedBox(
                      width: 11,
                    ),
                    Text(
                      "${numFormat.format(homeController.reservationModel.value!.balanceCost! - homeController.reservationModel.value!.completedBalanceCost!)} 원 미입금",
                      style: IcoTextStyle.boldTextStyle15P,
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: IcoButton(
                    height: 50,
                    buttonColor: IcoColors.grey4,
                    onPressed: () {
                      Get.to(FeeGuidePages());
                    },
                    active: true.obs,
                    textStyle: IcoTextStyle.buttonTextStyleW,
                    text: "요금 안내"),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: IcoButton(
                    onPressed: () async {
                      companyController.companyModel.value =
                          await companyController.getFirebaseCompanyByUid(
                              authController
                                  .reservationModel.value!.chosenCompany!);
                      Get.toNamed(Routes.REMAINING_STATUS);
                    },
                    height: 50,
                    active: true.obs,
                    textStyle: IcoTextStyle.buttonTextStyleW,
                    text: "입금 알리기"),
              ),
            ],
          )
        ],
      );
    });
  }
}
