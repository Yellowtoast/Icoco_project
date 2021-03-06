import 'package:app/configs/colors.dart';
import 'package:app/configs/constants.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/company_controller.dart';
import 'package:app/controllers/manager_controller.dart';

import 'package:app/controllers/review_controller.dart';
import 'package:app/helpers/formatter.dart';
import 'package:app/pages/event/event.dart';
import 'package:app/pages/inquiry/inquiry_page.dart';
import 'package:app/widgets/appbar/appbar.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/modal/bottomup_modal2.dart';
import 'package:app/widgets/modal/option_modal.dart';
import 'package:app/widgets/modal/result_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../guide_page/empty_content_page.dart';
import '../refund/refund.dart';

class ManagerDetailPage extends StatelessWidget {
  int managerNum = Get.arguments;
  ManagerController managerController = Get.put(ManagerController());
  ReviewController reviewController = Get.put(ReviewController());
  AuthController authController = Get.find();
  CompanyController companyController = Get.put(CompanyController());

  @override
  Widget build(BuildContext context) {
    if (reviewController.totalReviews.value! >= 3) {
      reviewController.reviewCount.value = 3;
    } else {
      reviewController.reviewCount.value = reviewController.totalReviews.value;
    }

    return Obx(() {
      return Scaffold(
        appBar: IcoAppbar(
          title:
              "${managerController.managerModelList[managerNum].value!.name} 도우미님",
          usePop: true,
          backgroundColor: IcoColors.purple2,
        ),
        backgroundColor: IcoColors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            color: IcoColors.purple2,
            width: IcoSize.width,
            child: Column(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 18,
                    ),
                    Container(
                      width: Get.width - 40,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: IcoColors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                  const SizedBox(
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
                                      const SizedBox(
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
                                        itemSize: 15,
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                          "${managerController.managerModelList[managerNum].value!.companyName} 소속",
                                          style: IcoTextStyle
                                              .mediumTextStyle12Grey4),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      SvgPicture.asset(
                                        "icons/helper_auth_self.svg",
                                        color: IcoColors.primary,
                                      ),
                                      Text("본인인증 완료",
                                          style:
                                              IcoTextStyle.mediumTextStyle13P)
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SvgPicture.asset(
                                        "icons/helper_auth_hospital.svg",
                                        color: IcoColors.primary,
                                      ),
                                      Text("건강인증 완료",
                                          style:
                                              IcoTextStyle.mediumTextStyle13P)
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SvgPicture.asset(
                                        "icons/helper_auth_crime.svg",
                                        color: IcoColors.primary,
                                      ),
                                      Text("범죄이력 없음",
                                          style:
                                              IcoTextStyle.mediumTextStyle13P)
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: IcoColors.purple1,
                                    ),
                                    width: 95,
                                    height: 34,
                                    child: Text(
                                      "경력 ${managerController.managerModelList[managerNum].value!.careerYears}년이내",
                                      style: IcoTextStyle.mediumTextStyle13P,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: IcoColors.purple1,
                                    ),
                                    width: 95,
                                    height: 34,
                                    child: Text(
                                      "${managerController.managerModelList[managerNum].value!.ages}대",
                                      style: IcoTextStyle.mediumTextStyle13P,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: IcoColors.purple1,
                                    ),
                                    width: 95,
                                    height: 34,
                                    child: Text(
                                      "리뷰 ${managerController.managerModelList[managerNum].value!.totalReview}+",
                                      style: IcoTextStyle.mediumTextStyle13P,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 30, 20, 35),
                  decoration: BoxDecoration(
                    color: IcoColors.white,
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "관리사 정보",
                        style: IcoTextStyle.boldTextStyle14B,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              height: 106,
                              decoration: BoxDecoration(
                                  color: IcoColors.purple2,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("icons/helper_info_car.svg"),
                                  Text(
                                    "차량 ${managerController.managerModelList[managerNum].value!.isCar}",
                                    style: IcoTextStyle.boldTextStyle13P,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              height: 106,
                              decoration: BoxDecoration(
                                  color: IcoColors.purple2,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      "icons/helper_info_home.svg"),
                                  Text(
                                    "입주 ${managerController.managerModelList[managerNum].value!.isResident}",
                                    style: IcoTextStyle.boldTextStyle13P,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              height: 106,
                              decoration: BoxDecoration(
                                  color: IcoColors.purple2,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      "icons/helper_info_cctv.svg"),
                                  Text(
                                    "CCTV${managerController.managerModelList[managerNum].value!.isCCTV}",
                                    style: IcoTextStyle.boldTextStyle13P,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const Divider(
                  color: IcoColors.grey1,
                  height: 9,
                  thickness: 9,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 35),
                  decoration: const BoxDecoration(
                    color: IcoColors.white,
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "산모님들이 생각하는 특기",
                        style: IcoTextStyle.boldTextStyle14B,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SpecialtyBox(
                              specialty: managerController
                                      .managerModelList[managerNum]
                                      .value!
                                      .topSpecialty ??
                                  '정리정돈'),
                          SizedBox(
                            width: 14,
                          ),
                          SpecialtyIndex(
                              specialty: managerController
                                      .managerModelList[managerNum]
                                      .value!
                                      .topSpecialty ??
                                  '정리정돈')
                        ],
                      )
                    ],
                  ),
                ),
                const Divider(
                  color: IcoColors.grey1,
                  height: 9,
                  thickness: 9,
                ),
                (reviewController.totalReviews.value == 0)
                    ? EmptyListPage(
                        title: '아직 등록된 리뷰가 없습니다',
                        subtitle: '등록된 리뷰 글이 없습니다',
                      )
                    : Container(
                        color: IcoColors.white,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 25,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    children: [
                                      Text("리뷰",
                                          style: IcoTextStyle.boldTextStyle14B),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                          "${reviewController.totalReviews.value}개",
                                          style: IcoTextStyle.boldTextStyle14P)
                                    ],
                                  ),
                                ),
                                (reviewController.reviewListWithPicture.isEmpty)
                                    ? SizedBox()
                                    : Column(
                                        children: [
                                          SizedBox(
                                            height: 24,
                                          ),
                                          SizedBox(
                                            height: 221,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      shrinkWrap: true,
                                                      itemCount: reviewController
                                                          .reviewListWithPicture
                                                          .length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return Row(
                                                          children: [
                                                            (index == 0)
                                                                ? SizedBox(
                                                                    width: 20,
                                                                  )
                                                                : SizedBox(),
                                                            (reviewController
                                                                    .reviewListWithPicture
                                                                    .isEmpty)
                                                                ? SizedBox()
                                                                : Container(
                                                                    height: 221,
                                                                    width: 221,
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      child: Stack(
                                                                          children: [
                                                                            Positioned(
                                                                              child: Container(
                                                                                width: 221,
                                                                                height: 221,
                                                                                decoration: BoxDecoration(
                                                                                  color: IcoColors.grey1,
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                ),
                                                                                child: Image.network(
                                                                                  reviewController.reviewListWithPicture[index].value!.thumbnails![0],
                                                                                  fit: BoxFit.cover,
                                                                                  errorBuilder: (context, error, stackTrace) => Image.asset(
                                                                                    "images/empty_profile.png",
                                                                                    width: 89,
                                                                                    height: 89,
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              decoration: BoxDecoration(color: Colors.black38),
                                                                            ),
                                                                            Positioned(
                                                                              left: 15,
                                                                              top: 17,
                                                                              child: RatingBar(
                                                                                ignoreGestures: true,
                                                                                initialRating: reviewController.reviewListWithPicture[index].value!.reviewRate!.toDouble(),
                                                                                direction: Axis.horizontal,
                                                                                allowHalfRating: false,
                                                                                itemCount: 5,
                                                                                ratingWidget: RatingWidget(
                                                                                  full: SvgPicture.asset('icons/star_full.svg'),
                                                                                  half: SvgPicture.asset('icons/star_full.svg'),
                                                                                  empty: SvgPicture.asset(
                                                                                    'icons/star_empty.svg',
                                                                                    color: IcoColors.yellow2,
                                                                                  ),
                                                                                ),
                                                                                itemSize: 18,
                                                                                onRatingUpdate: (rating) {
                                                                                  print(rating);
                                                                                },
                                                                              ),
                                                                            ),
                                                                            Positioned(
                                                                              left: 15,
                                                                              bottom: 17,
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  SizedBox(
                                                                                    width: 190,
                                                                                    child: Text(
                                                                                      (reviewController.reviewListWithPicture[index].value!.contents.length <= 16) ? reviewController.reviewListWithPicture[index].value!.contents : reviewController.reviewListWithPicture[index].value!.contents.substring(0, 15) + "...",
                                                                                      style: IcoTextStyle.boldTextStyle16W,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 7,
                                                                                  ),
                                                                                  Text(
                                                                                    dateFormatWithDot.format(reviewController.reviewListWithPicture[index].value!.date),
                                                                                    style: IcoTextStyle.mediumTextStyle13W,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ]),
                                                                    ),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                    ),
                                                                  ),
                                                            SizedBox(
                                                              width: 8,
                                                            )
                                                          ],
                                                        );
                                                      }),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                            SizedBox(
                              height: reviewController.reviewCount.value! * 165,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount:
                                            reviewController.reviewCount.value,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Column(
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                color: Colors.white,
                                                height: 165,
                                                width: IcoSize.width,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    RatingBar(
                                                      ignoreGestures: true,
                                                      initialRating:
                                                          reviewController
                                                              .finalReviewModelList![
                                                                  index]
                                                              .value!
                                                              .reviewRate!
                                                              .toDouble(),
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: false,
                                                      itemCount: 5,
                                                      ratingWidget:
                                                          RatingWidget(
                                                        full: SvgPicture.asset(
                                                            'icons/star_full.svg'),
                                                        half: SvgPicture.asset(
                                                            'icons/star_full.svg'),
                                                        empty: SvgPicture.asset(
                                                            'icons/star_empty.svg'),
                                                      ),
                                                      itemSize: 17,
                                                      onRatingUpdate: (rating) {
                                                        print(rating);
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 11,
                                                    ),
                                                    Text(
                                                      (reviewController
                                                                  .finalReviewModelList![
                                                                      index]
                                                                  .value!
                                                                  .contents
                                                                  .length <=
                                                              24)
                                                          ? reviewController
                                                              .finalReviewModelList![
                                                                  index]
                                                              .value!
                                                              .contents
                                                          : reviewController
                                                              .finalReviewModelList![
                                                                  index]
                                                              .value!
                                                              .contents
                                                              .substring(0, 23),
                                                      style: IcoTextStyle
                                                          .boldTextStyle16B,
                                                    ),
                                                    SizedBox(
                                                      height: 3,
                                                    ),
                                                    Text(
                                                      reviewController
                                                          .finalReviewModelList![
                                                              index]
                                                          .value!
                                                          .contents,
                                                      style: IcoTextStyle
                                                          .mediumTextStyle14Grey4,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          reviewController
                                                              .finalReviewModelList![
                                                                  index]
                                                              .value!
                                                              .userName
                                                              .replaceRange(
                                                                  1,
                                                                  reviewController
                                                                      .finalReviewModelList![
                                                                          index]
                                                                      .value!
                                                                      .userName
                                                                      .length,
                                                                  "**"),
                                                          style: IcoTextStyle
                                                              .mediumTextStyle13Grey4,
                                                        ),
                                                        Text(
                                                          dateFormatWithDot.format(
                                                              reviewController
                                                                  .finalReviewModelList![
                                                                      index]
                                                                  .value!
                                                                  .date),
                                                          style: IcoTextStyle
                                                              .mediumTextStyle13Grey4,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                height: 1,
                                                color: IcoColors.grey2,
                                              )
                                            ],
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            (reviewController.reviewCount.value ==
                                    reviewController.totalReviews.value)
                                ? SizedBox()
                                : InkWell(
                                    onTap: () async {
                                      reviewController.reviewCount.value =
                                          await reviewController.getMoreReviews(
                                              reviewController
                                                  .finalReviewModelList!,
                                              managerController
                                                  .managerModelList[managerNum]
                                                  .value!
                                                  .uid,
                                              '기말',
                                              'manager',
                                              reviewController
                                                  .reviewCount.value!,
                                              3);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 52,
                                      width: IcoSize.width,
                                      decoration: BoxDecoration(
                                        color: IcoColors.white,
                                        border: Border.symmetric(
                                          horizontal: BorderSide(
                                              width: 1, color: IcoColors.grey2),
                                        ),
                                      ),
                                      child: Text(
                                        "리뷰 더보기",
                                        style:
                                            IcoTextStyle.mediumTextStyle15Grey4,
                                      ),
                                    ),
                                  ),
                            Container(
                              height: 53,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  color: IcoColors.white,
                  child: Column(
                    children: [
                      IcoButton(
                          buttonColor: IcoColors.grey1,
                          onPressed: () async {
                            // BottomUpModal2();
                            bool confirm = await IcoOptionModal(
                                iconUrl: 'icons/loading.svg',
                                title: "산후도우미 변경을\n요청하시겠습니까?",
                                subtitle:
                                    '아이코코에서 변경 요청을 확인 후\n새로운 관리자를 배정해드립니다.',
                                option1: '취소',
                                option2: '변경');

                            if (confirm) {
                              authController
                                  .reservationModel.value!.changeManager = true;
                              authController
                                  .reservationModel.value!.changeManagerList!
                                  .add(managerController
                                      .managerModelList[managerNum].value!.uid);
                              await authController.updateReservationFirestore(
                                  authController.reservationModel.value!
                                      .reservationNumber);
                              await authController.setModelInfo();
                              Get.offAllNamed(Routes.HOME);
                            }
                          },
                          active: true.obs,
                          textStyle: IcoTextStyle.mediumTextStyle15B,
                          text: "산후도우미 변경 요청"),
                      // SizedBox(
                      //   height: 14,
                      // ),
                      // IcoButton(
                      //     buttonColor: IcoColors.grey1,
                      //     onPressed: () {
                      //       Get.to(RefundPage());
                      //     },
                      //     active: true.obs,
                      //     textStyle: IcoTextStyle.mediumTextStyle15B,
                      //     text: "서비스 환불 요청"),
                      // SizedBox(
                      //   height: 14,
                      // ),
                      // IcoButton(
                      //     buttonColor: IcoColors.grey1,
                      //     onPressed: () async {
                      //       companyController.companyModel.value =
                      //           await companyController.getFirebaseCompanyByUid(
                      //               authController
                      //                   .reservationModel.value!.chosenCompany);
                      //       Get.to(InquiryPage(), arguments: managerNum);
                      //     },
                      //     active: true.obs,
                      //     textStyle: IcoTextStyle.mediumTextStyle15B,
                      //     text: "문의하기"),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

class SpecialtyIndex extends StatelessWidget {
  SpecialtyIndex({
    Key? key,
    required this.specialty,
  }) : super(key: key);
  String specialty;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          specialty,
          style: IcoTextStyle.boldTextStyle18B,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          specialtyItems[specialty] ?? '',
          style: IcoTextStyle.mediumTextStyle13Grey4,
        ),
      ],
    );
  }
}

class SpecialtyBox extends StatelessWidget {
  SpecialtyBox({
    Key? key,
    required this.specialty,
  }) : super(key: key);
  String specialty;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 106,
      height: 92,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: IcoColors.grey2)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            specialtyItemsIcon[specialty] ?? "icons/mother_caring_icon.svg",
            color: IcoColors.primary,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            specialty,
            style: IcoTextStyle.mediumTextStyle16P,
          )
        ],
      ),
    );
  }
}
