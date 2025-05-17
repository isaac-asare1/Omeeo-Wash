import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ommeowash/custom_theme/color_palette.dart';
import 'package:ommeowash/custom_theme/custom_button.dart';
import 'package:ommeowash/custom_theme/custom_widgets.dart';
import 'package:ommeowash/helpers/indicator_value_list.dart';

class SelectServiceScreen extends StatefulWidget {
  const SelectServiceScreen({super.key});

  @override
  State<SelectServiceScreen> createState() => _SelectServiceScreenState();
}

class _SelectServiceScreenState extends State<SelectServiceScreen> {
  String selectedService = '';

  final List<Map<String, dynamic>> valetServices = [
    {
      "title": "Mini Valet",
      "priceRange": "₵40 - ₵75",
      "icon": FontAwesomeIcons.carSide,
    },
    {
      "title": "Full Valet",
      "priceRange": "₵120 - ₵140",
      "icon": FontAwesomeIcons.sprayCanSparkles,
    },
    {
      "title": "Exterior Valet",
      "priceRange": "₵40 - ₵50",
      "icon": FontAwesomeIcons.car,
    },
    {
      "title": "Interior Deep Clean",
      "priceRange": "₵80 - ₵85",
      "icon": FontAwesomeIcons.broom,
    },
    {
      "title": "Soft Top Restoration",
      "priceRange": "₵85 - ₵90",
      "icon": FontAwesomeIcons.car,
    },
    {
      "title": "Interior Valet",
      "priceRange": "₵30 - ₵60",
      "icon": FontAwesomeIcons.carSide,
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
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LnProgressIndicator(value: indicatorValues[2]),
              const SizedBox(height: 24),
              Text(
                "What service do you need?",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: valetServices.length,
                  itemBuilder: (context, index) {
                    final service = valetServices[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ValetServiceTile(
                        title: service['title'],
                        priceRange: service['priceRange'],
                        iconData: service['icon'],
                        isSelected: selectedService == service['title'],
                        onSelect: () {
                          setState(() {
                            selectedService = service['title'];
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              OmeeoButton(
                backgroundColor:
                    selectedService.isEmpty ? hintTextColor : lightGreen,
                text: "Continue",
                onPressed:
                    selectedService.isEmpty
                        ? null
                        : () {
                          context.push(
                            '/set_location/set_vehicle_reg/service_type/extras',
                          );
                        },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ValetServiceTile extends StatelessWidget {
  final String title;
  final String priceRange;
  final IconData iconData;
  final bool isSelected;
  final VoidCallback onSelect;

  const ValetServiceTile({
    super.key,
    required this.title,
    required this.priceRange,
    required this.iconData,
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
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: scaffoldBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(iconData, size: 32),
            ),
            const SizedBox(width: 16),
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
