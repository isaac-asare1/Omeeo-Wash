import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../custom_theme/color_palette.dart';
import '../../custom_theme/custom_button.dart';
import '../../custom_theme/custom_widgets.dart';

// Assume your OmeeoButton and ColorPalette exist
// import 'your_custom_widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Log In",
                  style: TextStyle(
                    fontSize: 28,
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
                const CustomTextField(
                  label: 'Password *',
                  hintText: 'Your password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Handle forgot password
                  },
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(color: amber, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 30),
                OmeeoButton(text: "Log In", onPressed: () {}),
                const SizedBox(height: 12),
                OmeeoButton(
                  text: "Create Account",
                  onPressed: () {
                    context.push('/create_account');
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  "Don’t have an account? Create your account today.",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
