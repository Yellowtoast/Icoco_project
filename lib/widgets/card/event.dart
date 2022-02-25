import 'package:app/configs/colors.dart';
import 'package:app/configs/constants.dart';
import 'package:app/configs/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EventCard extends StatelessWidget {
  EventCard({
    Key? key,
    required this.title,
    required this.thumbnail,
    required this.periodStart,
    required this.periodEnd,
    required this.status,
  }) : super(key: key);
  String title;
  String thumbnail;
  String periodStart;
  String periodEnd;
  String status;

  Widget _getStatusLabel(status) {
    String statusLabel = '진행중';
    Color statusTextColor = IcoColors.primary;
    Color statusBgColor = IcoColors.purple1;

    if (status == EventStatus.running) {
      statusLabel = '진행중';
      statusTextColor = IcoColors.primary;
      statusBgColor = IcoColors.purple1;
    } else if (status == EventStatus.completed) {
      statusLabel = '종료됨';
      statusTextColor = IcoColors.grey4;
      statusBgColor = IcoColors.grey1;
    } else if (status == EventStatus.announnced) {
      statusLabel = '당첨자 발표';
      statusTextColor = IcoColors.grey4;
      statusBgColor = IcoColors.yellow1;
    }

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: statusBgColor,
      ),
      width: 76,
      height: 28,
      child: Text(statusLabel,
          style: GoogleFonts.notoSans(
              fontSize: 13,
              color: statusTextColor,
              fontWeight: FontWeight.bold)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: Get.width / 2,
            margin: const EdgeInsets.only(bottom: 18),
            child: Image.network(
              thumbnail,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: Get.width - 120,
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(
                          title,
                          style: IcoTextStyle.boldTextStyle17B,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      _getStatusLabel(status),
                    ],
                  ),
                ),
                Text(
                  '$periodStart ~ $periodEnd',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.notoSans(
                    height: 1.4,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: IcoColors.grey4,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
