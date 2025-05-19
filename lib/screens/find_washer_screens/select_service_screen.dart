import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ommeoWash/custom_theme/color_palette.dart';
import 'package:ommeoWash/custom_theme/custom_button.dart';
import 'package:ommeoWash/custom_theme/custom_widgets.dart';
import 'package:ommeoWash/helpers/indicator_value_list.dart';
import 'package:ommeoWash/helpers/service_list.dart';

class SelectServiceScreen extends StatefulWidget {
  const SelectServiceScreen({super.key});

  @override
  State<SelectServiceScreen> createState() => _SelectServiceScreenState();
}

class _SelectServiceScreenState extends State<SelectServiceScreen> {
  String selectedService = '';

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
                  itemCount: detailingServices.length,
                  itemBuilder: (context, index) {
                    final service = detailingServices[index];
                    final priceRange =
                        "¢${service['minPrice']} - ¢${service['maxPrice']}";
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Column(
                        children: [
                          ValetServiceTile(
                            title: service['title'],
                            priceRange: priceRange,
                            imagePath: service['image'],
                            isSelected: selectedService == service['title'],
                            onSelect: () {
                              setState(() {
                                selectedService = service['title'];
                              });
                            },
                            context: context,
                            description: service['description'],
                          ),
                          SizedBox(
                            height:
                                index + 1 == detailingServices.length ? 50 : 0,
                          ),
                        ],
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
  final Map<String, dynamic> description;
  final BuildContext context;
  final String title;
  final String priceRange;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onSelect;

  const ValetServiceTile({
    super.key,
    required this.title,
    required this.priceRange,
    required this.imagePath,
    required this.isSelected,
    required this.onSelect,
    required this.context,
    required this.description,
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
              // child: Icon(iconData, size: 32),
              child: Image.asset(imagePath, height: 70, width: 70),
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
            GestureDetector(
              onTap: () {
                showServiceDeatals(context, title, description);
              },
              child: Icon(
                Icons.help_outline,
                color: isSelected ? whiteText : hintTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showServiceDeatals(
  context,
  String title,
  Map<String, dynamic> description,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(description["desTitle"], style: TextStyle(fontSize: 14)),
              const SizedBox(height: 10),
              BulletList(items: description["description"]),
            ],
          ),
        ),
      );
    },
  );
}

class BulletList extends StatelessWidget {
  final List<String> items;

  const BulletList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          items.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("• ", style: TextStyle(fontSize: 14)),
                  Expanded(
                    child: Text(item, style: const TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }
}
