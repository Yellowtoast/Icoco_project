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
      this.hasShadow = true,
      this.backgroundColor = IcoColors.white,
      this.actionButton,
      this.tapFunction});

  final String title;
  final bool usePop;
  final Color backgroundColor;
  Color iconColor;
  bool hasShadow;
  void Function()? tapFunction;
  List<Widget>? actionButton;

  Widget popButton(context, void Function()? tapFunction) {
    onTap() {
      Get.back();
    }

    return GestureDetector(
      onTap: (tapFunction == null) ? onTap : tapFunction,
      child: InkWell(
        child: Container(
          width: 100,
          height: 20,
          padding: EdgeInsets.all(17),
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
          elevation: (hasShadow) ? 0.3 : 0.0,
          bottomOpacity: 0.0,
          backgroundColor: backgroundColor,
          shadowColor:
              (hasShadow) ? Color.fromARGB(22, 0, 0, 0) : Colors.transparent,
          actions: (actionButton == null) ? [] : actionButton,
          title: Text(
            title,
            style: (hasShadow)
                ? IcoTextStyle.appbarTextStyleB
                : IcoTextStyle.appbarTextStyleW,
            textAlign: TextAlign.center,
          ),
          leading: usePop ? popButton(context, tapFunction) : Container(),
        ),
        preferredSize: preferredSize,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Get.height * 0.070);
}
