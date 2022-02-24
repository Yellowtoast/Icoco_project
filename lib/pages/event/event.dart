import 'package:app/configs/constants.dart';
import 'package:app/configs/routes.dart';
import 'package:app/controllers/event_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app/configs/text_styles.dart';
import 'package:app/configs/colors.dart';

import 'package:app/widgets/card/event.dart';

class EventPage extends StatelessWidget {
  const EventPage({Key? key}) : super(key: key);

  _onTapToDetailPage(id) {
    Get.toNamed(Routes.EVENT_DETAIL, arguments: {"eventId": id});
  }

  TabBar _getTabBar() {
    return const TabBar(
        labelColor: IcoColors.primary,
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelColor: IcoColors.grey4,
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        indicatorColor: IcoColors.primary,
        tabs: [
          Tab(
            text: '진행중 이벤트',
          ),
          Tab(
            text: '종료된 이벤트',
          ),
          Tab(
            text: '당첨자 발표',
          ),
        ]);
  }

  TabBarView _getTabBarView(tabs) {
    return TabBarView(
      children: tabs,
    );
  }

  Widget _getScollView(List<dynamic> list) {
    return SingleChildScrollView(
        child: Column(
      children: list.map((dynamic item) {
        return GestureDetector(
          onTap: () => _onTapToDetailPage(item.id),
          child: Container(
            margin: const EdgeInsets.only(bottom: 46),
            width: Get.width,
            child: EventCard(
              title: item.title,
              thumbnail: item.appBanner,
              status: item.status,
              periodStart: item.startDate,
              periodEnd: item.endDate,
            ),
          ),
        );
      }).toList(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    EventController eventController = Get.find();
    int tabLen = 3;
    int initialTabIndex = 0;

    return DefaultTabController(
      length: tabLen,
      initialIndex: initialTabIndex,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: IcoColors.white,
          shadowColor: IcoColors.grey1,
          elevation: 1,
          centerTitle: true,
          title: Text(
            '이벤트',
            style: IcoTextStyle.appbarTextStyleB,
            textAlign: TextAlign.center,
          ),
          bottom: _getTabBar(),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 28,
            ),
            Expanded(
              child: _getTabBarView([
                _getScollView(eventController.runningEvents),
                _getScollView(eventController.completedEvents),
                _getScollView(eventController.announcedEvents),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
