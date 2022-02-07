import 'package:app/configs/colors.dart';
import 'package:app/configs/text_styles.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BigIconTextButton extends StatelessWidget {
  const BigIconTextButton({
    Key? key,
    required this.icon,
    required this.mainLabel,
    required this.subLabel,
  }) : super(key: key);

  final Widget icon;
  final String mainLabel;
  final String subLabel;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: Container(
        height: 190,
        decoration: BoxDecoration(
            color: IcoColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: IcoColors.grey2,
              width: 1,
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 79, child: icon),
            const SizedBox(
              height: 21,
            ),
            Text(
              mainLabel,
              style: IcoTextStyle.boldTextStyle15P,
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  subLabel,
                  style: IcoTextStyle.mediumTextStyle13B,
                ),
                const SizedBox(
                  width: 3,
                ),
                SvgPicture.asset(
                  "icons/circle_arrow_heading.svg",
                  width: 14,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
