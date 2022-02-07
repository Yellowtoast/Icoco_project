import 'package:app/configs/colors.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/reservation/step1/voucher_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class VoucherDropdown extends StatelessWidget {
  VoucherDropdown({
    Key? key,
    required this.selectedValue,
    required this.dropDownList,
    this.selectedTextStyle,
    this.hintText,
    this.icon = true,
  }) : super(key: key);

  Rxn<String> selectedValue;
  RxList<String>? dropDownList = RxList<String>();
  VoucherController controller = Get.put(VoucherController());
  TextStyle? selectedTextStyle;
  String? hintText;
  bool icon;

  @override
  Widget build(BuildContext context) {
    Get.put(controller);
    return Obx(() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: IcoColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: IcoColors.grey2, width: 1),
        ),
        child: DropdownButton<String>(
          hint: Text(
            (hintText != null) ? hintText! : dropDownList!.value[0],
            style: IcoTextStyle.mediumTextStyle16G,
          ),
          value: selectedValue.value,
          iconSize: 0,
          isExpanded: true,
          icon: (icon) ? SvgPicture.asset("icons/dropdown_arrow.svg") : null,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(height: 0),
          onChanged: (String? newValue) async {
            if (newValue == 'A' || newValue == 'B' || newValue == 'C') {
              controller.voucherType1.value = null;
              controller.voucherType2.value = null;
              controller.voucherType3.value = null;
            }

            selectedValue.value = newValue!;
            controller.setDropDownList();
            await controller.checkVoucherValid();
          },
          items: (controller.voucherType1.value == 'C' &&
                  dropDownList!.value[0] == '')
              ? null
              : dropDownList!.value
                  .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    alignment: Alignment.centerLeft,
                    value: value,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          value,
                          style: selectedTextStyle ??
                              IcoTextStyle.mediumTextStyle16P,
                        ),
                      ],
                    ),
                  );
                }).toList(),
        ),
      );
    });
  }
}
