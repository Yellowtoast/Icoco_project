import 'package:app/configs/colors.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/event_detail_controller.dart';
import 'package:flutter/material.dart';

import 'package:app/widgets/appbar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class EventDetailPage extends StatelessWidget {
  const EventDetailPage({Key? key}) : super(key: key);

  void _onShare(BuildContext context) async {
    const String _content = 'share button test';

    Share.share(_content);
  }

  @override
  Widget build(BuildContext context) {
    EventDetailController eventDetailController = Get.find();

    return Obx(
      () => Scaffold(
        appBar: IcoAppbar(
            title: eventDetailController.title.value,
            usePop: true,
            actionButton: [
              Container(
                padding: const EdgeInsets.only(left: 20),
                child: GestureDetector(
                  onTap: () => _onShare(context),
                  child: Container(
                    padding: const EdgeInsets.only(right: 25),
                    child: SvgPicture.asset(
                      "icons/share.svg",
                      color: IcoColors.grey4,
                    ),
                  ),
                ),
              )
            ]),
        body: SafeArea(
            child: Container(
                width: Get.width,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: Get.width / 2,
                      child: eventDetailController.detailThumbnail.value != ''
                          ? Image.network(
                              eventDetailController.detailThumbnail.value,
                              fit: BoxFit.cover,
                            )
                          : Container(),
                    ),
                    const SizedBox(
                      height: 23,
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              eventDetailController.title.value,
                              style: IcoTextStyle.boldTextStyle24B,
                            ),
                            Text(
                              '${eventDetailController.startDate.value} ~ ${eventDetailController.endDate.value}',
                              style: GoogleFonts.notoSans(
                                height: 1.4,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: IcoColors.grey4,
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 24, bottom: 24),
                              child: const Divider(
                                height: 1,
                                color: IcoColors.grey2,
                              ),
                            ),
                            Container(
                              child: Text(
                                eventDetailController.contents.value,
                                style: GoogleFonts.notoSans(
                                  height: 1.6,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: IcoColors.black,
                                ),
                              ),
                            )
                          ],
                        ))
                  ],
                ))),
      ),
    );
  }
}
