import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/home_controller.dart';
import 'package:app/models/reservation.dart';
import 'package:get/get.dart';

Map<int, String> stepTitle = {
  1: "바우처조회",
  2: "예약신청",
  3: "예약금입금",
  4: "잔금 입금",
  5: "배정 대기중",
  6: "도우미미리보기",
  7: "서비스 시작",
  8: "서비스 종료",
  9: "이벤트참여",
};

Map<String, String> stepInfo = {
  "1": "정부지원금 조회해보고\n산후도우미 예약 시작하기",
  "2": "어려운 산후도우미 예약\n쉽고 빠르게 신청하기",
  "3-1": "예약금 입금이 완료되어야\n예약이 완료됩니다",
  "3-2": "예약금 입금내역을\n확인중입니다",
  "4": "아직 잔금 입금이\n완료되지 않았습니다",
  "5-1": "산모님께 맞는 산후도우미를\n배정하는 중입니다",
  "5-2": "출산 후 정확한 일정으로\n예약을 도와드릴게요",
  "6": "산후도우미가\n파견 대기중입니다",
  "7": "산후도우미 서비스를\n이용중입니다",
  "8": "산후도우미 서비스가\n종료되었습니다",
  "9": "아이코코 이벤트에\n참여해보세요",
};
