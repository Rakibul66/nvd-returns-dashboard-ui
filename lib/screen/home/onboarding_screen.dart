import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanpackage/controller/onboard_controller.dart';
import 'package:scanpackage/contstants/app_strings.dart';
import 'package:scanpackage/contstants/colors.dart';
import 'package:scanpackage/contstants/image_path.dart';
import 'package:scanpackage/screen/auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OnboardingController controller = Get.put(OnboardingController());

    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 60.h,  // Responsive padding
              left: 20.w,
              right: 20.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Animated Text for Welcome to
                AnimatedBuilder(
                  animation: controller.textAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(controller.textAnimation.value, 0),
                      child: Text(
                        AppStrings.splashTitle,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 40.sp,  // Responsive font size
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: 200.w,  // Responsive width
                  child: AnimatedBuilder(
                    animation: controller.textAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(controller.textAnimation.value, 0),
                        child: Text(
                          AppStrings.appName,
                          style: GoogleFonts.inter(
                            color: primaryRedColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,  // Responsive font size
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          AnimatedBuilder(
            animation: controller.imageAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(controller.imageAnimation.value, 0), // Only x-offset
                child: Image.asset(ImagePaths.splashFeature),
              );
            },
          ),
          Container(
            height: 170.h,  // Responsive height
            decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  image: AssetImage(
                    ImagePaths.splashvector,
                  )),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 25.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      _setOnboardingSeen();
                      Get.off(() => const LoginScreen());
                    },
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      width: 100.w,  // Responsive width
                      height: 90.h,  // Responsive height
                      decoration: BoxDecoration(
                        color: primaryRedColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(100),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3), // Shadow color with opacity
                            spreadRadius: 5, // How much the shadow spreads
                            blurRadius: 7, // How soft the shadow looks
                            offset: const Offset(0, 3), // Shadow position (x, y)
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.splashButtonText,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,  // Responsive font size
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Save onboarding seen status in shared preferences
  void _setOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('onboardingSeen', true); // Set the flag to true
  }
}
