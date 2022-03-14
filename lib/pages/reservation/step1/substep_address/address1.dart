import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/address_controller.dart';

import 'package:app/pages/reservation/step1/substep_address/address3.dart';
import 'package:app/pages/reservation/step1/substep_voucher/voucher1.dart';
import 'package:app/pages/reservation/step1/substep_address/address2.dart';
import 'package:app/pages/reservation/step2/reserve/reserve_step2_1.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/appbar/appbar.dart';
import 'package:app/widgets/textfield/textfield.dart';
import 'package:daum_postcode_search/data_model.dart';
import 'package:daum_postcode_search/daum_postcode_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AddressPage1 extends StatelessWidget {
  const AddressPage1({Key? key}) : super(key: key);

  Widget basicTextField(Rxn<String> additionalAddress,
      TextEditingController? controller, String? hintText) {
    return SizedBox(
      height: 50,
      width: IcoSize.width - 40,
      child: TextFormField(
        onChanged: (value) {
          additionalAddress.value = value;
        },
        initialValue: additionalAddress.value,
        style: IcoTextStyle.mediumTextStyle16B,
        controller: controller,
        maxLength: 100,
        decoration: InputDecoration(
          counterText: '',
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          hintText: hintText,
          hintStyle: IcoTextStyle.mediumTextStyle16Grey4,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: IcoColors.primary),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: IcoColors.grey3),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AddressController addressController = Get.find();
    AuthController authController = AuthController();
    var command = Get.arguments;
    return Scaffold(
      backgroundColor: IcoColors.white,
      appBar: IcoAppbar(
        title: "주소 입력",
        tapFunction: () {
          if (command == '수정') {
            Get.back();
          } else {
            authController.setModelInfo();
            Get.offAllNamed(Routes.HOME);
          }
        },
      ),
      body: SafeArea(
        left: false,
        right: false,
        child: Obx(() {
          return Container(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 27,
                      ),
                      Text(
                        '주소를 입력해주세요',
                        style: IcoTextStyle.boldTextStyle24B,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "도우미 파견을 위해 원하시는 주소를 입력해주세요",
                        style: IcoTextStyle.mediumTextStyle13Grey4,
                      ),
                      SizedBox(
                        height: 21,
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: IcoColors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color:
                                      (addressController.address.value != null)
                                          ? IcoColors.primary
                                          : IcoColors.grey3,
                                  width: 1,
                                )),
                            child: TextButton(
                              onPressed: () async {
                                try {
                                  addressController.addressModel =
                                      await Get.to(AddressPage2());
                                  await addressController.trimAddressDataModel(
                                      addressController.addressModel);
                                } catch (error) {
                                  print(error);
                                }
                              },
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    (addressController.address.value != null)
                                        ? addressController.address.value ?? ""
                                        : "주소 입력",
                                    style: (addressController.address.value !=
                                            null)
                                        ? IcoTextStyle.mediumTextStyle16B
                                        : IcoTextStyle.mediumTextStyle16G,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            right: 13,
                            child: SvgPicture.asset(
                              'icons/search_icon.svg',
                              color: (addressController.address.value != null)
                                  ? IcoColors.primary
                                  : IcoColors.grey3,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                basicTextField(
                    addressController.additionalAddress,
                    addressController.addressTextController.value,
                    '나머지 주소를 입력해주세요'),
                SizedBox(
                  height: 24,
                ),
                Container(
                  height: 9,
                  color: IcoColors.grey1,
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IcoButton(
                            onPressed: () {
                              addressController.setCompleteAddress();
                              if (addressController.sido.value == '대구') {
                                if (command == '수정') {
                                  authController = Get.find();
                                  addressController.updateAddressToModel(
                                      authController.reservationModel);
                                  authController.updateSingleDataFirestore(
                                      authController.reservationModel.value!
                                          .reservationNumber,
                                      {
                                        'address': addressController
                                            .completeAddress.value
                                      });
                                  Get.back(
                                      result: authController
                                          .reservationModel.value!.address);
                                } else {
                                  Get.toNamed(Routes.VOUCHER_1);
                                }
                              } else {
                                print('not serviced');
                                Get.toNamed(Routes.ADDRESS_3);
                              }
                            },
                            active: (addressController.address.value != null &&
                                    addressController.additionalAddress != null)
                                ? true.obs
                                : false.obs,
                            buttonColor: IcoColors.primary,
                            textStyle: IcoTextStyle.buttonTextStyleW,
                            text: "주소 선택"),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

// class BasicTextField extends StatelessWidget {
//   const BasicTextField({
//     Key? key,
//     required this.addressController,
//   }) : super(key: key);

//   final AddressController addressController;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 50,
//       width: IcoSize.width - 40,
//       child: TextFormField(
//         style: IcoTextStyle.mediumTextStyle16B,
//         controller: addressController.additionalAddressController,
//         maxLength: 100,
//         decoration: InputDecoration(
//           counterText: '',
//           contentPadding: EdgeInsets.symmetric(horizontal: 10),
//           hintText: '나머지 주소를 입력해주세요',
//           hintStyle: IcoTextStyle.mediumTextStyle16Grey4,
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(10.0)),
//             borderSide: BorderSide(color: IcoColors.primary),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(10.0)),
//             borderSide: BorderSide(color: IcoColors.grey3),
//           ),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(10.0)),
//           ),
//         ),
//       ),
//     );
//   }
// }
