import 'package:app/configs/colors.dart';
import 'package:app/configs/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class IcoBottomBar extends StatelessWidget {
  IcoBottomBar({Key? key, required this.selectedIndex, required this.onTap})
      : super(key: key);

  Rx<int> selectedIndex;
  Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 2,
      backgroundColor: IcoColors.white,
      selectedFontSize: 11,
      unselectedFontSize: 11,
      selectedItemColor: IcoColors.primary,
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex.value,
      showSelectedLabels: true,
      selectedLabelStyle: IcoTextStyle.boldTextStyle11P,
      onTap: onTap,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: (selectedIndex.value == 0)
              ? SvgPicture.asset("icons/active_nav_item1.svg")
              : SvgPicture.asset("icons/inactive_nav_item1.svg"),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: (selectedIndex.value == 1)
              ? SvgPicture.asset("icons/active_nav_item2.svg")
              : SvgPicture.asset("icons/inactive_nav_item2.svg"),
          label: '요금계산기',
        ),
        BottomNavigationBarItem(
          icon: (selectedIndex.value == 2)
              ? SvgPicture.asset("icons/active_nav_item3.svg")
              : SvgPicture.asset("icons/inactive_nav_item3.svg"),
          label: '이벤트',
        ),
        BottomNavigationBarItem(
          icon: (selectedIndex.value == 3)
              ? SvgPicture.asset("icons/active_nav_item4.svg")
              : SvgPicture.asset("icons/inactive_nav_item4.svg"),
          label: '마이페이지',
        ),
      ],
    );
  }
}
