import 'package:app/configs/colors.dart';

import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/home_controller.dart';

import 'package:app/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../widgets/button/grey_border_button.dart';
import '../../widgets/modal/result_modal.dart';
import '../mypage/my_reservation.dart';
import 'home_step8.dart';

class HomeStep5Items_1 extends StatelessWidget {
  HomeStep5Items_1({Key? key}) : super(key: key);
  HomeController homeController = Get.find();
  AuthController authController = Get.find();
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
                        "출산 예정일",
                        style: IcoTextStyle.mediumTextStyle12Grey4,
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Text(
                        "${homeController.reservationModel.value!.birthDate}",
                        style: IcoTextStyle.mediumTextStyle15B,
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
                      flex: 4,
                      child: Text(
                        "서비스 이용기간",
                        style: IcoTextStyle.mediumTextStyle12Grey4,
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${homeController.reservationModel.value!.serviceDuration}",
                            style: IcoTextStyle.mediumTextStyle15B,
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
        ],
      );
    });
  }
}
