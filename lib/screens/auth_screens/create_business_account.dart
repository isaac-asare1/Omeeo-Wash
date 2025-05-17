import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ommeowash/custom_theme/color_palette.dart';

import '../../custom_theme/custom_button.dart';
import '../../custom_theme/custom_widgets.dart';

class CreateBusinessAccountScreen extends StatelessWidget {
  const CreateBusinessAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Create Account",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30),

            const CustomTextField(
              label: "First Name *",
              hintText: "First Name",
            ),
            const SizedBox(height: 20),

            const CustomTextField(label: "Last Name *", hintText: "Last Name"),
            const SizedBox(height: 20),

            const CustomTextField(
              label: "Mobile Number *",
              hintText: "Mobile Number",
              textInputType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            const CustomTextField(
              label: "Email *",
              hintText: "Your email",
              textInputType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            const CustomTextField(
              label: "Password *",
              hintText: "Password",
              obscureText: true,
            ),
            const SizedBox(height: 8),
            const Text(
              "Must have minimum 8 characters, 1 capital letter, 1 digit and 1 special character.",
              style: TextStyle(color: hintTextColor, fontSize: 12),
            ),
            const SizedBox(height: 12),

            const CustomTextField(
              label: "Confirm Password *",
              hintText: "Password",
              obscureText: true,
            ),
            const SizedBox(height: 20),

            const CustomTextField(
              label: "Trading Name *",
              hintText: "Trading Name",
            ),
            const SizedBox(height: 20),

            const CustomTextField(
              label: "Website Address",
              hintText: "Website Address",
            ),
            const SizedBox(height: 20),

            // Dropdowns
            const CustomDropdown(
              label: "How long have you been operating for? *",
              dropdownItemsList: [
                'Please select',
                'Less than 1 year',
                '1 year',
                '2 years',
                '3 years',
                '4 years',
                '5 years or more',
              ],
            ),
            const SizedBox(height: 20),

            const CustomDropdown(
              label: "What vehicle do you travel in to deliver your jobs? *",
              dropdownItemsList: ['Please select', 'Van', 'Car', 'Bike'],
            ),
            const SizedBox(height: 20),

            const CustomTextField(
              label: "How many operators does your business have? *",
              hintText: "Number of Operators",
            ),
            const SizedBox(height: 20),

            // Yes/No Buttons
            const CustomToggleQuestion(
              question: "Do you have business insurance? *",
            ),
            const SizedBox(height: 20),
            const CustomToggleQuestion(
              question:
                  "Do you agree to keep all customers you gain from OmeeoWash on the OmeeoWash app? *",
            ),
            const SizedBox(height: 20),
            const CustomToggleQuestion(
              question:
                  "It is your responsibility to keep your calendars availability up to date. Do you accept this responsibility? *",
            ),
            const SizedBox(height: 20),
            const CustomToggleQuestion(
              question:
                  "Do you agree to not share or promote your personal contact details to customers on OmeeoWash? *",
            ),
            const SizedBox(height: 10),
            const Text(
              "It is against our terms of service to share or promote your personal contact details on OmeeoWash.",
              style: TextStyle(color: hintTextColor, fontSize: 13),
            ),
            const SizedBox(height: 20),

            const Row(
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

            OmeeoButton(text: "Sign Up", onPressed: () {}),
            const SizedBox(height: 20),

            Center(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: hintTextColor, fontSize: 14),
                  children: [
                    const TextSpan(text: "Already have an account? "),
                    TextSpan(
                      text: "Log In",
                      style: const TextStyle(
                        color: ColorPalette.amber,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              context.push('/login');
                            },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class CheckCircle extends StatefulWidget {
  const CheckCircle({super.key});

  @override
  State<CheckCircle> createState() => _CheckCircleState();
}

class _CheckCircleState extends State<CheckCircle> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: Container(
        width: 25,
        height: 25,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 204, 202, 202),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            weight: 1000,
            FontAwesomeIcons.check,
            color: isChecked ? lightGreen : Colors.white,
            size: 22,
          ),
        ),
      ),
    );
  }
}
