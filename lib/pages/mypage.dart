import 'package:app/configs/colors.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/pages/edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MyPage extends StatelessWidget {
  MyPage({Key? key}) : super(key: key);
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: IcoSize.width,
            height: IcoSize.height / 3.3,
            color: IcoColors.primary,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    "images/empty_profile.png",
                    width: 89,
                    height: 89,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${authController.homeModel.value.userName}님',
                  style: IcoTextStyle.boldTextStyle22W,
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  '${authController.homeModel.value.email}',
                  style: IcoTextStyle.mediumTextStyle15W,
                )
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          InkWell(
            onTap: () {
              Get.to(EditUserInfoPage());
            },
            child: SizedBox(
              height: 55,
              width: IcoSize.width - 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '내 정보 수정하기',
                    style: IcoTextStyle.mediumTextStyle15B,
                  ),
                  SvgPicture.asset('icons/arrow_right1.svg')
                ],
              ),
            ),
          ),
          Divider(
            color: IcoColors.grey2,
            height: 1,
          ),
          InkWell(
            child: SizedBox(
              height: 55,
              width: IcoSize.width - 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '나의 신청내역',
                    style: IcoTextStyle.mediumTextStyle15B,
                  ),
                  SvgPicture.asset('icons/arrow_right1.svg')
                ],
              ),
            ),
          ),
          Divider(
            color: IcoColors.grey2,
            height: 1,
          ),
          InkWell(
            child: SizedBox(
              height: 55,
              width: IcoSize.width - 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '평가/후기관리',
                    style: IcoTextStyle.mediumTextStyle15B,
                  ),
                  SvgPicture.asset('icons/arrow_right1.svg')
                ],
              ),
            ),
          ),
          Divider(
            color: IcoColors.grey2,
            height: 1,
          ),
          InkWell(
            child: SizedBox(
              height: 55,
              width: IcoSize.width - 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '문의하기',
                    style: IcoTextStyle.mediumTextStyle15B,
                  ),
                  SvgPicture.asset('icons/arrow_right1.svg')
                ],
              ),
            ),
          ),
          Divider(
            color: IcoColors.grey2,
            height: 1,
          ),
        ],
      ),
    );
  }
}
