import 'package:flutter/material.dart';
import 'package:ommeoWash/custom_theme/color_palette.dart';
import 'package:ommeoWash/custom_theme/custom_button.dart';
import 'package:ommeoWash/custom_theme/custom_widgets.dart';
import '../../helpers/indicator_value_list.dart';

class SelectCleaner extends StatefulWidget {
  const SelectCleaner({super.key});

  @override
  State<SelectCleaner> createState() => _SelectCleanerState();
}

class _SelectCleanerState extends State<SelectCleaner> {
  String selectedCleaner = '';

  final List<Map<String, String>> cleanersList = [
    // {
    //   "name": "Samuel JJ",
    //   "potential": "Hatchbacks",
    //   "image": "assets/images/samuel.png",
    //   "price": "₵40",
    // },
    {
      "name": "Prince D",
      "potential":
          "I'm a very good boy with 3 years of cleaning skills. I have helped so many people to clean their cars which happens to be the one of the greatest achievement in their lifes.",
      "image": "assets/images/sam.jpg",
      "price": "¢65",
    },
    {
      "name": "Kelvin",
      "potential": "Hatchbacks",
      "image": "assets/images/kelvin.jpg",
      "price": "¢45",
    },

    {
      "name": "Samuel",
      "potential": "Deep interior cleaning",
      "image": "assets/images/sam.jpg",
      "price": "¢55",
    },
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
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LnProgressIndicator(value: indicatorValues[5]),
              const SizedBox(height: 24),
              const Text(
                "Who would you like to clean your car?",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children:
                        cleanersList
                            .map(
                              (cleaner) => Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: CleanerTile(
                                  cleanerDetails: cleaner,
                                  isSelected:
                                      selectedCleaner.toLowerCase() ==
                                      cleaner["name"]!.toLowerCase(),
                                  onSelect: () {
                                    setState(() {
                                      selectedCleaner = cleaner["name"]!;
                                    });
                                  },
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              OmeeoButton(
                backgroundColor:
                    selectedCleaner.trim().isEmpty ? hintTextColor : lightGreen,
                text: "Continue",
                onPressed: () {
                  if (selectedCleaner.isNotEmpty) {
                    // Example:
                    // context.push('/next/route');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CleanerTile extends StatelessWidget {
  final Map<String, String> cleanerDetails;
  final bool isSelected;
  final VoidCallback onSelect;

  const CleanerTile({
    super.key,
    required this.cleanerDetails,
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
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              child: Image.asset(
                cleanerDetails['image']!,
                height: 90,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    cleanerDetails["name"]!,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: isSelected ? whiteText : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cleanerDetails["potential"]!,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color:
                          isSelected ? const Color(0xFFD5D2D2) : hintTextColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  if (cleanerDetails["price"] != null)
                    Text(
                      '• ${cleanerDetails["price"]}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(color: isSelected ? whiteText : null),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
