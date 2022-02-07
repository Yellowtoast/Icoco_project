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
      this.hasBorder = true})
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
                  border: (hasBorder)
                      ? Border.all(
                          color: (selectedItem.value == item)
                              ? IcoColors.primary
                              : IcoColors.grey2,
                          width: 1,
                        )
                      : Border.fromBorderSide(BorderSide.none)),
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
