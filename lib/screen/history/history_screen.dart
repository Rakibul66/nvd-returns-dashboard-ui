import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scanpackage/controller/barcode_controller.dart';
import 'package:intl/intl.dart';
import 'package:scanpackage/controller/history_controller.dart';
import 'package:scanpackage/controller/timezone_controller.dart';
import 'package:scanpackage/contstants/colors.dart';
import 'package:scanpackage/contstants/image_path.dart';
import 'package:scanpackage/screen/home/result_screen.dart';
import 'package:scanpackage/widget/custom_progressbar.dart';
import 'package:timezone/timezone.dart' as tz;
// Import Statements

class HistoryScreen extends StatelessWidget {
  final HistoryController controller = Get.put(HistoryController());
  final BarcodeController barcodeController = Get.find<BarcodeController>();
  final TimezoneController timezoneController = Get.find<TimezoneController>();
  final TextEditingController searchController = TextEditingController();
  DateTimeRange selectedDateRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

  HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'historyTitle'.tr,
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
              image: AssetImage(ImagePaths.statusBarGradient),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search and Filter Container
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Search Bar with Search Icon
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16.0),
                        prefixIcon: IconButton(
                          icon: const Icon(
                              Icons.search), // Search icon on the left side
                          onPressed: () {
                            // Update search query and fetch data
                            controller.searchQuery.value =
                                searchController.text.trim();
                            controller.fetchHistories(
                              searchQuery: controller.searchQuery.value,
                              fromDate: controller.fromDate.value,
                              toDate: controller.toDate.value,
                            );
                          },
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                              Icons.clear), // Clear icon on the right side
                          onPressed: () {
                            searchController.clear();
                            controller.searchQuery.value = '';
                            controller
                                .fetchHistories(); // Fetch all histories without filter
                          },
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10.0),

                // Square Filter Button
                Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: IconButton(
                    icon: SvgPicture.asset(
                      'assets/filter.svg', // Update the path to your SVG file
                      width: 24.0,
                      height: 24.0,
                      color: Colors
                          .black, // You can set the color if your SVG supports it
                    ),
                    onPressed: () async {
                      // Open date picker dialog to select date range
                      final DateTimeRange? picked = await showDateRangePicker(
                        context: context,
                        initialDateRange: selectedDateRange,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );

                      if (picked != null && picked != selectedDateRange) {
                        selectedDateRange =
                            picked; // Update selected date range
                        controller.fromDate.value = DateFormat('yyyy-MM-dd')
                            .format(selectedDateRange.start);
                        controller.toDate.value = DateFormat('yyyy-MM-dd')
                            .format(selectedDateRange.end);

                        // Fetch data with new date range
                        controller.fetchHistories(
                          searchQuery: controller.searchQuery.value,
                          fromDate: controller.fromDate.value,
                          toDate: controller.toDate.value,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),

          // Selected Date Range Display in a Card
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            elevation: 0, // You can adjust the elevation for the shadow effect
            child: Padding(
              padding:
                  const EdgeInsets.all(16.0), // Add padding inside the card
              child: Text(
                'Selected Date: ${DateFormat('yyyy-MM-dd').format(selectedDateRange.start)} - ${DateFormat('yyyy-MM-dd').format(selectedDateRange.end)}',
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
          ),
          SizedBox(height: 6.h,),

          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (controller.historyData.isEmpty) {
                return const Center(child: Text('No return histories found.'));
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: ListView.builder(
                    itemCount: controller.historyData.length,
                    itemBuilder: (context, index) {
                      final history = controller.historyData[index];

                      String selectedTimezone =
                          timezoneController.selectedTimezone.value;
                      tz.Location location = tz.getLocation(selectedTimezone);
                      DateTime? localDateTime = history.createdAt != null
                          ? tz.TZDateTime.from(history.createdAt!, location)
                          : null;

                      String formattedDate = localDateTime != null
                          ? DateFormat('dd MMM yyyy').format(localDateTime)
                          : 'N/A';
                      String formattedTime = localDateTime != null
                          ? DateFormat('hh:mm a').format(localDateTime)
                          : 'N/A';

                      String userName = history.user != null
                          ? '${history.user?.firstName ?? 'Unknown'} ${history.user?.lastName ?? 'User'}'
                          : 'Unknown User';

                      String rmaNumber = history.nvdReturn?.rmaNumber ?? 'N/A';

                      return GestureDetector(
                        onTap: () {
                         Get.to(
                      () => const ResultScreen(),
                      transition:
                          Transition.rightToLeft, // Add transition animation
                      duration: const Duration(
                          milliseconds:
                              300), // Optional: set duration for the animation
                    );
                       barcodeController.submitRMA(rmaNumber);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 6.h),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            color: Colors.white,
                            elevation: 0,
                            child: Padding(
                              padding: EdgeInsets.all(16.w),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            userName,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: 6.h),
                                          Text(
                                            rmaNumber,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            formattedDate,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: 6.h),
                                          Text(
                                            formattedTime,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
