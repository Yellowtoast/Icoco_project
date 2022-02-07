import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/manager_controller.dart';

import 'package:app/controllers/review_controller.dart';
import 'package:app/helpers/formatter.dart';
import 'package:app/widgets/appbar.dart';
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

class ManagerDetailPage extends StatelessWidget {
  int managerNum = Get.arguments;
  ManagerController managerController = Get.find();
  ReviewController reviewController = Get.find();

  AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: IcoAppbar(
          title:
              "${managerController.managerModelList[managerNum].value!.name} 도우미님",
          usePop: true,
          backgroundColor: IcoColors.purple2,
        ),
        backgroundColor: IcoColors.purple2,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        text:
                                            "${managerController.managerModelList[managerNum].value!.name}",
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
                                          .averageReviewRate!
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
                                    Text("대구 아이사랑 소속",
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    SvgPicture.asset(
                                      "icons/helper_auth_self.svg",
                                      color: IcoColors.primary,
                                    ),
                                    Text("본인인증 완료",
                                        style: IcoTextStyle.mediumTextStyle13P)
                                  ],
                                ),
                                Column(
                                  children: [
                                    SvgPicture.asset(
                                      "icons/helper_auth_hospital.svg",
                                      color: IcoColors.primary,
                                    ),
                                    Text("건강인증 완료",
                                        style: IcoTextStyle.mediumTextStyle13P)
                                  ],
                                ),
                                Column(
                                  children: [
                                    SvgPicture.asset(
                                      "icons/helper_auth_crime.svg",
                                      color: IcoColors.primary,
                                    ),
                                    Text("범죄이력 없음",
                                        style: IcoTextStyle.mediumTextStyle13P)
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                    "경력 3년이내",
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
                                    "50대",
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
                                    "리뷰 100+",
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
                      "관리자 정보",
                      style: IcoTextStyle.boldTextStyle14B,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 106,
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
                        Container(
                          width: 106,
                          height: 106,
                          decoration: BoxDecoration(
                              color: IcoColors.purple2,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset("icons/helper_info_home.svg"),
                              Text(
                                "입주 ${managerController.managerModelList[managerNum].value!.isResident}",
                                style: IcoTextStyle.boldTextStyle13P,
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 106,
                          height: 106,
                          decoration: BoxDecoration(
                              color: IcoColors.purple2,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset("icons/helper_info_cctv.svg"),
                              Text(
                                "CCTV${managerController.managerModelList[managerNum].value!.isCCTV}",
                                style: IcoTextStyle.boldTextStyle13P,
                              )
                            ],
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
                        Container(
                          width: 106,
                          height: 92,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(width: 1, color: IcoColors.grey2)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "icons/cleaning_icon.svg",
                                color: IcoColors.primary,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "정리정돈",
                                style: IcoTextStyle.mediumTextStyle16P,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "정리정돈",
                              style: IcoTextStyle.boldTextStyle18B,
                            ),
                            Text(
                              "청소를 깔끔하게 잘 하세요",
                              style: IcoTextStyle.mediumTextStyle13Grey4,
                            ),
                          ],
                        )
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
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Text("리뷰", style: IcoTextStyle.boldTextStyle14B),
                              SizedBox(
                                width: 6,
                              ),
                              Text("${reviewController.totalReviews}개",
                                  style: IcoTextStyle.boldTextStyle14P)
                            ],
                          ),
                        ),
                        (reviewController.allThumbnailsForReview.isEmpty)
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
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount: 1,
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
                                                            .finalReviewModelList![
                                                                index]
                                                            .value!
                                                            .thumbnails!
                                                            .isEmpty)
                                                        ? SizedBox()
                                                        : Container(
                                                            height: 221,
                                                            width: 221,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              child: Stack(
                                                                  children: [
                                                                    Positioned(
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            221,
                                                                        height:
                                                                            221,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              IcoColors.grey1,
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                        ),
                                                                        child: Image
                                                                            .network(
                                                                          reviewController
                                                                              .finalReviewModelList![index]
                                                                              .value!
                                                                              .thumbnails![0],
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                              color: Colors.black38),
                                                                    ),
                                                                    Positioned(
                                                                      left: 15,
                                                                      top: 17,
                                                                      child:
                                                                          RatingBar(
                                                                        ignoreGestures:
                                                                            true,
                                                                        initialRating: reviewController
                                                                            .finalReviewModelList![index]
                                                                            .value!
                                                                            .reviewRate!
                                                                            .toDouble(),
                                                                        direction:
                                                                            Axis.horizontal,
                                                                        allowHalfRating:
                                                                            false,
                                                                        itemCount:
                                                                            5,
                                                                        ratingWidget:
                                                                            RatingWidget(
                                                                          full:
                                                                              SvgPicture.asset('icons/star_full.svg'),
                                                                          half:
                                                                              SvgPicture.asset('icons/star_full.svg'),
                                                                          empty:
                                                                              SvgPicture.asset(
                                                                            'icons/star_empty.svg',
                                                                            color:
                                                                                IcoColors.yellow2,
                                                                          ),
                                                                        ),
                                                                        itemSize:
                                                                            18,
                                                                        onRatingUpdate:
                                                                            (rating) {
                                                                          print(
                                                                              rating);
                                                                        },
                                                                      ),
                                                                    ),
                                                                    Positioned(
                                                                      left: 15,
                                                                      bottom:
                                                                          17,
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          SizedBox(
                                                                            width:
                                                                                190,
                                                                            child:
                                                                                Text(
                                                                              (reviewController.finalReviewModelList![index].value!.contents.length <= 16) ? reviewController.finalReviewModelList![index].value!.contents : reviewController.finalReviewModelList![index].value!.contents.substring(0, 15) + "...",
                                                                              style: IcoTextStyle.boldTextStyle16W,
                                                                              overflow: TextOverflow.ellipsis,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                7,
                                                                          ),
                                                                          Text(
                                                                            dateFormatWithDot.format(reviewController.finalReviewModelList![index].value!.date),
                                                                            style:
                                                                                IcoTextStyle.mediumTextStyle13W,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ]),
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
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
                      height:
                          reviewController.finalReviewModelList!.length * 165,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: reviewController
                                    .finalReviewModelList!.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
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
                                              initialRating: reviewController
                                                  .finalReviewModelList![index]
                                                  .value!
                                                  .reviewRate!
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
                                              style:
                                                  IcoTextStyle.boldTextStyle16B,
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              reviewController
                                                  .finalReviewModelList![index]
                                                  .value!
                                                  .contents,
                                              style: IcoTextStyle
                                                  .mediumTextStyle14Grey4,
                                              overflow: TextOverflow.ellipsis,
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
                    InkWell(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        height: 52,
                        width: IcoSize.width,
                        decoration: BoxDecoration(
                          color: IcoColors.white,
                          border: Border.symmetric(
                            horizontal:
                                BorderSide(width: 1, color: IcoColors.grey2),
                          ),
                        ),
                        child: Text(
                          "리뷰 더보기",
                          style: IcoTextStyle.mediumTextStyle15Grey4,
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
                              subtitle: '아이코코에서 변경 요청을 확인 후\n새로운 관리자를 배정해드립니다.',
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
                                authController
                                    .reservationModel.value!.reservationNumber);
                            await authController.setModelInfo();
                            Get.offAllNamed(Routes.HOME);
                          } else {}
                        },
                        active: true.obs,
                        textStyle: IcoTextStyle.mediumTextStyle15B,
                        text: "산후도우미 변경 요청"),
                    SizedBox(
                      height: 14,
                    ),
                    IcoButton(
                        buttonColor: IcoColors.grey1,
                        onPressed: () {},
                        active: true.obs,
                        textStyle: IcoTextStyle.mediumTextStyle15B,
                        text: "서비스 환불 요청"),
                    SizedBox(
                      height: 14,
                    ),
                    IcoButton(
                        buttonColor: IcoColors.grey1,
                        onPressed: () {},
                        active: true.obs,
                        textStyle: IcoTextStyle.mediumTextStyle15B,
                        text: "문의하기"),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
