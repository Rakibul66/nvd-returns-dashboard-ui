import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanpackage/controller/user_controller.dart';
import 'package:scanpackage/contstants/app_strings.dart';
import 'package:scanpackage/contstants/colors.dart';
import 'package:scanpackage/contstants/image_path.dart';
import 'package:scanpackage/contstants/shared_pref_manager.dart';
import 'package:scanpackage/data/merchants.dart';
import 'package:scanpackage/screen/auth/store_selection_screen.dart';
import 'package:scanpackage/screen/home/bottom_navigation_screen.dart';
import 'package:scanpackage/screen/store/store_selection_screen.dart';
import 'package:scanpackage/widget/auth/forget_password_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserController userController = Get.put(UserController());
  bool isLoading = false;

  // SharedPreferences key for storing email
  final String _emailKey = 'user_email';

  @override
  void initState() {
    super.initState();
    _loadSavedEmail(); // Load saved email when the screen is initialized
  }

  Future<void> _loadSavedEmail() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? savedEmail = prefs.getString(_emailKey);
      if (savedEmail != null) {
        setState(() {
          _emailController.text = savedEmail; // Pre-populate email field
        });
      }
    } catch (e) {
      print('Error loading saved email: $e');
    }
  }

  Future<void> _saveEmail(String email) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(_emailKey, email); // Save email locally
    } catch (e) {
      print('Error saving email: $e');
    }
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    String pattern = r'\w+@\w+\.\w+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

 

  Future<void> _submit() async {
  if (_formKey.currentState!.validate()) {
    setState(() {
      isLoading = true; // Set loading to true while the request is in progress
    });

    // Call the login function with email and password
    await userController.login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() {
      isLoading = false; // Reset loading state
    });

    // Check if the user is logged in
    if (userController.isLoggedIn.value) {
      // Save the email to SharedPreferences
      await _saveEmail(_emailController.text.trim());

   final store = await SharedPrefManager.getSelectedStore();
      if (store != null) {
Get.off(() =>  BottomNavScreen());
      } else {
Get.off(() =>  StoreSelectionScreen());
      }
    } else {
      // Handle login failure
      toastification.show(
        type: ToastificationType.error,
        title: const Text('Login failed. Please try again.'),
        autoCloseDuration: const Duration(seconds: 2),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    ImagePaths.returnLogo,
                    width: 170,
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: Image.asset(
                    ImagePaths.loginImage,
                    width: 200,
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  margin: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.signInSmall,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: AppStrings.email,
                          labelStyle: GoogleFonts.inter(
                              fontSize: 13, color: textLightColor),
                          filled: true,
                          fillColor: lightGrey,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: lightGreyBorder),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 1, color: lightBlue),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: primaryRedColor),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: primaryRedColor),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: _emailValidator,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: AppStrings.password,
                          labelStyle: GoogleFonts.inter(
                              fontSize: 13, color: textLightColor),
                          filled: true,
                          fillColor: lightGrey,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: lightGreyBorder),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 1, color: lightBlue),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: primaryRedColor),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: primaryRedColor),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        obscureText: true,
                        validator: _passwordValidator,
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            showForgetPasswordModal(context);
                          },
                          child: const Text(
                            AppStrings.forgotPass,
                            textAlign: TextAlign.end,
                            style: TextStyle(color: redColor),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : _submit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryRedColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : Text(
                                  AppStrings.signIn,
                                  style: const TextStyle(fontSize: 14),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
