import 'package:app/configs/colors.dart';

import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/manager_controller.dart';
import 'package:app/controllers/home_controller.dart';
import 'package:app/controllers/voucher_controller.dart';

import 'package:app/helpers/date_calculator.dart';
import 'package:app/pages/reservation/step3/remaining_fee_status.dart';
import 'package:app/pages/reservation/step1/substep_address/address1.dart';
import 'package:app/pages/reservation/step2/reserve/reserve_step2_1.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/button/grey_border_button.dart';
import 'package:app/widgets/modal/result_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../widgets/button/contents_button/costinfo_select_button.dart';
import '../mypage/my_reservation.dart';
import 'home_step8.dart';

class HomeStep5Items_2 extends StatelessWidget {
  HomeStep5Items_2({Key? key}) : super(key: key);
  AuthController authController = Get.find();
  HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(17),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: IcoColors.grey1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset("icons/calander_icon.svg"),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "서비스 일정",
                          style: IcoTextStyle.boldTextStyle15B,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    // InkWell(
                    //   child: Text(
                    //     "수정",
                    //     style: IcoTextStyle.mediumTextStyle13Grey4,
                    //   ),
                    // )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(thickness: 1),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        "서비스 시작일",
                        style: IcoTextStyle.mediumTextStyle12Grey4,
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Text(
                        "${homeController.reservationModel.value!.serviceStartDate}",
                        style: IcoTextStyle.mediumTextStyle15Grey4,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        "배정 예정일",
                        style: IcoTextStyle.mediumTextStyle12Grey4,
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${calcCertainDateBefore(5, homeController.reservationModel.value!.serviceStartDate!).toString()} ~ ${homeController.reservationModel.value!.serviceStartDate}",
                            style: IcoTextStyle.mediumTextStyle15B,
                          ),
                          Text(
                            "서비스시작일 3~5일 전 배정됩니다",
                            style: IcoTextStyle.mediumTextStyle12P,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          BorderButton(
            textStyle: IcoTextStyle.mediumTextStyle15B,
            borderColor: IcoColors.grey2,
            onTap: () {
              Get.to(MyReservationPage());
            },
            width: double.infinity,
          ),
          SizedBox(
            width: 10,
          )
        ],
      );
    });
  }
}
