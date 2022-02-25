import 'dart:core';

import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  static const INSURANCE_APP_IOS =
      'https://apps.apple.com/kr/app/the건강보험/id375279377';
  static const INSURANCE_APP_ANDROID =
      'https://play.google.com/store/apps/details?id=kr.or.nhic';
  static const INSURANCE_APP_PC = 'https://www.nhis.or.kr/nhis/index.do';

  void launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void call(call) async {
    if (await canLaunch(call)) {
      await launch(call);
    } else {
      throw 'error call';
    }
  }

  void sms(sms) async {
    if (await canLaunch(sms)) {
      await launch(sms);
    } else {
      throw 'error sms';
    }
  }
}
