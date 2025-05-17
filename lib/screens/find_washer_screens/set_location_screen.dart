import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ommeowash/custom_theme/color_palette.dart';
import 'package:ommeowash/custom_theme/custom_button.dart';
import 'package:ommeowash/custom_theme/custom_widgets.dart';

import '../../helpers/indicator_value_list.dart';

class SetLocationScreen extends StatefulWidget {
  const SetLocationScreen({super.key});

  @override
  State<SetLocationScreen> createState() => _SetLocationScreenState();
}

class _SetLocationScreenState extends State<SetLocationScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _allSuggestions = [
    'Oxford OX1 1PE, UK',
    "Saint Aldate's, Oxford OX1 1ST, UK",
    'Thames Street, Oxford OX1 1TS, UK',
    'Oxford OX1 1HS, UK',
    'Castle Street, Oxford OX1 1AY, UK',
    'Paradise St, Oxford OX1 1LD, UK',
    'Oxford OX1, UK',
  ];

  List<String> _filteredSuggestions = [];
  List<String>? _locationOptions;
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged(String value) {
    _locationOptions = null;
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _filteredSuggestions =
            _allSuggestions
                .where(
                  (suggestion) =>
                      suggestion.toLowerCase().contains(value.toLowerCase()),
                )
                .toList();
      });
    });
  }

  void _onSuggestionTap(String suggestion) {
    setState(() {
      _filteredSuggestions = [];
      _controller.text = suggestion.split(',')[0];
      // show example options after selection
      _locationOptions = [
        suggestion,
        // simplified version: extract postcode area
        suggestion.contains('OX1') ? 'Oxford OX1, UK' : suggestion,
      ];
    });
  }

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
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LnProgressIndicator(value: indicatorValues[0]),
                  const SizedBox(height: 24),
                  const Text(
                    "Set Your Location",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "Start typing the postcode",
                      style: TextStyle(fontSize: 14, color: hintTextColor),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _controller,
                    onChanged: _onTextChanged,
                    decoration: InputDecoration(
                      hintText: "Enter postcode",
                      hintStyle: TextStyle(color: hintTextColor),
                      filled: true,
                      fillColor: backgroundColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      suffixIcon:
                          _controller.text.isNotEmpty
                              ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  setState(() {
                                    _controller.clear();
                                    _filteredSuggestions = [];
                                    _locationOptions = null;
                                  });
                                },
                              )
                              : null,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Suggestions list
                  if (_filteredSuggestions.isNotEmpty)
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        key: ValueKey(_filteredSuggestions),
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Container(
                          constraints: const BoxConstraints(maxHeight: 300),
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: _filteredSuggestions.length,
                            separatorBuilder:
                                (_, __) => Divider(
                                  height: 1,
                                  color: Colors.grey.shade300,
                                ),
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(_filteredSuggestions[index]),
                                onTap:
                                    () => _onSuggestionTap(
                                      _filteredSuggestions[index],
                                    ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),

                  // Location options card
                  if (_locationOptions != null)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: List.generate(_locationOptions!.length, (
                          index,
                        ) {
                          return Column(
                            children: [
                              ListTile(
                                title: Text(_locationOptions![index]),
                                trailing: const Icon(
                                  Icons.chevron_right,
                                  size: 20,
                                ),
                                onTap: () {},
                              ),
                              if (index != _locationOptions!.length - 1)
                                Divider(height: 1, color: Colors.grey.shade300),
                            ],
                          );
                        }),
                      ),
                    ),

                  const Spacer(),
                  OmeeoButton(
                    backgroundColor:
                        _controller.text.trim().isEmpty
                            ? hintTextColor
                            : lightGreen,
                    text: 'Continue',
                    onPressed: () {
                      // _locationOptions != null
                      context.push('/set_location/set_vehicle_reg');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
