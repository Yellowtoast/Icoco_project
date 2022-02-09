// ignore_for_file: constant_identifier_names
import 'package:app/bindings/calculator_bindings.dart';
import 'package:app/bindings/reserve_binding.dart';
import 'package:app/bindings/review_binding.dart';
import 'package:app/bindings/splash_binding.dart';
import 'package:app/bindings/home_binding.dart';
import 'package:app/bindings/login_binding.dart';
import 'package:app/bindings/signup_binding.dart';
import 'package:app/pages/calculator.dart';
import 'package:app/pages/calculator_result.dart';
import 'package:app/pages/home/home.dart';
import 'package:app/pages/login.dart';
import 'package:app/pages/manager/manager_detail.dart';
import 'package:app/pages/reservation/step1/substep_address/address1.dart';
import 'package:app/pages/reservation/step1/substep_address/address2.dart';
import 'package:app/pages/reservation/step1/substep_address/address3.dart';
import 'package:app/pages/reservation/step1/substep_voucher/voucher1.dart';
import 'package:app/pages/reservation/step1/substep_voucher/voucher_signed/voucher_signed1.dart';
import 'package:app/pages/reservation/step1/substep_voucher/voucher_signed/voucher_signed2.dart';
import 'package:app/pages/reservation/step1/substep_voucher/voucher_signed/voucher_signed3.dart';
import 'package:app/pages/reservation/step2/reserve/reserve_step2_finished.dart';
import 'package:app/pages/reservation/step2/reserve/reserve_step2_1.dart';
import 'package:app/pages/reservation/step2/reserve/reserve_step2_2.dart';
import 'package:app/pages/reservation/step2/reserve/reserve_step2_3_afterbirth.dart';
import 'package:app/pages/reservation/step2/reserve/reserve_step2_3_beforebirth.dart';
import 'package:app/pages/reservation/step2/reserve/reserve_step2_4.dart';
import 'package:app/pages/reservation/step2/reserve/reserve_step2_5.dart';
import 'package:app/pages/reservation/step2/reserve/reserve_step2_6.dart';
import 'package:app/pages/reservation/step2/reserve/reserve_step2_7.dart';
import 'package:app/pages/reservation/step2/reserve/reserve_step2_registered.dart';
import 'package:app/pages/reservation/step3/deposit_fee_status.dart';
import 'package:app/pages/reservation/step3/remaining_fee_status.dart';
import 'package:app/pages/review/final_review.dart';
import 'package:app/pages/review/midterm_review.dart';
import 'package:app/pages/signup/signup_step1.dart';
import 'package:app/pages/signup/signup_step2.dart';
import 'package:app/pages/signup/signup_step3.dart';
import 'package:app/pages/signup/signup_step4.dart';
import 'package:app/pages/signup/signup_step5.dart';
import 'package:app/pages/signup/signup_step6_intro.dart';
import 'package:app/pages/splash.dart';
import 'package:app/pages/start.dart';
import 'package:app/widgets/modal/result_modal.dart';
import 'package:get/get.dart';

class Routes {
  static const SPLASH = '/';
  static const APP = '/app';
  static const LOADING = '/loading';
  static const HOME = '/home';
  static const HOME_SKELETON = '/home';
  static const HOME_STEP1 = '/home/2';
  static const HOME_STEP2 = '/home/3';
  static const HOME_STEP3 = '/home/4';
  static const HOME_STEP4 = '/home/5';
  static const HOME_STEP5 = '/home/6';
  static const HOME_STEP6 = '/home/7';
  static const HOME_STEP7 = '/home/8';
  static const RESERVE_STEP2_1 = '/reserve/step2/1';
  static const RESERVE_STEP2_2 = '/reserve/step2/2';
  static const RESERVE_STEP2_3AFTER = '/reserve/step2/3';
  static const RESERVE_STEP2_3BEFORE = '/reserve/step2/3/beforebirth';
  static const RESERVE_STEP2_4 = '/reserve/step2/4';
  static const RESERVE_STEP2_5 = '/reserve/step2/5';
  static const RESERVE_STEP2_6 = '/reserve/step2/6';
  static const RESERVE_STEP2_7 = '/reserve/step2/7';
  static const RESERVE_STEP2_REGISTERED = '/reserve/step2/finished1';
  static const RESERVE_STEP2_FINISHED = '/reserve/step2/finished2';

