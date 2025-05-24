import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../custom_theme/color_palette.dart';
import '../../custom_theme/custom_button.dart';
import '../../custom_theme/custom_widgets.dart';

class SingupScreen extends StatelessWidget {
  final String path;
  const SingupScreen({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 30),
                CustomTextField(label: 'First Name *', hintText: 'First Name'),
                const SizedBox(height: 20),
                CustomTextField(label: 'Last Name *', hintText: 'Last Name'),
                const SizedBox(height: 20),
                CustomTextField(
                  label: 'Email *',
                  hintText: 'Your email',
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: 'Password *',
                  hintText: 'Password',

                  obscureText: true,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: 'Confirm Password *',
                  hintText: 'Confirm Password',

                  obscureText: true,
                ),
                const SizedBox(height: 30),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "I’d like to receive marketing communications.",
                        style: TextStyle(color: darkText, fontSize: 14),
                      ),
                    ),
                    SizedBox(width: 8),
                    CheckCircle(),
                  ],
                ),

                const SizedBox(height: 30),
                OmeeoButton(
                  text: "Sign Up",
                  onPressed: () {
                    context.push(path);
                  },
                ),
                const SizedBox(height: 12),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: Colors.black),
                      children: [
                        const TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(color: darkText),
                        ),
                        TextSpan(
                          text: 'Log in',
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: darkText,
                            decorationThickness: 2,
                            color: darkText,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  // 👉 Put your navigation or action here
                                  // Example:
                                  context.push('/login');
                                },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: Colors.black),
                      children: [
                        const TextSpan(
                          text:
                              'By signing up you have read and are agreeable to our ',
                          style: TextStyle(color: darkText, fontSize: 13),
                        ),
                        TextSpan(
                          text: 'Terms of Service ',
                          style: const TextStyle(
                            fontSize: 13,
                            color: amber,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        TextSpan(
                          text: '& ',
                          style: const TextStyle(
                            fontSize: 13,
                            color: darkText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: const TextStyle(
                            fontSize: 13,
                            color: amber,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
