import 'package:flutter/material.dart';
import 'package:ommeoWash/custom_theme/custom_button.dart';
import 'package:ommeoWash/custom_theme/custom_widgets.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Reset Password",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 30),
                const CustomTextField(
                  label: 'Email *',
                  hintText: 'Your email',
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                OmeeoButton(
                  text: 'Send Reset Link',
                  onPressed: () {
                    // Handle password reset logic
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
