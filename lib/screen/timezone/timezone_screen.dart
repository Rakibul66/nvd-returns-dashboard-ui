import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scanpackage/controller/timezone_controller.dart';
import 'package:scanpackage/contstants/colors.dart';

class TimezoneScreen extends StatefulWidget {
  const TimezoneScreen({super.key});

  @override
  TimezoneScreenState createState() => TimezoneScreenState();
}

class TimezoneScreenState extends State<TimezoneScreen> {
    final TimezoneController timezoneController = Get.find<TimezoneController>(); // Get the instance of the controller
  List<String> timezones = [
    'Asia/Dhaka',
    'America/New_York',
    'America/Los_Angeles',
    'Europe/London',
    'Europe/Berlin',
    'Australia/Sydney',
    'Asia/Tokyo',
    'Asia/Kolkata',
    // Add more timezones as needed
  ];

  List<String> filteredTimezones = [];
  String? selectedTimezone;

  @override
  void initState() {
    super.initState();
     filteredTimezones = timezones; // Initialize filtered timezones
  }

  void _filterTimezones(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredTimezones = timezones; // Reset to all timezones
      });
    } else {
      setState(() {
        filteredTimezones = timezones
            .where((timezone) => timezone.toLowerCase().contains(query.toLowerCase()))
            .toList(); // Filter timezones based on query
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Timezone',
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
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Search timezone',
                border: OutlineInputBorder(),
              ),
              onChanged: _filterTimezones, // Call filter method on text change
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTimezones.length,
                itemBuilder: (context, index) {
                  final timezone = filteredTimezones[index];
                  return ListTile(
                    title: Text(timezone),
                    tileColor: selectedTimezone == timezone ? Colors.blue[100] : null, // Highlight selected timezone
                    onTap: () {
                      timezoneController.saveTimezone(timezone); // Save selected timezone
                      Navigator.pop(context, timezone); // Pass selected timezone back
                    },
                    selected: timezone == timezoneController.selectedTimezone.value, // Highlight the selected timezone
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
