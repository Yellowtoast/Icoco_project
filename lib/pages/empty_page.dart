import 'package:app/configs/colors.dart';
import 'package:app/configs/enum.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/pages/reservation/step2/reserve/reserve_step2_4.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/button/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class EmptyInfoPage extends StatelessWidget {
  EmptyInfoPage(
      {Key? key,
      required this.appbarText,
      this.title = '아직 예약된 정보가 없습니다',
      this.subtitle = '메인페이지에서\n도우미 예약을 진행해주세요'})
      : super(key: key);
  String appbarText;
  String title;
  String subtitle;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IcoAppbar(title: appbarText),
      body: SizedBox(
        height: IcoSize.height,
        width: IcoSize.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
            ),
            Image.asset('images/failed_human_grey.png', width: 170),
            SizedBox(
              height: 15,
            ),
            Text(
              title,
              style: IcoTextStyle.boldTextStyle20Grey4,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              subtitle,
              style: IcoTextStyle.mediumTextStyle14Grey4,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
