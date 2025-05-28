import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../custom_theme/custom_button.dart' show OmeeoButton;
import '../../custom_theme/custom_widgets.dart';
import '../../helpers/indicator_value_list.dart';

import '../../custom_theme/color_palette.dart'
    show
        ColorPalette,
        backgroundColor,
        darkText,
        hintTextColor,
        lightPurple,
        scaffoldBackground,
        whiteText;

class VehicleRegistrationScreen extends StatefulWidget {
  const VehicleRegistrationScreen({super.key});

  @override
  State<VehicleRegistrationScreen> createState() =>
      _VehicleRegistrationScreenState();
}

class _VehicleRegistrationScreenState extends State<VehicleRegistrationScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _showRequiredError = false;
  bool isPlateNumberKnown = false;
  Map<String, String>? _vehicleDetails;
  bool canContinue = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: scaffoldBackground,
        appBar: AppBar(
          leading: const BackButton(),
          backgroundColor: scaffoldBackground,
          elevation: 0,
        ),
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // progress bar
                LnProgressIndicator(value: indicatorValues[1]),
                const SizedBox(height: 24),
                const Text(
                  "What it your vehicle?",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Enter your vehicle's number plate",
                    style: TextStyle(fontSize: 14, color: hintTextColor),
                  ),
                ),
                const SizedBox(height: 8),

                // Input with search button
                Container(
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          textCapitalization: TextCapitalization.characters,
                          decoration: const InputDecoration(
                            hintText: "Enter vehicle reg",
                            hintStyle: TextStyle(color: hintTextColor),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                          ),
                          onChanged: (_) {
                            setState(() {
                              _showRequiredError = false;
                              isPlateNumberKnown = true;
                              _vehicleDetails = null;
                            });
                          },
                        ),
                      ),
                      InkWell(
                        onTap: _searchVehicle,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: lightPurple,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: const Icon(
                            FontAwesomeIcons.magnifyingGlass,
                            size: 18,
                            color: whiteText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Error text
                if (_showRequiredError)
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      "Plate number is required!",
                      style: TextStyle(
                        color: ColorPalette.errorColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                if (isPlateNumberKnown == false)
                  Center(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _vehicleDetails = null;
                          _controller.clear();
                        });
                      },
                      child: GestureDetector(
                        onTap: () {
                          context.push(
                            '/set_location/set_vehicle_reg/vehicle_size',
                          );
                        },
                        child: const Text(
                          "I don't know my plate",
                          style: TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            color: darkText,
                          ),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                // Vehicle details card
                if (_vehicleDetails != null)
                  VehicleDetailsTile(
                    vehicleDetails: _vehicleDetails!,
                    callBack: () {
                      setState(() {
                        canContinue = true;
                      });
                    },
                    canContinue: canContinue,
                  ),

                // Not my vehicle link
                if (_vehicleDetails != null)
                  Center(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _vehicleDetails = null;
                          _controller.clear();
                        });
                        context.push(
                          '/set_location/set_vehicle_reg/vehicle_size',
                        );
                      },
                      child: const Text(
                        "Not my vehicle",
                        style: TextStyle(
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                const Spacer(),

                // Continue button → use your custom button
                OmeeoButton(
                  backgroundColor:
                      _controller.text.trim().isEmpty
                          ? hintTextColor
                          : lightPurple,
                  text: "Continue",
                  onPressed: () {
                    context.push('/set_location/set_vehicle_reg/service_type');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final List<Map<String, String>> vehicles = [
    {
      "brand": "Audi",
      "model": "Q4 E-tron Sport 40",
      "color": "Blue",
      "label": "5CAM",
    },
    {
      "brand": "Jaguar",
      "model": "Q4 T-pace Sport 40",
      "color": "White",
      "label": "TPACE",
    },
  ];

  void _searchVehicle() {
    final input = _controller.text.trim();
    if (input.isEmpty) {
      setState(() {
        _showRequiredError = true;
        _vehicleDetails = null;
      });
      return;
    }

    setState(() {
      _showRequiredError = false;
      canContinue = false;
    });

    try {
      final vehicle = vehicles.firstWhere(
        (v) => v["label"]!.toLowerCase() == input.toLowerCase(),
      );

      setState(() {
        _vehicleDetails = {
          "brand": vehicle["brand"]!,
          "model": vehicle["model"]!,
          "color": vehicle["color"]!,
        };
      });
    } catch (e) {
      setState(() {
        isPlateNumberKnown = false;
      });
      // No match found
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              backgroundColor: backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              content: SizedBox(
                height: 95,
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    CustomText("An error has occurred.", fontSize: 16),
                    SizedBox(height: 10),
                    CustomText(
                      "No vehicle details found for the provided plates.",
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              actions: [
                Column(
                  children: [
                    const Divider(),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const CustomText("OK", fontSize: 17),
                    ),
                  ],
                ),
              ],
            ),
      );
    }
  }
}

class VehicleDetailsTile extends StatelessWidget {
  final Function callBack;
  final bool canContinue;
  final Map<String, String> vehicleDetails;
  const VehicleDetailsTile({
    super.key,
    required this.vehicleDetails,
    required this.callBack,
    required this.canContinue,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callBack();
      },
      child: Container(
        decoration: BoxDecoration(
          color: canContinue ? lightPurple : backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                height: 90,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: scaffoldBackground,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: const Icon(Icons.directions_car, size: 48),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your vehicle:",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: canContinue ? whiteText : darkText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  vehicleDetails["brand"]!,
                  style: TextStyle(color: canContinue ? whiteText : darkText),
                ),
                Text(
                  vehicleDetails["model"]!,
                  style: TextStyle(color: canContinue ? whiteText : darkText),
                ),
                Text(
                  vehicleDetails["color"]!,
                  style: TextStyle(color: canContinue ? whiteText : darkText),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
