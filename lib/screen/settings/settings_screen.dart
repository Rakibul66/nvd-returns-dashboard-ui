import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scanpackage/controller/language_controller.dart';
// Import the new controller
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scanpackage/controller/timezone_controller.dart';
import 'package:scanpackage/screen/timezone/timezone_screen.dart';

class SettingsScreen extends StatelessWidget {
  final LanguageController languageController = Get.find<LanguageController>();
  final TimezoneController timezoneController = Get.find<TimezoneController>(); // Instance of TimezoneController

  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double cardHeight = 40.h; // Define consistent card height here

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'settingsTitle'.tr,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/status-bar-gradient.png'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.all(8.0.w),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6),
                topRight: Radius.circular(6),
                bottomLeft: Radius.circular(6),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Image.asset(
                'assets/arrow_back.png',
                width: 24.w,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'selectLanguage'.tr,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Obx(() {
              return SizedBox(
                height: cardHeight, // Set card height
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      value: languageController.langCode.value,
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Colors.transparent,
                      ),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          languageController.changeLanguage(newValue);
                        }
                      },
                      items: const [
                        DropdownMenuItem(
                          value: 'en',
                          child: Text('English'),
                        ),
                        DropdownMenuItem(
                          value: 'es',
                          child: Text('Español'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),
            Text(
              'selectTimezone'.tr,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Obx(() {
              return SizedBox(
                height: cardHeight, // Set the same card height
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => TimezoneScreen())?.then((selected) {
                      if (selected != null) {
                        timezoneController.saveTimezone(selected); // Save selected timezone
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          timezoneController.selectedTimezone.value.isEmpty
                              ? 'Select a timezone'
                              : timezoneController.selectedTimezone.value,
                          style: const TextStyle(color: Colors.black),
                        ),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
