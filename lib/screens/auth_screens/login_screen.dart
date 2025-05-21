import 'package:flutter/material.dart';

import '../../custom_theme/color_palette.dart';
import '../../custom_theme/custom_button.dart';
import '../../custom_theme/custom_widgets.dart';

// Assume your OmeeoButton and ColorPalette exist
// import 'your_custom_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      // Handle forgot password
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: amber,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                OmeeoButton(
                  text: "Log In",
                  onPressed: () {
                    //                   Future<void> loginUser(String email, String password) async {
                    //   final url = Uri.parse('http://localhost:3000/login'); // Change to your IP on device

                    //   final response = await http.post(
                    //     url,
                    //     headers: {'Content-Type': 'application/json'},
                    //     body: jsonEncode({'email': email, 'password': password}),
                    //   );

                    //   if (response.statusCode == 200) {
                    //     final data = jsonDecode(response.body);
                    //     final token = data['token'];
                    //     print('JWT Token: $token');

                    //     // TODO: Store token securely (e.g., with flutter_secure_storage)
                    //   } else {
                    //     print('Login failed: ${response.body}');
                    //   }
                    // }
                  },
                ),
                const SizedBox(height: 12),
                OmeeoButton(
                  allowBorder: true,
                  backgroundColor: backgroundColor,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/google_logo.png',
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(width: 10),
                      CustomText(
                        'Sign in with google',
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  onPressed: () {
                    // context.push('/');
                  },
                ),
                const SizedBox(height: 12),
                OmeeoButton(
                  allowBorder: true,
                  backgroundColor: backgroundColor,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/apple_logo.png',
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(width: 10),
                      CustomText(
                        'Sign in with apple',
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  onPressed: () {
                    //context.push('/');
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
