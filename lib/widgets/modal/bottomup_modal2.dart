import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/address_controller.dart';
import 'package:app/widgets/loading/loading.dart';
import 'package:app/pages/reservation/step1/substep_address/address2.dart';
import 'package:app/widgets/button/bigicon_textbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../button/button.dart';

Future<dynamic> BottomUpModal2({
  required String title,
  String subtitle = "",
  String buttonText = '',
  required void Function() onTap,
}) {
  return Get.bottomSheet(
      Container(
        height: 263,
        decoration: BoxDecoration(
          color: IcoColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding: EdgeInsets.only(right: 20, top: 15),
                child: Container(
                  alignment: Alignment.centerRight,
                  child: SvgPicture.asset(
                    "icons/exit_icon.svg",
                  ),
                ),
              ),
            ),
            Text(
              title,
              style: IcoTextStyle.boldTextStyle22B,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              subtitle,
              style: IcoTextStyle.mediumTextStyle14B,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 31,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IcoButton(
                    width: IcoSize.width - 40,
                    icon: false,
                    iconColor: IcoColors.white,
                    onPressed: onTap,
                    active: true.obs,
                    buttonColor: IcoColors.primary,
                    textStyle: IcoTextStyle.buttonTextStyleW,
                    text: buttonText),
              ],
            ),
          ],
        ),
      ),
      barrierColor: Colors.black38,
      isDismissible: false);
}
