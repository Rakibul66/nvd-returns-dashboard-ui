import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityController extends GetxController {
  final RxString connectionStatus = ''.obs;
  final Connectivity connectivity = Connectivity();

  @override
  void onInit() {
    connectivity.onConnectivityChanged.listen(updateConnectionStatus);
    super.onInit();
  }


  void updateConnectionStatus(List<ConnectivityResult> connectiivtyResultList) {
    if (connectiivtyResultList.contains(ConnectivityResult.none)) {
      connectionStatus.value = "Offline";
    } else {
      connectionStatus.value = "Online";
    }
  }
}
