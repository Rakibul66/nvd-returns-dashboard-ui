import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanpackage/contstants/colors.dart';
import 'package:scanpackage/contstants/image_path.dart';
import 'package:scanpackage/network/api_service.dart';

void showForgetPasswordModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const ForgetPasswordDialog();
    },
  );
}

class ForgetPasswordDialog extends StatefulWidget {
  const ForgetPasswordDialog({super.key});

  @override
  State<ForgetPasswordDialog> createState() => _ForgetPasswordDialogState();
}

class _ForgetPasswordDialogState extends State<ForgetPasswordDialog> {
  bool isLoading = false;
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ApiService apiService = Get.put(ApiService());
  // validator
  String? emailValidator(String? value) {
    // Regular expression for validating email addresses
    const String emailPattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final RegExp emailRegExp = RegExp(emailPattern);

    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null; // Valid email
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      final email = emailController.text;

      // Make API call
      var response = await apiService.forgotPassword(email);


      // Check for a successful response
      if (response['status'] == 200) {
        // Show success message
        Get.snackbar(
          'Success',
          response['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Close the dialog after successful submission
        Navigator.of(context).pop();
      } else {
        // Generic error message
        Get.snackbar(
          'Error',
          'Email not found',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 16,
          ),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                ImagePaths.reset,
                width: 102,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Reset Password',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Enter your email for reset',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                validator: emailValidator,
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: lightGrey,
                  hintText: 'Write your email address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: lightGreyBorder,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                        color: Colors.blue), // Focused border color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                        color: lightGreyBorder,
                        width: 1), // Enabled border color
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: lightGreyBorder,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            )),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryRedColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            )),
                        onPressed: () {
                          _submitForm();
                        },
                        child: !isLoading
                            ? Text(
                                'Reset',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : const SizedBox(
                                width: 12,
                                height: 12,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
