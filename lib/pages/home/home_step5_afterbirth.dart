import 'package:app/configs/colors.dart';

import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/manager_controller.dart';
import 'package:app/controllers/home_controller.dart';
import 'package:app/controllers/reservation/step1/voucher_controller.dart';
import 'package:app/controllers/reservation_controller.dart';
import 'package:app/helpers/calc_date.dart';
import 'package:app/pages/reservation/step3/remaining_fee_status.dart';
import 'package:app/pages/reservation/step1/substep_address/address1.dart';
import 'package:app/pages/reservation/step2/reserve/reserve_step2_1.dart';
import 'package:app/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../widgets/cost_info_selection_box.dart';

class HomeStep5Items_2 extends StatelessWidget {
  const HomeStep5Items_2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();

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
          Row(
            children: [
              Expanded(
                child: IcoButton(
                    height: 50,
                    buttonColor: IcoColors.white,
                    onPressed: () {},
                    active: true.obs,
                    border: true,
                    borderColor: IcoColors.grey2,
                    textStyle: IcoTextStyle.regularTextStyle14B,
                    text: "내 예약정보 보기"),
              ),
            ],
          )
        ],
      );
    });
  }
}
