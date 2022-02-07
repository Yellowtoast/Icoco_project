import 'package:app/configs/colors.dart';
import 'package:app/configs/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class IcoAppbar extends StatelessWidget implements PreferredSizeWidget {
  IcoAppbar(
      {required this.title,
      this.usePop = true,
      this.iconColor = IcoColors.grey4,
      this.isDefault = true,
      this.backgroundColor = IcoColors.white,
      this.tapFunction});

  final String title;
  final bool usePop;
  final Color backgroundColor;
  Color iconColor;
  bool isDefault;
  void Function()? tapFunction;

  Widget popButton(context, void Function()? tapFunction) {
    onTap() {
      Get.back();
    }

    return Container(
      padding: EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: (tapFunction == null) ? onTap : tapFunction,
        child: Container(
          padding: EdgeInsets.only(right: 25),
          child: SvgPicture.asset(
            "icons/arrow_back.svg",
            color: IcoColors.grey4,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PreferredSize(
        child: AppBar(
          centerTitle: true,
          elevation: (isDefault) ? 4 : 0.0,
          bottomOpacity: 0.0,
          backgroundColor: backgroundColor,
          shadowColor: Colors.transparent,
          title: Text(
            title,
            style: (isDefault)
                ? IcoTextStyle.appbarTextStyleB
                : IcoTextStyle.appbarTextStyleW,
            textAlign: TextAlign.center,
          ),
          leading: usePop ? popButton(context, tapFunction) : Container(),
        ),
        preferredSize: Size.fromHeight(Get.height * 0.063),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Get.height * 0.073);
}
