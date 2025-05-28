import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ommeoWash/custom_theme/color_palette.dart';
import 'package:ommeoWash/custom_theme/custom_button.dart';
import 'package:ommeoWash/custom_theme/custom_widgets.dart';

import '../../helpers/indicator_value_list.dart';

class SelectVehicleSizeScreen extends StatefulWidget {
  const SelectVehicleSizeScreen({super.key});

  @override
  State<SelectVehicleSizeScreen> createState() =>
      _SelectVehicleSizeScreenState();
}

class _SelectVehicleSizeScreenState extends State<SelectVehicleSizeScreen> {
  String selectedSize = ''; // Moved selection here

  final List<Map<String, String>> vehicleSizes = [
    {
      "size": "Small",
      "type": "Hatchbacks",
      "brand": "Mercedes A Class, VW Polo & Porsche Boxster",
    },
    {
      "size": "Medium",
      "type": "Saloons, Coupes & Compact SUVs",
      "brand": "Tesla Model 3, Mercedes E Class & Range Rover Evoque",
    },
    {
      "size": "Large",
      "type": "Vans, Pick-up, Trucks & Large SUVs",
      "brand": "Ford Transit, Ford Ranger & Range Rover Discovery",
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
              // Fixed progress indicator
              LnProgressIndicator(value: indicatorValues[1]),
              const SizedBox(height: 24),

              // Scrollable list
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children:
                        vehicleSizes
                            .map(
                              (vehicle) => Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: VehicleSizeTile(
                                  vehicleDetails: vehicle,
                                  isSelected:
                                      selectedSize.toLowerCase() ==
                                      vehicle["size"]!.toLowerCase(),
                                  onSelect: () {
                                    setState(() {
                                      selectedSize = vehicle["size"]!;
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

              // Fixed continue button
              OmeeoButton(
                backgroundColor:
                    selectedSize.trim().isEmpty ? hintTextColor : lightPurple,
                text: "Continue",
                onPressed: () {
                  context.push(
                    '/set_location/set_vehicle_reg/vehicle_size/service_type',
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

class VehicleSizeTile extends StatelessWidget {
  final Map<String, String> vehicleDetails;
  final bool isSelected;
  final VoidCallback onSelect;

  const VehicleSizeTile({
    super.key,
    required this.vehicleDetails,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    const String smallVpath = 'assets/images/small_vehicle.png';
    const String mediumVpath = 'assets/images/medium_vehicle.png';
    const String largeVpath = 'assets/images/large_vehicle.png';
    final size = vehicleDetails["size"]!.toLowerCase();

    return GestureDetector(
      onTap: onSelect,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? lightPurple : backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              height: 120,
              // width: 90,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: scaffoldBackground,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Image.asset(
                size == "small"
                    ? smallVpath
                    : size == "medium"
                    ? mediumVpath
                    : largeVpath,
                height: 70,
                width: 70,
              ),
              // child: Icon(
              //   size == "small"
              //       ? FontAwesomeIcons.carSide
              //       : size == "medium"
              //       ? FontAwesomeIcons.car
              //       : FontAwesomeIcons.vanShuttle,
              //   size: 48,
              // ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vehicleDetails["size"]!,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: isSelected ? whiteText : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    vehicleDetails["type"]!,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      //color:  whiteText : hintTextColor,
                      color:
                          isSelected
                              ? const Color.fromARGB(255, 213, 210, 210)
                              : hintTextColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Text(
                    vehicleDetails["brand"]!,
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