  static const SEARCH = '/search';
  static const POSTING_STEP1 = '/posting/1';
  static const ACTIVITY = '/activity';
  static const REMAINING_STATUS = '/home/remaining_status';
  static const DEPOSIT_STATUS = '/home/deposit_status';
  static const START = '/start';
  static const LOGIN = '/signin';
  static const SIGNUP = '/signup';
  static const SIGNUP_STEP1 = '/signup/1';
  static const SIGNUP_STEP2 = '/signup/2';
  static const SIGNUP_STEP3 = '/signup/3';
  static const SIGNUP_STEP4 = '/signup/4';
  static const SIGNUP_STEP5 = '/signup/5';
  static const SIGNUP_STEP6 = '/signup/6';
  static const ADDRESS_1 = '/reserve/step1/address/1';
  static const ADDRESS_2 = '/reserve/step1/address/2';
  static const ADDRESS_3 = '/reserve/step1/address/3';
  static const VOUCHER_1 = '/reserve/step1/voucher/1';
  static const VOUCHER_SIGNED1 = '/reserve/step1/voucher/signed/1';
  static const VOUCHER_SIGNED2 = '/reserve/step1/voucher/signed/2';
  static const VOUCHER_SIGNED3 = '/reserve/step1/voucher/signed/3';
  static const MANAGER = '/manager';
  static const MIDTERM_REVIEW = '/review/midterm';
  static const FINAL_REVIEW = '/review/final';
  static const CALCULATOR = '/calculator';
  static const CALCULATOR_RESULT = '/calculator/result';
  static const EXTRAFEE_RESULT = '/extrafee_result';
  static final pages = [
    GetPage(
        name: Routes.SPLASH,
        page: () => SplashPage(),
        binding: AuthBindings(),
        transition: Transition.fadeIn),
    // GetPage(
    //     name: Routes.LOADING,
    //     page: () => LoadingPage(),
    //     binding: LoadingBindings(),
    //     transition: Transition.fade),

    GetPage(
        name: Routes.HOME,
        page: () => HomePage(),
        binding: HomeBindings(),
        transition: Transition.noTransition),
    // GetPage(
    //     name: Routes.HOME_SKELETON,
    //     page: () => HomeSkeletonPage(),
    //     binding: HomeSkeletonBindings(),
    //     transition: Transition.noTransition),
    GetPage(
        name: Routes.START,
        page: () => StartPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: Routes.LOGIN,
        page: () => LoginPage(),
        binding: LoginBindings(),
        transition: Transition.downToUp),
    GetPage(
        name: Routes.REMAINING_STATUS,
        page: () => RemainingFeeStatus(),
        transition: Transition.cupertino),
    GetPage(
        name: Routes.DEPOSIT_STATUS,
        page: () => DepositFeeStatus(),
        transition: Transition.cupertino),
    GetPage(
        name: Routes.SIGNUP_STEP1,
        page: () => SignupStep1Page(),
        binding: SignupBindings(),
        transition: Transition.noTransition),
    GetPage(
        name: Routes.SIGNUP_STEP2,
        page: () => SignupStep2Page(),
        // binding: SignupBindings(),
        transition: Transition.noTransition),
    GetPage(
        name: Routes.SIGNUP_STEP3,
        page: () => SignupStep3Page(),
        // binding: SignupBindings(),
        transition: Transition.noTransition),
    GetPage(
        name: Routes.SIGNUP_STEP4,
        page: () => SignupStep4Page(),
        // binding: SignupBindings(),
        transition: Transition.noTransition),
    GetPage(
        name: Routes.SIGNUP_STEP5,
        page: () => SignupStep5Page(),
        // binding: SignupBindings(),
        transition: Transition.noTransition),
    GetPage(
        name: Routes.SIGNUP_STEP6,
        page: () => SignupStep6Page(),
        // binding: SignupBindings(),
        transition: Transition.noTransition),
    GetPage(
        name: Routes.ADDRESS_1,
        page: () => AddressPage1(),
        binding: ReserveStep1Bindings(),
        transition: Transition.noTransition),
    GetPage(
        name: Routes.ADDRESS_2,
        page: () => AddressPage2(),
        transition: Transition.noTransition),
    GetPage(
        name: Routes.ADDRESS_3,
        page: () => AddressPage3(),
        transition: Transition.noTransition),
    GetPage(
        name: Routes.VOUCHER_1,
        page: () => VoucherStep1(),
        transition: Transition.noTransition),
    GetPage(
        name: Routes.VOUCHER_SIGNED1,
        page: () => VoucherSignedStep1(),
        transition: Transition.noTransition),
    GetPage(
        name: Routes.VOUCHER_SIGNED2,
        page: () => VoucherSignedStep2(),
        transition: Transition.noTransition),
    GetPage(
        name: Routes.VOUCHER_SIGNED3,
        page: () => VoucherSignedStep3(),
        transition: Transition.noTransition),
    GetPage(
        name: Routes.RESERVE_STEP2_1,
        page: () => ReserveStep2_1(),
        binding: ReserveStep2Bindings(),
        transition: Transition.noTransition),
    GetPage(
        name: Routes.RESERVE_STEP2_2,
        page: () => ReserveStep2_2(),
        binding: ReserveStep2Bindings(),
        transition: Transition.noTransition),
    GetPage(
        name: Routes.RESERVE_STEP2_3AFTER,
        page: () => ReserveStep3_AfterBirth(),
        binding: ReserveStep2Bindings(),
        transition: Transition.noTransition),
    GetPage(
        name: Routes.RESERVE_STEP2_3BEFORE,
        page: () => ReserveStep3_BeforeBirth(),
        binding: ReserveStep2Bindings(),
        transition: Transition.noTransition),
    GetPage(
        name: Routes.RESERVE_STEP2_4,
        page: () => ReserveStep2_4(),
        binding: ReserveStep2Bindings(),
        transition: Transition.noTransition),
    GetPage(
        name: Routes.RESERVE_STEP2_5,
        page: () => ReserveStep2_5(),
        binding: ReserveStep2Bindings(),
        transition: Transition.noTransition),
    GetPage(
        name: Routes.RESERVE_STEP2_6,
        page: () => ReserveStep2_6(),
        transition: Transition.noTransition),
    GetPage(
        name: Routes.RESERVE_STEP2_7,
        page: () => ReserveStep2_7(),
        transition: Transition.noTransition),
    GetPage(
        name: Routes.RESERVE_STEP2_REGISTERED,
        page: () => ReserveStep2_Registered(),
        transition: Transition.noTransition),
    GetPage(
        name: Routes.RESERVE_STEP2_FINISHED,
        page: () => ReserveStep2_Finished(),
        transition: Transition.noTransition),
    GetPage(
        name: Routes.MANAGER,
        page: () => ManagerDetailPage(),
        binding: ReviewBindings(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: Routes.MIDTERM_REVIEW,
        page: () => MidtermReviewPage(),
        transition: Transition.rightToLeft),
    GetPage(
        name: Routes.FINAL_REVIEW,
        page: () => FinalReviewPage(),
        transition: Transition.rightToLeft),
    GetPage(
        name: Routes.CALCULATOR,
        page: () => CalculatorPage(),
        binding: CalculatorBindings(),
        transition: Transition.rightToLeft),
    GetPage(
        name: Routes.CALCULATOR_RESULT,
        page: () => CalculatorResultPage(),
        transition: Transition.rightToLeft),
  ];
}
