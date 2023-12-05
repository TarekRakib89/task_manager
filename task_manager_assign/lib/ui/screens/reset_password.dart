// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:task_manager_assign/data/network_caller/network_caller.dart';
import 'package:task_manager_assign/data/network_caller/network_response.dart';
import 'package:task_manager_assign/data/utility/urls.dart';
import 'package:task_manager_assign/ui/screens/LoginScreen.dart';
import 'package:task_manager_assign/ui/widgets/body_background.dart';
import 'package:task_manager_assign/ui/widgets/snack_message.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({
    Key? key,
    required this.email,
    required this.pinCode,
  }) : super(key: key);
  final String email;
  final String pinCode;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController passworTextEditingController = TextEditingController();
  TextEditingController confirmTextEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    passworTextEditingController.dispose();
    confirmTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Text(
                      'Set Password',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'Minimum password length should be more than 8 letters',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: passworTextEditingController,
                      decoration: const InputDecoration(
                        hintText: 'New Password',
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter New Password';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: confirmTextEditingController,
                      decoration: const InputDecoration(
                        hintText: 'Confirm Password',
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter Confirm Password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (passworTextEditingController.text ==
                                confirmTextEditingController.text) {
                              _sendPinToServer(widget.email, widget.pinCode);
                            } else {
                              showSnackMessage(
                                  context, "Password doesn't match");
                            }
                          }
                        },
                        child: const Text('Confirm'),
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Have an Account?",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black45),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()),
                                  (route) => false);
                            },
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _sendPinToServer(
    String email,
    String pinCode,
  ) async {
    NetworkResponse response =
        await NetworkCaller().postRequestForRecoverVerifyOTP(
      Urls.resetPassword,
      body: {
        "email": email,
        "OTP": pinCode,
        "password": passworTextEditingController.text
      },
    );
    if (response.jsonResponse["status"] == "success") {
      if (mounted) {
        showSnackMessage(context, "Password has been changed");
      }
    }
    passworTextEditingController.clear();
    confirmTextEditingController.clear();
  }
}
