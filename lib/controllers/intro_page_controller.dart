import 'package:app/widgets/snackbar/snackbar.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

class IntroPageController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    iconSnackbar();
    Future.delayed(Duration(milliseconds: 800), () {
      Get.back();
    });
  }
}
