import 'package:flutter/material.dart';
import 'package:ommeowash/custom_theme/color_palette.dart';
import 'package:ommeowash/custom_theme/custom_button.dart';
import 'package:ommeowash/custom_theme/custom_widgets.dart';
import 'package:ommeowash/helpers/indicator_value_list.dart';

class OptionalExtrasScreen extends StatefulWidget {
  const OptionalExtrasScreen({super.key});

  @override
  State<OptionalExtrasScreen> createState() => _OptionalExtrasScreenState();
}

class _OptionalExtrasScreenState extends State<OptionalExtrasScreen> {
  String selectedExtrasTitle = '';
  Map<String, dynamic> selectedExtra = {};

  final List<Map<String, dynamic>> optionalExtras = [
    {"title": "Mini Valet", "priceRange": "₵40 - ₵75"},
    {"title": "Full Valet", "priceRange": "₵120 - ₵140"},
    {"title": "Exterior Valet", "priceRange": "₵40 - ₵50"},
    {"title": "Interior Deep Clean", "priceRange": "₵80 - ₵85"},
    {"title": "Soft Top Restoration", "priceRange": "₵85 - ₵90"},
    {"title": "Interior Valet", "priceRange": "₵30 - ₵60"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackground,
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: scaffoldBackground,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LnProgressIndicator(value: indicatorValues[3]),
              const SizedBox(height: 24),
              Text(
                "What optional extras do you need?",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: optionalExtras.length,
                  itemBuilder: (context, index) {
                    final extras = optionalExtras[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: OptionalExtrasTile(
                        title: extras['title'],
                        priceRange: extras['priceRange'],

                        isSelected: selectedExtrasTitle == extras['title'],
                        onSelect: () {
                          setState(() {
                            selectedExtrasTitle = extras['title'];
                            selectedExtra = extras;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              OmeeoButton(
                backgroundColor:
                    selectedExtrasTitle.isEmpty ? hintTextColor : lightGreen,
                text: "Continue",
                onPressed:
                    selectedExtrasTitle.isEmpty
                        ? null
                        : () {
                          // Handle next step
                        },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OptionalExtrasTile extends StatelessWidget {
  final String title;
  final String priceRange;

  final bool isSelected;
  final VoidCallback onSelect;

  const OptionalExtrasTile({
    super.key,
    required this.title,
    required this.priceRange,

    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? lightGreen : backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? whiteText : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    priceRange,
                    style: TextStyle(
                      color:
                          isSelected
                              ? const Color.fromARGB(255, 213, 210, 210)
                              : hintTextColor,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.help_outline, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
