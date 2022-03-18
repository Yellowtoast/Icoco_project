import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../configs/colors.dart';
import '../../configs/routes.dart';
import '../../configs/size.dart';
import '../../configs/text_styles.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/autoscroll_controller.dart';
import '../../controllers/event_controller.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/notice_controller.dart';
import '../../widgets/button/grey_border_button.dart';
import '../../widgets/loading/loading.dart';
import '../../widgets/modal/info_modal.dart';
import '../mypage/my_reservation.dart';
import 'home_skeleton.dart';

class HomeSkeletonPage extends StatefulWidget {
  const HomeSkeletonPage({Key? key}) : super(key: key);

  @override
  State<HomeSkeletonPage> createState() => _HomeSkeleton2State();
}

class _HomeSkeleton2State extends State<HomeSkeletonPage> {
  AuthController authController = Get.find();
  HomeController homeController = Get.find();
  final NoticeController _noticeController =
      Get.put(NoticeController(), tag: 'fromHome');
  final EventController _eventController =
      Get.put(EventController(), tag: 'fromHome');

  Widget sizeWidthBox(double width) => SizedBox(
        width: width,
      );
  Widget sizeHeightBox(double height) => SizedBox(
        height: height,
      );

  Widget circularButton(String label, void Function() onPressed) {
    String iconName = '';
    void Function() onTap = onPressed;

    if (label == '공지사항') iconName = 'home_service_intro';
    if (label == '육아팁') iconName = 'home_tip';
    if (label == 'FAQ') iconName = 'home_FAQ';

    double boxSize = 78;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints.tightFor(width: boxSize, height: boxSize),
          child: ElevatedButton(
            child: SvgPicture.asset("icons/$iconName.svg"),
            onPressed: onTap,
            style: TextButton.styleFrom(
                backgroundColor: IcoColors.white,
                shape: const CircleBorder(),
                side: const BorderSide(color: IcoColors.grey2),
                shadowColor: Colors.transparent,
                elevation: 0),
          ),
        ),
        sizeHeightBox(12),
        Text(
          label,
          style: IcoTextStyle.boldTextStyle14B,
        )
      ],
    );
  }

  Widget noticeRow(String type, String title, void Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                type,
                style: IcoTextStyle.boldTextStyle14P,
              ),
            ),
            Expanded(
              flex: 6,
              child: Text(
                title,
                style: IcoTextStyle.mediumTextStyle14B,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showPopup(BuildContext context, int userStep, String? isFinishedDeposit,
      String? isFinishedBalance) {
    if (userStep == 3 &&
        isFinishedDeposit == '입금완료' &&
        isFinishedBalance != '입금완료') {
      DepositCostStatusPopup();
    } else if (userStep == 3 &&
        isFinishedBalance == '입금완료' &&
        isFinishedDeposit == '입금완료') {
      UserCostStatusPopup();
    } else if (userStep == 4 &&
        isFinishedBalance == '입금완료' &&
        isFinishedDeposit == '입금완료') {
      RemainingCostStatusPopup();
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   Future.delayed(Duration.zero, () {
  //     if (authController.reservationModel.value != null &&
  //         authController.openPopup.value == true) {
  //       showPopup(
  //           context,
  //           authController.reservationModel.value!.userStep,
  //           authController.reservationModel.value!.isFinishedDeposit,
  //           authController.reservationModel.value!.isFinishedBalance);
  //     }
  //   });

  // Future.delayed(Duration.zero, () {
  //   if (authController.reservationModel.value != null &&
  //       authController.reservationModel.value!.changeManager == true &&
  //       authController.reservationModel.value!.changeManagerList!.isEmpty) {
  //     BottomUpModal2(
  //         title: "산후도우미 변경 완료",
  //         subtitle: "산후도우미 변경 요청으로\n다른 도우미님으로 변경되었습니다\n메인페이지에서 확인바랍니다.",
  //         buttonText: "확인 완료",
  //         onTap: () async {
  //           authController.reservationModel.value!.changeManager = false;
  //           await authController.updateReservationFirestore(
  //               authController.reservationModel.value!.reservationNumber);

  //           await authController.setModelInfo();
  //           Get.offAllNamed(Routes.HOME);
  //         });
  //   }
  // });
  AutoScrollController autoScrollController = Get.put(AutoScrollController());
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      print("addPostFrameCallback");
      autoScrollController.startScrollController();

      if (authController.reservationModel.value != null &&
          authController.openPopup.value == true) {
        showPopup(
            context,
            authController.reservationModel.value!.userStep,
            authController.reservationModel.value!.isFinishedDeposit,
            authController.reservationModel.value!.isFinishedBalance);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: IcoColors.primary,
      onRefresh: () async {
        await authController.setModelInfo();
        Get.offAllNamed(Routes.HOME);
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 60, 0, 25),
              decoration: BoxDecoration(
                color: IcoColors.purple2,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: Get.width - 40,
                    child: Row(
                      children: [
                        SvgPicture.asset("icons/home_helper.svg"),
                        const SizedBox(
                          width: 7,
                        ),
                        Obx(() {
                          return Text(
                            "${homeController.homeInfoModel.value.userName}님의 진행단계",
                            style: IcoTextStyle.homeLabelTextStyleBold,
                          );
                        })
                      ],
                    ),
                  ),
                  sizeHeightBox(14),
                  Container(
                    height: 65,
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            controller: autoScrollController.scrollController,
                            shrinkWrap: true,
                            itemCount: 9,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                children: [
                                  SizedBox(
                                    width: (index == 0) ? 20 : 8,
                                  ),
                                  SvgPicture.asset((homeController.homeInfoModel
                                                  .value.userStep -
                                              1 ==
                                          index)
                                      ? "icons/active_step${index + 1}.svg"
                                      : "icons/inactive_step${index + 1}.svg"),
                                  SizedBox(
                                    width: (index == 8) ? 20 : 0,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  sizeHeightBox(18),
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
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: IcoColors.purple1,
                              ),
                              width: 66,
                              height: 28,
                              child: Text(
                                  "STEP ${authController.homeModel.value.userStep}",
                                  style: GoogleFonts.notoSans(
                                      fontSize: 13,
                                      color: IcoColors.primary,
                                      fontWeight: FontWeight.bold)),
                            ),
                            sizeWidthBox(5),
                            Text(
                              (homeController.statusRefund.value)
                                  ? '환불 진행중'
                                  : homeController.userStepTitle.value ?? "",
                              style: IcoTextStyle.boldTextStyle14P,
                            )
                          ],
                        ),
                        sizeHeightBox(10),
                        Text(
                          (homeController.statusRefund.value)
                              ? '환불요청을 검토중입니다'
                              : homeController.userStepInfo.value ?? "",
                          style: IcoTextStyle.headingStyleBold,
                        ),
                        sizeHeightBox(20),
                        (homeController.statusRefund.value)
                            ? GreyBorderButton(
                                onTap: () {
                                  Get.to(MyReservationPage());
                                },
                                width: double.infinity,
                              )
                            : homeController.setWidgetsForStep,
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  (homeController.userStep.value > 2 &&
                          homeController.reservationModel.value!.isBirth ==
                              false)
                      ? HomeNotifyButton(
                          iconUrl: 'icons/baby.svg',
                          onTap: () {
                            authController.reservationModel.value!.isBirth =
                                true;
                            authController.reservationModel.value!.status =
                                '예약출산일확정';

                            Get.toNamed(Routes.RESERVE_STEP2_3_AFTER);
                          },
                          title: '출산 통보하기',
                          subtitle: '출산하셨나요? 출산일을 알려주세요!\n출산 후에 모든 일정이 확정됩니다.',
                          titleTextStyle: IcoTextStyle.boldTextStyle16B,
                          subtitleTextStyle: IcoTextStyle.regularTextStyle13B,
                        )
                      : (homeController.reservationModel.value
                                      ?.midtermReviewFinished ==
                                  false &&
                              homeController.userStep.value == 7)
                          ? HomeNotifyButton(
                              iconUrl: 'icons/register_paper.svg',
                              onTap: () {
                                Get.toNamed(Routes.MIDTERM_REVIEW, arguments: {
                                  "managerNum": 0,
                                  "editReview": false
                                });
                              },
                              title: '서비스 중간평가',
                              subtitle: '중간평가를 통해 후기를 남겨보세요',
                              titleTextStyle: IcoTextStyle.boldTextStyle16W,
                              subtitleTextStyle:
                                  IcoTextStyle.regularTextStyle13W,
                              buttonColor: IcoColors.primary,
                              iconHeight: 39,
                            )
                          : (homeController.reservationModel.value
                                          ?.finalReviewFinished ==
                                      false &&
                                  homeController.userStep.value >= 8)
                              ? HomeNotifyButton(
                                  iconUrl: 'icons/register_paper.svg',
                                  onTap: () {
                                    Get.toNamed(Routes.FINAL_REVIEW,
                                        arguments: {
                                          'managerNum': 0,
                                          "editReview": false
                                        });
                                  },
                                  title: '기말평가 및 리뷰작성',
                                  subtitle: '기말평가를 통해 후기를 남겨보세요',
                                  titleTextStyle: IcoTextStyle.boldTextStyle16W,
                                  subtitleTextStyle:
                                      IcoTextStyle.regularTextStyle13W,
                                  buttonColor: IcoColors.primary,
                                  iconHeight: 39,
                                )
                              : (homeController.userStep.value >= 9)
                                  ? HomeNotifyButton(
                                      iconUrl: 'icons/register_paper2.svg',
                                      onTap: () {
                                        loading(() async {
                                          authController.reservationModel.value!
                                              .userStep = 0;
                                          await authController
                                              .updateReservationFirestore(
                                                  authController
                                                      .reservationModel
                                                      .value!
                                                      .reservationNumber);
                                          await authController.setModelInfo();
                                          Get.offAllNamed(Routes.HOME);
                                        });
                                      },
                                      title: '서비스 신규신청하기',
                                      subtitle: '새로운 서비스 신청을 진행하시겠습니까?',
                                      titleTextStyle:
                                          IcoTextStyle.boldTextStyle16P,
                                      subtitleTextStyle:
                                          IcoTextStyle.regularTextStyle13P,
                                      buttonColor: IcoColors.white,
                                      iconHeight: 39,
                                    )
                                  : SizedBox()
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 24, 0, 28),
              decoration: const BoxDecoration(
                color: IcoColors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  circularButton('공지사항', () => Get.toNamed(Routes.NOTICE)),
                  sizeWidthBox(32),
                  circularButton('육아팁',
                      () => Get.toNamed(Routes.TIP, arguments: 'fromBinding')),
                  sizeWidthBox(32),
                  circularButton('FAQ', () => {})
                ],
              ),
            ),
            Container(
              width: Get.width - 40,
              height: 1,
              color: IcoColors.grey2,
            ),
            sizeHeightBox(24),
            Obx(() {
              homeController.setNoticeEventCount(
                  _noticeController.noticeModelList.length,
                  _eventController.runningEvents.length);
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    ListView.builder(
                        padding: EdgeInsets.all(0),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: homeController.noticeLength.value,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return noticeRow('공지',
                              _noticeController.noticeModelList[index].title,
                              () {
                            Get.toNamed(Routes.NOTICE_DETAIL, arguments: {
                              'noticeNum': index,
                              'controllerTag': 'fromHome'
                            });
                          });
                        }),
                    ListView.builder(
                        padding: EdgeInsets.all(0),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: homeController.eventLength.value,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return noticeRow('이벤트',
                              _eventController.runningEvents[index].title, () {
                            Get.toNamed(Routes.EVENT_DETAIL, arguments: {
                              'eventId':
                                  _eventController.runningEvents[index].id
                            });
                          });
                        }),
                  ],
                ),
              );
            }),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}

class HomeNotifyButton extends StatelessWidget {
  HomeNotifyButton({
    Key? key,
    required this.onTap,
    required this.iconUrl,
    required this.title,
    required this.subtitle,
    required this.titleTextStyle,
    required this.subtitleTextStyle,
    this.buttonColor = IcoColors.white,
    this.arrowColor = IcoColors.grey3,
    this.iconHeight = 59,
  }) : super(key: key);
  void Function()? onTap;
  String iconUrl;
  String title;
  TextStyle titleTextStyle;
  String subtitle;
  TextStyle subtitleTextStyle;
  Color buttonColor;
  Color arrowColor;
  double iconHeight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // padding: EdgeInsets.all(18),
        padding: EdgeInsets.fromLTRB(20, 18, 18, 18),
        width: IcoSize.width - 40,
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(10)),
        child: SizedBox(
          width: IcoSize.width - 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                iconUrl,
                height: iconHeight,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: titleTextStyle,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    subtitle,
                    style: subtitleTextStyle,
                  ),
                ],
              ),
              Container(
                width: 40,
                alignment: Alignment.centerRight,
                child: SvgPicture.asset(
                  'icons/arrow_thin_right.svg',
                  color: arrowColor,
                  height: 28,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
