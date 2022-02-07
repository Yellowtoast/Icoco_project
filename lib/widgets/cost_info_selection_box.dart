import 'package:app/configs/colors.dart';
import 'package:app/configs/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:app/configs/enum.dart';

class CostInfoSelectionBox extends StatelessWidget {
  var numFormat = NumberFormat('###,###,###,###');
  CostInfoSelectionBox({
    Key? key,
    required this.title,
    required this.totalFee,
    required this.userFee,
    required this.govermentFee,
    required this.titleStyle,
    required this.isVoucherUsed,
    required this.feeTypeIndex,
    required this.useDateSelected,
    required this.dateType,
    required this.remainingFee,
    required this.depositFee,
  }) : super(key: key);
  String title;
  TextStyle titleStyle;
  RxList<int> totalFee;
  RxList<int> userFee;
  RxList<int> govermentFee;
  RxList<int> depositFee;
  RxList<int> remainingFee;
  Rx<bool> isVoucherUsed;
  int feeTypeIndex;
  Rxn<serviceDurationType> useDateSelected;
  Rx<serviceDurationType> dateType;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
        padding: EdgeInsets.fromLTRB(17, 20, 17, 25),
        decoration: BoxDecoration(
            color: IcoColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: (useDateSelected == dateType)
                    ? IcoColors.primary
                    : IcoColors.grey2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset((useDateSelected == dateType)
                    ? "icons/check.svg"
                    : "icons/unchecked.svg"),
                SizedBox(
                  width: 7,
                ),
                Text(title, style: titleStyle),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("총 요금", style: IcoTextStyle.mediumTextStyle13Grey4),
                Text(
                    (totalFee != null)
                        ? numFormat.format(totalFee.value[feeTypeIndex]) + " 원"
                        : "",
                    style: (isVoucherUsed.value)
                        ? IcoTextStyle.boldTextStyle18B
                        : IcoTextStyle.mediumTextStyle16Grey3),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            (isVoucherUsed.value)
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("정부지원금",
                              style: IcoTextStyle.mediumTextStyle13Grey4),
                          Text(
                              (govermentFee != null)
                                  ? numFormat.format(
                                          govermentFee.value[feeTypeIndex]) +
                                      " 원"
                                  : "",
                              style: IcoTextStyle.mediumTextStyle16Grey3),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      DividerLineWidget(height: 1, color: IcoColors.grey2),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("본인부담금",
                              style: IcoTextStyle.mediumTextStyle13Grey4),
                          Text(
                              (userFee != null)
                                  ? numFormat
                                          .format(userFee.value[feeTypeIndex]) +
                                      " 원"
                                  : "",
                              style: IcoTextStyle.boldTextStyle18B),
                        ],
                      ),
                      SizedBox(
                        height: 18,
                      ),
                    ],
                  )
                : SizedBox(),
            Container(
              padding: EdgeInsets.all(17),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: (useDateSelected == dateType)
                    ? IcoColors.purple1
                    : IcoColors.grey1,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "예약금",
                          style: IcoTextStyle.mediumTextStyle12Grey4,
                        ),
                      ),
                      SizedBox(
                        width: 11,
                      ),
                      Expanded(
                        flex: 10,
                        child: Text(
                          // "${numFormat.format(depositFee.value[feeTypeIndex] - 100000)}원",
                          numFormat.format(depositFee.value[feeTypeIndex]) +
                              " 원",
                          style: IcoTextStyle.mediumTextStyle15Grey4,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "잔금",
                          style: IcoTextStyle.mediumTextStyle12Grey4,
                        ),
                      ),
                      SizedBox(
                        width: 11,
                      ),
                      Expanded(
                        flex: 10,
                        child: Text(
                          "${numFormat.format(remainingFee.value[feeTypeIndex])}원",
                          style: IcoTextStyle.mediumTextStyle15Grey4,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}

class DividerLineWidget extends StatelessWidget {
  DividerLineWidget({
    Key? key,
    this.height = 9,
    this.color = IcoColors.grey1,
  }) : super(key: key);
  double height;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: color,
    );
  }
}
