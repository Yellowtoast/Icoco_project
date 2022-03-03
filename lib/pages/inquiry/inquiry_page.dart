import 'package:app/configs/colors.dart';
import 'package:app/configs/enum.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/company_controller.dart';
import 'package:app/controllers/inquiry_controller.dart';
import 'package:app/controllers/manager_controller.dart';
import 'package:app/controllers/mypage_controller.dart';
import 'package:app/controllers/review_controller.dart';
import 'package:app/widgets/appbar/appbar.dart';
import 'package:app/widgets/button/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../widgets/modal/bottomup_modal2.dart';
import '../../widgets/loading/loading.dart';

class InquiryPage extends StatelessWidget {
  InquiryPage({Key? key}) : super(key: key);
  int managerNum = Get.arguments;
  AuthController authController = Get.find();
  ManagerController managerController = Get.find();
  CompanyController companyController = Get.find();
  ReviewController reviewController = Get.find();
  InquiryController inquiryController = Get.put(InquiryController());
  MypageController mypageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IcoAppbar(title: '문의하기'),
      backgroundColor: IcoColors.grey1,
      body: SingleChildScrollView(
        child: Obx(() {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: IcoSize.width - 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 26,
                      ),
                      Text(
                        '담당 관리사',
                        style: IcoTextStyle.boldTextStyle13B,
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      Column(children: [
                        Container(
                          height: 124,
                          width: IcoSize.width - 40,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: IcoColors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: IcoColors.grey2)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.network(
                                      "${managerController.managerModelList[managerNum].value!.profileImage}",
                                      width: 89,
                                      height: 89,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Image.asset(
                                        "images/empty_profile.png",
                                        width: 89,
                                        height: 89,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          text: managerController
                                              .managerModelList[managerNum]
                                              .value!
                                              .name,
                                          style: IcoTextStyle.boldTextStyle19B,
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: ' 도우미',
                                                style: IcoTextStyle
                                                    .mediumTextStyle12Grey4),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      RatingBar(
                                        ignoreGestures: true,
                                        initialRating: managerController
                                            .managerModelList[managerNum]
                                            .value!
                                            .managerRate
                                            .toDouble(),
                                        direction: Axis.horizontal,
                                        allowHalfRating: false,
                                        itemCount: 5,
                                        ratingWidget: RatingWidget(
                                          full: SvgPicture.asset(
                                              'icons/star_full.svg'),
                                          half: SvgPicture.asset(
                                              'icons/star_full.svg'),
                                          empty: SvgPicture.asset(
                                              'icons/star_empty.svg'),
                                        ),
                                        itemSize: 14,
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Text("대구 아이사랑 소속",
                                          style: IcoTextStyle
                                              .mediumTextStyle12Grey4),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () async {
                                        startLoadingIndicator();
                                        reviewController.finalReviewModelList =
                                            await reviewController
                                                .getJsonReviews(
                                                    managerController
                                                        .managerModelList[
                                                            managerNum]
                                                        .value!
                                                        .uid,
                                                    'manager',
                                                    0,
                                                    3,
                                                    '기말');
                                        finishLoadingIndicator();
                                        Get.toNamed(Routes.MANAGER,
                                            arguments: managerNum);
                                      },
                                      child: Container(
                                        height: 89,
                                        alignment: Alignment.centerRight,
                                        child: SvgPicture.asset(
                                          'icons/arrow_wide.svg',
                                          color: IcoColors.grey3,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ]),
                    ],
                  ),
                ),
                SizedBox(
                  height: 26,
                ),
                SizedBox(
                  width: IcoSize.width - 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'C/S 센터 안내',
                        style: IcoTextStyle.boldTextStyle13B,
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(17, 20, 17, 25),
                        decoration: BoxDecoration(
                            color: IcoColors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: IcoColors.grey2)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    ConstrainedBox(
                                      constraints: BoxConstraints.tightFor(
                                          width: 50, height: 50),
                                      child: ElevatedButton(
                                        child: SvgPicture.asset(
                                            "icons/dear_care_logo.svg"),
                                        onPressed: () {},
                                        style: TextButton.styleFrom(
                                          backgroundColor: IcoColors.white,
                                          shape: CircleBorder(),
                                          side: BorderSide(
                                              color: IcoColors.grey2),
                                          shadowColor: Colors.transparent,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      companyController
                                          .companyModel.value!.companyName,
                                      style: IcoTextStyle.boldTextStyle18B,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 14,
                                ),
                                Container(
                                  padding: EdgeInsets.all(17),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: IcoColors.grey1,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              "은행",
                                              style:
                                                  IcoTextStyle.boldTextStyle14B,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 11,
                                          ),
                                          Expanded(
                                            flex: 7,
                                            child: Text(
                                              companyController
                                                  .companyModel.value!.bankName,
                                              style: IcoTextStyle
                                                  .mediumTextStyle14Grey4,
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
                                              "입금자명",
                                              style:
                                                  IcoTextStyle.boldTextStyle14B,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 11,
                                          ),
                                          Expanded(
                                            flex: 7,
                                            child: Text(
                                              companyController.companyModel
                                                  .value!.accountHolderName,
                                              style: IcoTextStyle
                                                  .mediumTextStyle14Grey4,
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
                                              "계좌번호",
                                              style:
                                                  IcoTextStyle.boldTextStyle14B,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 11,
                                          ),
                                          Expanded(
                                            flex: 7,
                                            child: Text(
                                              "${companyController.companyModel.value!.accountNumber}",
                                              style: IcoTextStyle
                                                  .mediumTextStyle14Grey4,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  color: IcoColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text("문의 글쓰기", style: IcoTextStyle.boldTextStyle17B),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        height: 225,
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(17, 9, 17, 9),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: IcoColors.grey2,
                              width: 1,
                            )),
                        child: TextField(
                          onChanged: (value) {
                            inquiryController.reviewContents.value = value;
                          },
                          controller: inquiryController.contentsTextController,
                          keyboardType: TextInputType.multiline,
                          style: IcoTextStyle.mediumTextStyle13B,
                          maxLines: 20,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 67,
                      ),
                      IcoButton(
                          onPressed: () {
                            BottomUpModal2(
                                title: "문의내용이 접수되었습니다.",
                                subtitle: "문의내용에 대한 답변은\n연락처로 연락드리도록 하겠습니다.",
                                buttonText: "확인 완료",
                                onTap: () async {
                                  inquiryController.createInquiryFirestore(
                                    companyController.companyModel.value!.uid!,
                                    authController.reservationModel.value!.uid,
                                    managerController
                                        .managerModelList[managerNum]
                                        .value!
                                        .uid,
                                    authController
                                        .reservationModel.value!.email,
                                    managerController
                                        .managerModelList[managerNum]
                                        .value!
                                        .name,
                                  );
                                  Get.offAllNamed(Routes.HOME);
                                });
                          },
                          active: (inquiryController.reviewContents.value != '')
                              ? true.obs
                              : false.obs,
                          textStyle: IcoTextStyle.buttonTextStyleW,
                          text: '문의등록'),
                      SizedBox(
                        height: 20,
                      ),
                    ],
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
