import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ommeoWash/custom_theme/color_palette.dart';
import 'package:ommeoWash/custom_theme/custom_button.dart';
import 'package:ommeoWash/custom_theme/custom_widgets.dart';
import 'package:ommeoWash/helpers/dummy_list.dart';
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
                  itemCount: optionalExtraServices.length,
                  itemBuilder: (context, index) {
                    final extras = optionalExtraServices[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Column(
                        children: [
                          OptionalExtrasTile(
                            title: extras['title'],
                            priceRange: extras['priceRange'],
                            description: extras['description'],
                            isSelected: selectedExtrasTitle == extras['title'],
                            onSelect: () {
                              setState(() {
                                selectedExtrasTitle = extras['title'];
                                selectedExtra = extras;
                              });
                            },
                          ),
                          SizedBox(
                            height:
                                index + 1 == optionalExtraServices.length
                                    ? 50
                                    : 0,
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
  final String description;
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
                showExtraOptionsDeatals(context, title, description);
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

void showExtraOptionsDeatals(context, String title, String description) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          constraints: BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(description, style: TextStyle(fontSize: 14)),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    },
  );
}
