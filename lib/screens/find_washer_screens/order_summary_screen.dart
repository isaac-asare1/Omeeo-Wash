import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ommeoWash/custom_theme/color_palette.dart';
import 'package:ommeoWash/custom_theme/custom_button.dart';
import 'package:ommeoWash/custom_theme/custom_widgets.dart';
import 'dart:io' show Platform;

class OrderSummaryScreen extends StatefulWidget {
  final String path;
  const OrderSummaryScreen({super.key, required this.path});

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  String label(String base) => '$base*';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: CustomAppBar(
        displayLogo: false,
        title: "Order Summary",
        titleStyle: TextStyle(
          fontSize: 18,
          color: whiteText,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 500),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: lightGreen,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BenefitRow(text: 'Vetted operators'),
                      BenefitRow(text: 'Rated excellent on Trustpilot'),
                      BenefitRow(text: 'Relax while your car is cleaned'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                SectionHeader(title: label('Date & Time')),
                SummaryTile(
                  title: "Saturday 31st May 2025",
                  subtitle: "02:00 PM",
                  icon: Icons.edit_calendar_outlined,
                ),

                SectionHeader(title: label("Location for Wash")),
                SummaryTile(title: "Oxford OX1 1PE, UK"),

                SectionHeader(title: "Vehicle"),
                SummaryTile(
                  title: "Audi Q4 E-tron Sport 40 - 5CAM",
                  subtitle: "Blue",
                ),

                SectionHeader(title: "Subscribe"),
                const CustomDropdown(
                  bgColor: backgroundColor,
                  allowBorder: false,
                  label: null,
                  dropdownItemsList: [
                    'Select frequency',
                    '50 HZ',
                    '60HZ',
                    '70 HZ',
                  ],
                ),

                //SummaryTile(title: "Select frequency"),
                SectionHeader(title: "Services"),
                SummaryTile(title: "Mini Valet", subtitle: "¢40 · 2hr"),

                SectionHeader(title: "Optional Extras"),
                SummaryTile(title: "Pet hair removal", subtitle: "¢40 · 1hr"),

                SectionHeader(title: "Washer"),
                SummaryTile(
                  title: "James D.",
                  subtitle:
                      "💦 Water Not Provided    🔌 Electricity Not Provided",
                ),

                const SizedBox(height: 24),

                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: backgroundColor,
                  ),
                  child: Column(
                    children: [
                      CostSummaryRow(label: "Subtotal", value: "¢40"),
                      CostSummaryRow(label: "Optional Extras", value: "¢40"),
                      CostSummaryRow(label: "Service Charge", value: "¢1.50"),
                      const Divider(),
                      CostSummaryRow(
                        label: "Total",
                        value: "¢81.50",
                        isBold: true,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                OmeeoButton(
                  text: "Continue",
                  onPressed: () {
                    submitOrder(widget.path);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submitOrder(String routePath) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => Container(
            height: 410,
            child: Padding(
              padding: EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText('Continue with OmeeoWash', fontSize: 18),
                  SizedBox(height: 10),
                  CustomText(
                    'By having an OmmeoWash account you can book our washers, chat with them, save multiple vehicles and much more!',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 30),
                  OmeeoButton(
                    text: "Sign Up",
                    onPressed: () {
                      context.push(routePath);
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
                          'Sign up with google',
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    onPressed: () {
                      // context.push('/');
                    },
                  ),

                  // if (Platform == Platform.isIOS)
                  //   OmeeoButton(
                  //     allowBorder: true,
                  //     backgroundColor: backgroundColor,
                  //     child: Row(
                  //       children: [
                  //         Image.asset(
                  //           'assets/images/apple_logo.png',
                  //           width: 40,
                  //           height: 40,
                  //         ),
                  //         SizedBox(width: 10),
                  //         CustomText(
                  //           'Sign in with apple',
                  //           fontWeight: FontWeight.w600,
                  //         ),
                  //       ],
                  //     ),
                  //     onPressed: () {
                  //       //context.push('/');
                  //     },
                  //   ),
                  SizedBox(height: 20),
                  RichText(
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
                                  Navigator.of(context).pop();
                                  context.push('/login');
                                },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
    );
  }
}
