import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ommeoWash/custom_theme/color_palette.dart';
import 'package:ommeoWash/custom_theme/custom_button.dart';
import 'package:ommeoWash/custom_theme/custom_widgets.dart';
import 'package:ommeoWash/helpers/indicator_value_list.dart';

class SelectDateScreen extends StatefulWidget {
  final String path;
  const SelectDateScreen({super.key, required this.path});

  @override
  State<SelectDateScreen> createState() => _SelectDateScreenState();
}

class _SelectDateScreenState extends State<SelectDateScreen> {
  late String routePath;
  DateTime pickedDate = DateTime.now();

  @override
  void initState() {
    routePath = widget.path;
    super.initState();
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
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            children: [
              LnProgressIndicator(value: indicatorValues[4]),
              const SizedBox(height: 24),
              Text(
                "When do you want your car cleaned?",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Calendar widget
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CalendarDatePicker(
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 60)),
                    onDateChanged: (date) {
                      setState(() {
                        pickedDate = date;
                      });
                      debugPrint('Picked date: ${pickedDate}');
                    },
                  ),
                ),
              ),

              const Spacer(),

              // Continue button
              // Padding(
              //   padding: const EdgeInsets.all(16.0),
              //   child: SizedBox(
              //     width: double.infinity,
              //     child: ElevatedButton(
              //       onPressed: () {
              //         // Handle continue
              //       },
              //       style: ElevatedButton.styleFrom(
              //         padding: const EdgeInsets.symmetric(vertical: 16),
              //         backgroundColor: Colors.grey[300], // inactive style
              //         foregroundColor: Colors.grey[600],
              //       ),
              //       child: const Text("Continue"),
              //     ),
              //   ),
              // ),
              OmeeoButton(
                backgroundColor: lightGreen,
                text: "Continue",
                onPressed: () {
                  context.push(routePath);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
