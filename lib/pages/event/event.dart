import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app/configs/text_styles.dart';
import 'package:app/configs/colors.dart';

import 'package:app/widgets/card/event.dart';

class EventPage extends StatelessWidget {
  const EventPage({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: IcoColors.white,
          shadowColor: Colors.transparent,
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
              height: 8,
            ),
            Expanded(
              child: _getTabBarView([
                SingleChildScrollView(
                    child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 46),
                      width: Get.width,
                      child: EventCard(
                        title: '아이코코 런칭 이벤트 아이코코',
                        thumbnail:
                            'https://random.dog/3f62f2c1-e0cb-4077-8cd9-1ca76bfe98d5.jpg',
                        status: 'running',
                        periodStart: 20220101,
                        periodEnd: 20220301,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 46),
                      width: Get.width,
                      child: EventCard(
                        title: '아이코코 런칭 이벤트 아이코코',
                        thumbnail:
                            'https://random.dog/3f62f2c1-e0cb-4077-8cd9-1ca76bfe98d5.jpg',
                        status: 'running',
                        periodStart: 20220101,
                        periodEnd: 20220301,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 46),
                      width: Get.width,
                      child: EventCard(
                        title: '아이코코 런칭 이벤트 아이코코',
                        thumbnail:
                            'https://random.dog/3f62f2c1-e0cb-4077-8cd9-1ca76bfe98d5.jpg',
                        status: 'running',
                        periodStart: 20220101,
                        periodEnd: 20220301,
                      ),
                    ),
                  ],
                )),
                SingleChildScrollView(
                    child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 46),
                      width: Get.width,
                      child: EventCard(
                        title: '아이코코 런칭 이벤트 아이코코',
                        thumbnail:
                            'https://random.dog/3f62f2c1-e0cb-4077-8cd9-1ca76bfe98d5.jpg',
                        status: 'completed',
                        periodStart: 20220101,
                        periodEnd: 20220301,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 46),
                      width: Get.width,
                      child: EventCard(
                        title: '아이코코 런칭 이벤트 아이코코',
                        thumbnail:
                            'https://random.dog/3f62f2c1-e0cb-4077-8cd9-1ca76bfe98d5.jpg',
                        status: 'completed',
                        periodStart: 20220101,
                        periodEnd: 20220301,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 46),
                      width: Get.width,
                      child: EventCard(
                        title: '아이코코 런칭 이벤트 아이코코',
                        thumbnail:
                            'https://random.dog/3f62f2c1-e0cb-4077-8cd9-1ca76bfe98d5.jpg',
                        status: 'completed',
                        periodStart: 20220101,
                        periodEnd: 20220301,
                      ),
                    ),
                  ],
                )),
                SingleChildScrollView(
                    child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 46),
                      width: Get.width,
                      child: EventCard(
                        title: '아이코코 런칭 이벤트 아이코코',
                        thumbnail:
                            'https://random.dog/3f62f2c1-e0cb-4077-8cd9-1ca76bfe98d5.jpg',
                        status: 'after',
                        periodStart: 20220101,
                        periodEnd: 20220301,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 46),
                      width: Get.width,
                      child: EventCard(
                        title: '아이코코 런칭 이벤트 아이코코',
                        thumbnail:
                            'https://random.dog/3f62f2c1-e0cb-4077-8cd9-1ca76bfe98d5.jpg',
                        status: 'after',
                        periodStart: 20220101,
                        periodEnd: 20220301,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 46),
                      width: Get.width,
                      child: EventCard(
                        title: '아이코코 런칭 이벤트 아이코코',
                        thumbnail:
                            'https://random.dog/3f62f2c1-e0cb-4077-8cd9-1ca76bfe98d5.jpg',
                        status: 'after',
                        periodStart: 20220101,
                        periodEnd: 20220301,
                      ),
                    ),
                  ],
                )),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
