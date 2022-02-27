import 'package:app/configs/colors.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextRadioButton2 extends StatelessWidget {
  TextRadioButton2({
    Key? key,
    required this.item,
    required this.activeTextStyle,
    required this.inactiveTextStyle,
    required this.isMultiple,
    this.selectedItem,
    this.selectedItemList,
    this.multipleAllowItem,
    this.radiusTopLeft = true,
    this.radiusTopRight = true,
    this.radiusBottomLeft = true,
    this.radiusBottomRight = true,
    this.horizontalBorder = true,
    this.stepList,
    this.stepNum,
    this.relatedStepNum,
    this.relatedItemList,
  }) : super(key: key);
  RxList<String>? selectedItemList;
  Rxn<String>? selectedItem;
  // Rxn<String>? relatedItem;
  List<dynamic>? relatedItemList;
  String item;
  RxList<dynamic>? stepList;
  int? stepNum;
  int? relatedStepNum;
  String? multipleAllowItem;
  bool radiusTopLeft;
  bool radiusTopRight;
  bool radiusBottomLeft;
  bool radiusBottomRight;
  bool horizontalBorder;
  bool isMultiple;
  TextStyle activeTextStyle;
  TextStyle inactiveTextStyle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        return SizedBox(
          height: 50,
          width: IcoSize.width,
          child: InkWell(
            onTap: () {
              var isStepFinished = false.obs;

              if (relatedItemList != null && relatedStepNum != null) {
                print('ee');
                relatedItemList!.forEach((element) {
                  element.value = null;
                });
                stepList![relatedStepNum!] = false.obs;
              }

              if (isMultiple) {
                if (selectedItemList!.contains(multipleAllowItem) &&
                    selectedItemList!.length < 2) {
                  selectedItemList!.add(item);
                  selectedItemList!.refresh();

                  isStepFinished = true.obs;
                } else {
                  selectedItemList!.clear();
                  selectedItemList!.add(item);
                  selectedItemList!.refresh();
                  (item == multipleAllowItem)
                      ? isStepFinished = false.obs
                      : isStepFinished = true.obs;
                }
              } else {
                selectedItem!.value = item;
                isStepFinished = true.obs;
              }

              if (stepList != null && stepNum != null) {
                stepList![stepNum!] = isStepFinished;
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: IcoSize.width,
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: IcoColors.grey2, spreadRadius: 1)],
                color: ((isMultiple && selectedItemList!.contains(item)) ||
                        (selectedItem != null && selectedItem!.value == item))
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
              child: Text(item,
                  style: ((isMultiple && selectedItemList!.contains(item)) ||
                          (selectedItem != null && selectedItem!.value == item))
                      ? activeTextStyle
                      : inactiveTextStyle),
            ),
          ),
        );
      }),
    );
  }
}
