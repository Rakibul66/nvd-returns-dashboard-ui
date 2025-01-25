import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scanpackage/controller/barcode_controller.dart';
import 'package:scanpackage/controller/connectivity_controller.dart';
import 'package:scanpackage/controller/language_controller.dart';
import 'package:scanpackage/controller/shipping_count_controller.dart';
import 'package:scanpackage/controller/user_controller.dart';
import 'package:scanpackage/controller/timezone_controller.dart'; 
import 'package:scanpackage/contstants/app_strings.dart';
import 'package:scanpackage/contstants/shared_pref_manager.dart';
import 'package:scanpackage/extensions/app_translations.dart';
import 'package:scanpackage/screen/home/splash_screen.dart';

import 'package:toastification/toastification.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  );


  await SharedPrefManager.init();
  // Run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize LanguageController
    final LanguageController languageController = Get.put(LanguageController());
    Get.put(ConnectivityController(), permanent: true);

    return Obx(() {
      // Check if the language has been loaded
      if (!languageController.isLanguageLoaded.value) {
        return const MaterialApp(
          home: Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
        );
      }

      // Build the app after the language is loaded
      return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return ToastificationWrapper(
            child: GetMaterialApp(
              initialBinding: AppBinding(), // Updated naming convention
              translations: AppTranslations(),
              locale: languageController.initialLocale, // Use loaded locale
              fallbackLocale: const Locale('en', 'US'),
              debugShowCheckedModeBanner: false,
              title: AppStrings.appName,
              theme: ThemeData(
                primarySwatch: Colors.blue,
                textTheme: Theme.of(context).textTheme.apply(
                      fontFamily: 'Poppins',
                    ),
              ),
              home:  SplashScreen(),
            ),
          );
        },
      );
    });
  }
}

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BarcodeController());
    Get.put(UserController());
    Get.put(TimezoneController());
        Get.put(ShippingCountController());
    // Add other controllers as needed
  }
}
