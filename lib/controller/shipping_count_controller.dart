import 'package:get/get.dart';
import 'package:scanpackage/data/shipping_status.dart';
import 'package:scanpackage/network/api_service.dart';

class ShippingCountController extends GetxController {
  var shippingStatuses = <ShippingStatus>[].obs;
  var isLoading = false.obs;
  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchShippingData();  // This should stay after super.onInit()
  }

  Future<void> fetchShippingData() async {
    try {
      isLoading(true);
      var shippingData = await _apiService.fetchShippingCount();
      if (shippingData.isNotEmpty) {
        shippingStatuses.value = shippingData;
      } else {
        Get.snackbar("Info", "No shipping data found.");
      }
    } catch (e) {
      Get.snackbar("Error", "Error fetching shipping data: $e");
      print("Error fetching shipping data: $e");
    } finally {
      isLoading(false);
    }
  }
}
