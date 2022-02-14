import 'package:app/configs/colors.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/reservation/step1/voucher_controller.dart';
import 'package:app/controllers/reservation/step2/substep_controllers/additional_fee_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class VoucherDropdown extends StatelessWidget {
  VoucherDropdown({
    Key? key,
    required this.selectedVoucherType,
    required this.dropDownList,
    this.selectedTextStyle,
    this.hintText,
    this.icon = true,
  }) : super(key: key);

  Rxn<String> selectedVoucherType;
  RxList<String>? dropDownList = RxList<String>();
  VoucherController voucherController = Get.find();
  TextStyle? selectedTextStyle;
  String? hintText;
  bool icon;
  AdditionalFeeController additionalFeeController =
      Get.put(AdditionalFeeController());

  @override
  Widget build(BuildContext context) {
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
            (hintText != null) ? hintText! : dropDownList![0],
            style: IcoTextStyle.mediumTextStyle16G,
          ),
          value: selectedVoucherType.value,
          iconSize: 0,
          isExpanded: true,
          icon: (icon) ? SvgPicture.asset("icons/dropdown_arrow.svg") : null,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(height: 0),
          onChanged: (String? newValue) {
            selectedVoucherType.value = newValue!;
            voucherController.setDropDownList(selectedVoucherType);
            if (voucherController.checkVoucherValid()) {
              voucherController.voucherResult.value =
                  voucherController.makeFullVoucherResult();
              voucherController.setVoucherInfo(
                  voucherController.voucherResult.value,
                  additionalFeeController.totalAdditionalFee);
            }

            // if (selectedVoucherType.value == 'A' ||
            //     selectedVoucherType.value == 'B' ||
            //     selectedVoucherType.value == 'C') {
            //   voucherController.voucherType2.value = null;
            //   voucherController.voucherType3.value = null;
            // }

            // voucherController
            //     .getVoucherCostInfo(voucherController.voucherResult.value!);
          },
          items: (voucherController.voucherType1.value == 'C' &&
                  dropDownList![0] == '')
              ? null
              : dropDownList!.map<DropdownMenuItem<String>>((String value) {
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
