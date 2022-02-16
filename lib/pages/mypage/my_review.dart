import 'package:app/configs/colors.dart';
import 'package:app/configs/enum.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/manager_controller.dart';
import 'package:app/controllers/mypage_controller.dart';
import 'package:app/controllers/review_controller.dart';
import 'package:app/helpers/formatter.dart';
import 'package:app/helpers/loading.dart';
import 'package:app/pages/home/home_skeleton.dart';
import 'package:app/pages/reservation/step2/reserve/reserve_step2_4.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/button/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../loading.dart';

class MyReviewPage extends StatelessWidget {
  MyReviewPage({Key? key}) : super(key: key);
  AuthController authController = Get.find();
  ManagerController managerController = Get.find();
  ReviewController reviewController = Get.find();
  MypageController mypageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IcoAppbar(title: '평가/후기관리'),
      backgroundColor: IcoColors.grey1,
      body: SingleChildScrollView(
        child: Obx(() {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: IcoSize.width,
                  height: managerController.managerModelList.length * 200,
                  color: IcoColors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20),
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
                      SizedBox(
                        height: managerController.managerModelList.length * 134,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.all(0),
                          scrollDirection: Axis.vertical,
                          itemCount: managerController.managerModelList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(children: [
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
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.network(
                                            "${managerController.managerModelList[index].value!.profileImage}",
                                            width: 89,
                                            height: 89,
                                            fit: BoxFit.cover,
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
                                                    .managerModelList[index]
                                                    .value!
                                                    .name,
                                                style: IcoTextStyle
                                                    .boldTextStyle19B,
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
                                              initialRating: (managerController
                                                          .managerModelList[
                                                              index]
                                                          .value!
                                                          .totalReview ==
                                                      0)
                                                  ? 0
                                                  : (managerController
                                                              .managerModelList[
                                                                  index]
                                                              .value!
                                                              .totalReviewRate ~/
                                                          managerController
                                                              .managerModelList[
                                                                  index]
                                                              .value!
                                                              .totalReview)
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
                                              reviewController
                                                      .finalReviewModelList =
                                                  await reviewController
                                                      .getJsonReviews(
                                                          managerController
                                                              .managerModelList[
                                                                  index]
                                                              .value!
                                                              .uid,
                                                          'manager',
                                                          0,
                                                          3,
                                                          '기말');
                                              finishLoadingIndicator();
                                              Get.toNamed(Routes.MANAGER,
                                                  arguments: index);
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
                            ]);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                DateLabelButton(
                  iconUrl: 'icons/speech_bubble.svg',
                  leadingIconColor: IcoColors.purple3,
                  onTap: () {
                    Get.toNamed(Routes.MIDTERM_REVIEW, arguments: {
                      "managerNum": 0,
                      "reviewModelList": mypageController.middleReviewModelList,
                    });
                  },
                  title: '중간평가',
                  date: (mypageController.middleReviewModelList!.isNotEmpty)
                      ? dateFormatWithDot.format(mypageController
                          .middleReviewModelList![0].value!.date)
                      : '아직 작성 전입니다.',
                  titleTextStyle: IcoTextStyle.boldTextStyle16B,
                  dateTextStyle: IcoTextStyle.regularTextStyle13B,
                ),
                SizedBox(
                  height: 14,
                ),
                DateLabelButton(
                  iconUrl: 'icons/speech_bubble.svg',
                  leadingIconColor: IcoColors.primary,
                  onTap: () {
                    if (mypageController.finalReviewModelList!.isNotEmpty) {
                      Get.toNamed(Routes.FINAL_REVIEW, arguments: 0);
                    }
                  },
                  title: '기말평가',
                  date: (mypageController.finalReviewModelList!.isNotEmpty)
                      ? dateFormatWithDot.format(
                          mypageController.finalReviewModelList![0].value!.date)
                      : '작성 전',
                  titleTextStyle: IcoTextStyle.boldTextStyle16B,
                  dateTextStyle:
                      (mypageController.finalReviewModelList!.isNotEmpty)
                          ? IcoTextStyle.regularTextStyle13B
                          : IcoTextStyle.regularTextStyle13Grey4,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class DateLabelButton extends StatelessWidget {
  DateLabelButton({
    Key? key,
    required this.onTap,
    required this.iconUrl,
    required this.title,
    required this.titleTextStyle,
    required this.dateTextStyle,
    this.buttonColor = IcoColors.white,
    this.arrowColor = IcoColors.grey3,
    this.iconHeight = 37,
    this.height = 70,
    this.date,
    this.leadingIconColor = Colors.black12,
  }) : super(key: key);
  void Function()? onTap;
  String iconUrl;
  String title;
  TextStyle titleTextStyle;
  TextStyle dateTextStyle;
  Color buttonColor;
  Color arrowColor;
  Color? leadingIconColor;
  double iconHeight;
  double height;
  String? date;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        width: IcoSize.width - 40,
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(10)),
        child: SizedBox(
          width: IcoSize.width - 40,
          child: Row(
            children: [
              Container(
                width: IcoSize.width - 150,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      iconUrl,
                      height: iconHeight,
                      color: leadingIconColor,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      title,
                      style: titleTextStyle,
                    ),
                    SizedBox(
                      width: 13,
                    ),
                    Container(
                      color: IcoColors.grey2,
                      height: 42,
                      width: 1,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      date ?? '',
                      style: dateTextStyle,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: SvgPicture.asset(
                    'icons/arrow_thin_right.svg',
                    color: arrowColor,
                    height: 28,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// dateFormatWithDot
//                     .format(reviewController.reviewModel.value!.date)