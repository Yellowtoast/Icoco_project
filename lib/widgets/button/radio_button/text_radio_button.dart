import 'package:app/configs/colors.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextRadioButton extends StatelessWidget {
  TextRadioButton(
      {Key? key,
      required this.selectedItem,
      required this.item,
      required this.onTap,
      required this.itemTitle,
      this.radiusTopLeft = true,
      this.radiusTopRight = true,
      this.radiusBottomLeft = true,
      this.radiusBottomRight = true,
      this.hasBorder = true,
      required this.activeBorderColor,
      required this.inactiveBorderColor})
      : super(key: key);
  Rxn<Enum> selectedItem;
  Enum item;
  void Function()? onTap;
  String itemTitle;
  bool radiusTopLeft;
  bool radiusTopRight;
  bool radiusBottomLeft;
  bool radiusBottomRight;
  bool hasBorder;
  Color activeBorderColor;
  Color inactiveBorderColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        return SizedBox(
          height: 50,
          width: IcoSize.width,
          child: InkWell(
            onTap: onTap,
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: IcoSize.width,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: (hasBorder && selectedItem == item)
                          ? activeBorderColor
                          : inactiveBorderColor,
                      spreadRadius: 1)
                ],
                color: (selectedItem.value == item)
                    ? IcoColors.purple2
                    : IcoColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: (radiusTopLeft)
                      ? Radius.circular(10.0)
                      : Radius.circular(0),
                  topRight: (radiusTopRight)
                      ? Radius.circular(10.0)
                      : Radius.circular(0),
                  bottomLeft: (radiusBottomLeft)
                      ? Radius.circular(10.0)
                      : Radius.circular(0),
                  bottomRight: (radiusBottomRight)
                      ? Radius.circular(10.0)
                      : Radius.circular(0),
                ),
              ),
              child: Text(itemTitle,
                  style: (selectedItem.value == item)
                      ? IcoTextStyle.mediumTextStyle16P
                      : (hasBorder)
                          ? IcoTextStyle.mediumTextStyle16Grey3
                          : IcoTextStyle.mediumTextStyle16B),
            ),
          ),
        );
      }),
    );
  }
}
