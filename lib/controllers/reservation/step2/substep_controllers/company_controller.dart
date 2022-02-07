import 'package:app/models/reservation.dart';
import 'package:get/get.dart';

class CompanyController extends GetxController {
  Rxn<int> companySelected = Rxn<int>();
  RxBool isSelectedConpany = false.obs;

  RxList<Map<String, String?>> companyList = RxList<Map<String, String?>>([
    {"title": "디어케어", "address": "대구 남구 남산로 45"},
    {"title": "친정맘", "address": "대구 남구 남산로 45"},
    {"title": "단하루 산후도우미", "address": "대구 남구 남산로 45"},
    {"title": "업체는 상관없어요", "address": null},
  ]);

  updateCompanyToModel(Rxn<ReservationModel?> model) {
    model.value!.chosenCompany = companyList[companySelected.value!]["title"];
  }
}
