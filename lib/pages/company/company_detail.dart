import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/company_controller.dart';
import 'package:app/controllers/review_controller.dart';
import 'package:app/helpers/formatter.dart';
import 'package:app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CompanyDetailPage extends StatelessWidget {
  CompanyController companyController = Get.find();
  ReviewController reviewController = Get.find();
  AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    var companyNum = Get.arguments;

    if (reviewController.totalReviews.value! >= 3) {
      reviewController.reviewCount.value = 3;
    } else {
      reviewController.reviewCount.value = reviewController.totalReviews.value;
    }
    return Obx(() {
      return Scaffold(
        appBar: IcoAppbar(
          title:
              "${companyController.companyModelList[companyNum].value!.companyName}",
          usePop: true,
          backgroundColor: IcoColors.purple2,
        ),
        backgroundColor: IcoColors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                color: IcoColors.purple2,
                width: IcoSize.width,
                height: 245,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 18,
                    ),
                    Container(
                      width: IcoSize.width - 40,
                      height: 200,
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
                                      companyController
                                              .companyModelList[companyNum]
                                              .value!
                                              .thumbnail ??
                                          'https://t1.daumcdn.net/cfile/tistory/2446863653FC18972F',
                                      width: 89,
                                      height: 89,
                                      fit: BoxFit.cover,
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
                                          text:
                                              "${companyController.companyModelList[companyNum].value!.companyName}\n",
                                          style: IcoTextStyle.boldTextStyle19B,
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: companyController
                                                    .companyModelList[
                                                        companyNum]
                                                    .value!
                                                    .address
                                                    .split("/")[0],
                                                style: IcoTextStyle
                                                    .mediumTextStyle12Grey4),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 63,
                                            height: 25,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: IcoColors.grey2),
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  'icons/star_full.svg',
                                                  height: 15,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  (companyController
                                                              .companyModelList[
                                                                  companyNum]
                                                              .value!
                                                              .totalReviewRate ==
                                                          0)
                                                      ? "0"
                                                      : "${(companyController.companyModelList[companyNum].value!.totalReviewRate ~/ companyController.companyModelList[companyNum].value!.totalReview).toDouble()}",
                                                  style: IcoTextStyle
                                                      .regularTextStyle12B,
                                                ),
                                                SizedBox(
                                                  width: 2,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 11,
                                          ),
                                          Container(
                                            width: 63,
                                            height: 25,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: IcoColors.grey2),
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "리뷰 ${companyController.companyModelList[companyNum].value!.totalReview}+",
                                                  style: IcoTextStyle
                                                      .regularTextStyle12Grey4,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Divider(
                                height: 1,
                                thickness: 1,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: IcoColors.grey1,
                                ),
                                width: IcoSize.width - 80,
                                height: 34,
                                child: Text(
                                  "전화상담 바로가기",
                                  style: IcoTextStyle.mediumTextStyle13P,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 215,
                padding: EdgeInsets.symmetric(horizontal: 30),
                color: IcoColors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      '업체정보',
                      style: IcoTextStyle.boldTextStyle16B,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 105,
                          child: Text(
                            '본명',
                            style: IcoTextStyle.boldTextStyle13B,
                          ),
                        ),
                        Text(
                          companyController
                              .companyModelList[companyNum].value!.companyName,
                          style: IcoTextStyle.regularTextStyle13Grey4,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 105,
                          child: Text(
                            '서비스 이용주소',
                            style: IcoTextStyle.boldTextStyle13B,
                          ),
                        ),
                        Text(
                          companyController
                              .companyModelList[companyNum].value!.phone,
                          style: IcoTextStyle.regularTextStyle13Grey4,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 105,
                          child: Text(
                            '홈페이지',
                            style: IcoTextStyle.boldTextStyle13B,
                          ),
                        ),
                        Text(
                          companyController
                              .companyModelList[companyNum].value!.homepage!,
                          style: IcoTextStyle.regularTextStyle13Grey4,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 105,
                          child: Text(
                            '블로그',
                            style: IcoTextStyle.boldTextStyle13B,
                          ),
                        ),
                        Text(
                          companyController
                              .companyModelList[companyNum].value!.blog!,
                          style: IcoTextStyle.regularTextStyle13Grey4,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 105,
                          child: Text(
                            '맘카페제휴',
                            style: IcoTextStyle.boldTextStyle13B,
                          ),
                        ),
                        Text(
                          companyController
                              .companyModelList[companyNum].value!.momcafe!,
                          style: IcoTextStyle.regularTextStyle13Grey4,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                color: IcoColors.grey1,
                height: 9,
                thickness: 9,
              ),
              (reviewController.finalReviewModelList!.isEmpty)
                  ? Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 45,
                          ),
                          Image.asset(
                            'images/failed_human_grey.png',
                            width: 120,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            '아직 등록된 리뷰가 없습니다.',
                            style: IcoTextStyle.boldTextStyle16Grey3,
                          )
                        ],
                      ))
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
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
                                                                            child:
                                                                                Container(
                                                                              width: 221,
                                                                              height: 221,
                                                                              decoration: BoxDecoration(
                                                                                color: IcoColors.grey1,
                                                                                borderRadius: BorderRadius.circular(10),
                                                                              ),
                                                                              child: Image.network(
                                                                                reviewController.reviewListWithPicture[index].value!.thumbnails![0],
                                                                                errorBuilder: (context, error, stackTrace) => Container(
                                                                                  width: 221,
                                                                                  height: 221,
                                                                                  decoration: BoxDecoration(
                                                                                    color: IcoColors.grey1,
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            decoration:
                                                                                BoxDecoration(color: Colors.black38),
                                                                          ),
                                                                          Positioned(
                                                                            left:
                                                                                15,
                                                                            top:
                                                                                17,
                                                                            child:
                                                                                RatingBar(
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
                                                                            left:
                                                                                15,
                                                                            bottom:
                                                                                17,
                                                                            child:
                                                                                Column(
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
                                          reviewController.reviewCount.value!,
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
                                                    initialRating: reviewController
                                                        .finalReviewModelList![
                                                            index]
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
                                    int reviewAdded =
                                        await reviewController.getMoreReviews(
                                            reviewController
                                                .finalReviewModelList!,
                                            companyController
                                                .companyModelList[companyNum]
                                                .value!
                                                .uid!,
                                            '기말',
                                            'company',
                                            reviewController.reviewCount.value!,
                                            3);
                                    reviewController.reviewCount.value =
                                        reviewController.reviewCount.value! +
                                            reviewAdded;
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
            ],
          ),
        ),
      );
    });
  }
}
