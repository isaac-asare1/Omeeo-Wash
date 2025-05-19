import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ommeoWash/custom_theme/color_palette.dart';
import 'package:ommeoWash/custom_theme/custom_button.dart';
import 'package:ommeoWash/custom_theme/custom_widgets.dart';
import 'package:ommeoWash/helpers/indicator_value_list.dart';

class OptionalExtrasScreen extends StatefulWidget {
  final String path;
  const OptionalExtrasScreen({super.key, required this.path});

  @override
  State<OptionalExtrasScreen> createState() => _OptionalExtrasScreenState();
}

class _OptionalExtrasScreenState extends State<OptionalExtrasScreen> {
  String selectedExtrasTitle = '';
  Map<String, dynamic> selectedExtra = {};

  final List<Map<String, dynamic>> optionalExtras = [
    {"title": "Pet hair removal", "priceRange": "¢40 - 1hr"},
    {"title": "Interior stain removal", "priceRange": "¢40 - 1hr"},
    {"title": "Seats shampoo", "priceRange": "¢30 - 1hr"},
    {"title": "Floor mats and carpet shampoo", "priceRange": "¢30 - 1hr"},
    {"title": "Clay bar treatment", "priceRange": "¢30 - 1hr"},
    {"title": "Iron and tar decontamination", "priceRange": "¢30 - 1hr"},
  ];

  late String routePath;

  @override
  void initState() {
    super.initState();
    routePath =
        widget.path.contains('vehicle_size')
            ? "/set_location/set_vehicle_reg/vehicle_size/service_type/extras/date"
            : "/set_location/set_vehicle_reg/service_type/extras/date";
  }

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
                      child: Column(
                        children: [
                          OptionalExtrasTile(
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
                          SizedBox(
                            height: index + 1 == optionalExtras.length ? 50 : 0,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Column(
                children: [
                  OmeeoButton(
                    backgroundColor:
                        selectedExtrasTitle.isEmpty
                            ? hintTextColor
                            : lightGreen,
                    text: "Continue",
                    onPressed:
                        selectedExtrasTitle.isEmpty
                            ? null
                            : () {
                              context.push(routePath);
                            },
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      // context.push('location');
                      context.push(routePath);
                    },
                    child: CustomText('Skip', fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10),
                ],
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
            Icon(
              Icons.help_outline,
              color: isSelected ? whiteText : hintTextColor,
            ),
          ],
        ),
      ),
    );
  }
}
