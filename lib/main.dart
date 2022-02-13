import 'package:app/bindings/splash_binding.dart';
import 'package:app/configs/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'configs/routes.dart';
import 'helpers/adapter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(ReservationAdapter());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const IcocoApp());
}

class IcocoApp extends StatelessWidget {
  const IcocoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          backgroundColor: IcoColors.white,
          scaffoldBackgroundColor: IcoColors.white),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'),
        Locale('en', 'EN'),
      ],
      debugShowCheckedModeBanner: false,
      getPages: Routes.pages,
      initialRoute: Routes.SPLASH,
      initialBinding: InitialBindings(),
    );
  }
}
