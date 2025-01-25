import 'package:get/get.dart';
import 'package:scanpackage/contstants/shared_pref_manager.dart';
import 'package:scanpackage/data/auth_token.dart';
import 'package:scanpackage/network/api_service.dart';


class UserController extends GetxController {
  final ApiService authService = ApiService();
  var authToken = Rx<AuthToken?>(null);
  var isLoading = false.obs;
  var isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserSession(); // Load user session when initializing
  }

  bool get isUserLoggedIn => authToken.value != null;

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      authToken.value = await authService.login(email, password);
      if (authToken.value != null) {
        isLoggedIn.value = true;
    await SharedPrefManager.saveAuthToken(authToken.value!); // Save the entire AuthToken object
        print('Login successful! Access Token: ${authToken.value!.accessToken}');
      } else {
        isLoggedIn.value = false;
        print('Login failed!');
      }
    } catch (e) {
      print("Login error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void logout() async {
    authToken.value = null;
    isLoggedIn.value = false;
    await SharedPrefManager.clearToken(); // Clear the token on logout
    print('User logged out.');
  }

void loadUserSession() {
  final authTokenData = SharedPrefManager.getAuthToken(); // Retrieve the entire AuthToken object
  if (authTokenData != null) {
    authToken.value = authTokenData; // Set the retrieved AuthToken
    isLoggedIn.value = true; // Mark the user as logged in
    print('User session loaded. Access Token: ${authToken.value!.accessToken}');
  }
}

}
