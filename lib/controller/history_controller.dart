import 'package:get/get.dart';
import 'package:scanpackage/data/return_history.dart';
import 'package:scanpackage/network/api_service.dart';

class HistoryController extends GetxController {
  var isLoading = true.obs;
  var historyData = <ReturnHistory>[].obs;
  var totalHistories = 0.obs;
  var searchQuery = ''.obs;
  var fromDate = ''.obs; // Add fromDate
  var toDate = ''.obs; // Add toDate

  ApiService apiService = Get.find<ApiService>();

  @override
  void onInit() {
    super.onInit();
    fetchHistories(); // Initial fetch without filters
  }

// Fetch return histories with optional parameters for filtering
Future<void> fetchHistories({String? searchQuery, String? fromDate, String? toDate}) async {
  try {
    isLoading(true);

    // Make API call with filters
    HistoryResponse? response = await apiService.fetchReturnHistories(
      searchQuery: searchQuery ?? this.searchQuery.value, // Use stored value if null
      fromDate: fromDate ?? this.fromDate.value, // Use stored value if null
      toDate: toDate ?? this.toDate.value, // Use stored value if null
    );

    if (response != null && response.status == 200) {
      historyData.value = response.histories!.data!;
      totalHistories.value = response.histories!.total!;
    } else {
      // Handle error response here
      print("Error fetching histories: ${response?.message}");
    }
  } catch (e) {
    print("An error occurred: $e"); // Add error handling
  } finally {
    isLoading(false);
  }
}

}
