import 'package:app/configs/text_styles.dart';
import 'package:app/pages/reservation/step1/substep_voucher/voucher_signed/voucher_signed1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/helpers/formatter.dart';

class CostInfoBox extends StatelessWidget {
  CostInfoBox({
    Key? key,
    required this.title,
    required this.totalFee,
    required this.userFee,
    required this.govermentFee,
    required this.titleStyle,
    required this.isVoucherUsed,
    required this.weekIndex,
    this.icon,
  }) : super(key: key);
  String title;
  TextStyle titleStyle;
  List<dynamic> totalFee;
  List<dynamic> userFee;
  List<dynamic> govermentFee;
  Widget? icon;
  Rx<bool> isVoucherUsed;
  int weekIndex;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        // color: IcoColors.grey2,
        padding: EdgeInsets.fromLTRB(20, 20, 20, 25),
        // height: 200,
        // width: IcoSize.width - 40,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                icon ?? SizedBox(),
                (icon != null)
                    ? SizedBox(
                        width: 7,
                      )
                    : SizedBox(),
                Text(title, style: titleStyle),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("총 요금", style: IcoTextStyle.mediumTextStyle13Grey4),
                Text(
                    (totalFee != null)
                        ? numFormat.format(totalFee[weekIndex - 1]) + " 원"
                        : "",
                    style: IcoTextStyle.mediumTextStyle16Grey3),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("정부지원금", style: IcoTextStyle.mediumTextStyle13Grey4),
                Text(
                    (govermentFee != null)
                        ? numFormat.format(govermentFee[weekIndex - 1]) + " 원"
                        : "",
                    style: IcoTextStyle.mediumTextStyle16Grey3),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            (isVoucherUsed.value)
                ? Column(
                    children: [
                      DividerLineWidget(
                        height: 1,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("본인부담금",
                              style: IcoTextStyle.mediumTextStyle13Grey4),
                          Text(
                              (userFee != null)
                                  ? numFormat.format(userFee[weekIndex - 1]) +
                                      " 원"
                                  : "",
                              style: IcoTextStyle.boldTextStyle18B),
                        ],
                      ),
                    ],
                  )
                : SizedBox(),
          ],
        ),
      );
    });
  }
}
