import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ommeoWash/custom_theme/color_palette.dart';
import 'package:ommeoWash/custom_theme/custom_button.dart';
import 'package:ommeoWash/custom_theme/custom_widgets.dart';
import '../../helpers/indicator_value_list.dart';

class SelectCleaner extends StatefulWidget {
  final String path;
  const SelectCleaner({super.key, required this.path});

  @override
  State<SelectCleaner> createState() => _SelectCleanerState();
}

class _SelectCleanerState extends State<SelectCleaner> {
  String selectedCleaner = '';

  final List<Map<String, dynamic>> cleanersList = [
    {
      "name": "Any washer (recommended)",
      "potential":
          "We will automatically select for you our best mobile car cleaner in your area.",
      "image": "assets/images/recommend.png",
      "price": null,
    },
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
                                  recommend:
                                      cleaner["price"] == null ? true : false,
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
                    selectedCleaner.trim().isEmpty
                        ? hintTextColor
                        : lightPurple,
                text: "Continue",
                onPressed:
                    selectedCleaner.trim().isEmpty
                        ? null
                        : () {
                          if (selectedCleaner.isNotEmpty) {
                            context.push(widget.path);
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
  final bool recommend;
  final Map<String, dynamic> cleanerDetails;
  final bool isSelected;
  final VoidCallback onSelect;

  const CleanerTile({
    super.key,
    required this.cleanerDetails,
    required this.isSelected,
    required this.onSelect,
    this.recommend = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? lightPurple : backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // height: 70,
              // width: 70,
              decoration: BoxDecoration(
                color: isSelected ? lightPurple : scaffoldBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Image.asset(
                  cleanerDetails['image']!,
                  height: 90,
                  width: 110,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    cleanerDetails["name"]!,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: isSelected ? whiteText : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cleanerDetails["potential"]!,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color:
                          isSelected
                              ? const Color.fromARGB(255, 233, 229, 229)
                              : hintTextColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                  ),
                  if (cleanerDetails["price"] != null)
                    Text(
                      '• ${cleanerDetails["price"]}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: isSelected ? whiteText : null,
                        fontWeight: FontWeight.w700,
                      ),
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
