import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimezoneController extends GetxController {
  var selectedTimezone = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadTimezone(); // Load timezone when the controller is initialized
  }

  // Load timezone from shared preferences
  Future<void> loadTimezone() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedTimezone = prefs.getString('timezone');

    if (savedTimezone == null || savedTimezone.isEmpty) {
      selectedTimezone.value = 'Asia/Dhaka'; // Default to 'Asia/Dhaka' if none is saved
      await prefs.setString('timezone', 'Asia/Dhaka'); // Save the default timezone
    } else {
      selectedTimezone.value = savedTimezone; // Use saved timezone
    }
  }

  // Save timezone to shared preferences
  Future<void> saveTimezone(String timezone) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('timezone', timezone);
    selectedTimezone.value = timezone; // Update the reactive variable
  }
}
