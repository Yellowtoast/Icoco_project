import 'package:app/configs/enum.dart';

extension Extention1 on serviceDurationType {
  String get convertDurationTypeToString {
    switch (this) {
      case serviceDurationType.ONEWEEK:
        return "1주";
      case serviceDurationType.TWOWEEK:
        return "2주";
      case serviceDurationType.THREEWEEK:
        return "3주";
      case serviceDurationType.FOURWEEK:
        return "4주";
      case serviceDurationType.FIVEWEEK:
        return "5주";
      default:
        return "";
    }
  }
}

extension Extention2 on carePriority {
  String get convertCarePriorityToString {
    switch (this) {
      case carePriority.CLEANING:
        return "정리정돈";
      case carePriority.COOKING:
        return "요리";
      case carePriority.MOTHERCARE:
        return "산모케어";
      case carePriority.BABYCARE:
        return "신생아케어";
      default:
        return "";
    }
  }
}

extension Extention3 on lactationType {
  String get convertLactationTypeToSting {
    switch (this) {
      case lactationType.BOTTLE_FEEDING:
        return "분유";
      case lactationType.BREAST_FEEDING:
        return "모유";
      case lactationType.MIX_FEEDING:
        return "혼합형";
      default:
        return "";
    }
  }
}

extension Extention4 on carePlaceType {
  String get convertCarePlaceTypeToString {
    switch (this) {
      case carePlaceType.OWN_HOUSE:
        return "자가";
      case carePlaceType.PARENTS_HOUSE:
        return "친정댁";
      case carePlaceType.IN_LAW_HOUSE:
        return "시댁";
      default:
        return "";
    }
  }
}

extension Extention5 on petType {
  String get convertPetTypeToString {
    switch (this) {
      case petType.DOG:
        return "강아지";
      case petType.CAT:
        return "고양이";
      case petType.ETC:
        return "기타";
      case petType.NONE:
        return "없음";
      default:
        return "";
    }
  }
}

extension Extention6 on careType {
  String get convertCareTypeToString {
    switch (this) {
      case careType.COMMUTER:
        return "출퇴근형";
      case careType.RESIDENT:
        return "입주형";
      default:
        return "";
    }
  }
}
