// import 'package:app/configs/colors.dart';
// import 'package:app/configs/routes.dart';
// import 'package:app/configs/size.dart';
// import 'package:app/configs/text_styles.dart';
// import 'package:app/controllers/voucher_controller.dart';
// import 'package:app/controllers/date_info_controller.dart';
// import 'package:app/controllers/service_info_controller.dart';
// import 'package:app/widgets/button/button.dart';
// import 'package:app/widgets/button/contents_button/costinfo_select_button.dart';
// import 'package:app/widgets/dropdown/voucher_dropdown.dart';
// import 'package:app/widgets/appbar/appbar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:app/configs/enum.dart';

// class ReserveStep2_7_Novoucher extends StatelessWidget {
//   ReserveStep2_7_Novoucher({Key? key}) : super(key: key);
//   VoucherController voucherController = Get.find();
//   ServiceInfoController serviceInfoController = Get.find();
//   DateInfoController dateInfoController = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         floatingActionButton: Obx(() {
//           return IcoButton(
//               width: IcoSize.width - 40,
//               onPressed: () async {
//                 Get.toNamed(Routes.RESERVE_STEP2_REGISTERED);
//               },
//               active: (dateInfoController.serviceDurationSelected.value == null)
//                   ? false.obs
//                   : true.obs,
//               textStyle: IcoTextStyle.buttonTextStyleW,
//               text: "다음으로");
//         }),
//         backgroundColor: IcoColors.white,
//         appBar: IcoAppbar(
//           title: "예약하기",
//           usePop: true,
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//         body: Obx(() {
//           return Column(
//             children: [
//               SizedBox(
//                 height: 27,
//               ),
//               SizedBox(
//                 width: IcoSize.width - 40,
//                 child: Text(
//                   "서비스 이용요금을 확인해주세요",
//                   style: IcoTextStyle.boldTextStyle24B,
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Expanded(
//                 child: ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: 5,
//                     itemBuilder: (BuildContext context, int index) {
//                       return Column(
//                         children: [
//                           Container(
//                             margin: EdgeInsets.symmetric(vertical: 10),
//                             child: InkWell(
//                               onTap: () {
//                                 dateInfoController.serviceDurationSelected
//                                     .value = "${index + 1}주";
//                               },
//                               child: CostInfoSelectButton(
//                                 feeTypeIndex: index,
//                                 isVoucherUsed:
//                                     (voucherController.isVoucherUnused.value ==
//                                             true)
//                                         ? false.obs
//                                         : true.obs,
//                                 totalFee: voucherController.totalFeeList,
//                                 userFee: voucherController.userFeeList,
//                                 govermentFee:
//                                     voucherController.govermentFeeList,
//                                 depositFee: voucherController.depositFeeList,
//                                 remainingFee:
//                                     voucherController.remainingFeeList,
//                                 title: "${index + 1}주 사용",
//                                 titleStyle: IcoTextStyle.boldTextStyle18B,
//                                 itemValue: "${index + 1}주",
//                                 useDateSelected:
//                                     dateInfoController.serviceDurationSelected,
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     }),
//               ),
//               SizedBox(
//                 height: 80,
//               )
//             ],
//           );
//         }));
//   }
// }
