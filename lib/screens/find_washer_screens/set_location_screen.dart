import 'package:flutter/material.dart';
import 'dart:async';
import 'package:go_router/go_router.dart';
import 'package:ommeoWash/custom_theme/color_palette.dart';
import 'package:ommeoWash/custom_theme/custom_button.dart';
import 'package:ommeoWash/custom_theme/custom_widgets.dart';

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
    if (_debounce?.isActive ?? false)
      _debounce!
          .cancel(); //if debounce exist, cancel it because you are going to activate a new one in the next line
    _debounce = Timer(const Duration(milliseconds: 300), () {
      //set new debounce for 300mili secs
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
                            : lightPurple,
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




















// import 'package:go_router/go_router.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';

// import 'package:ommeowash/custom_theme/color_palette.dart';
// import 'package:ommeowash/custom_theme/custom_button.dart';
// import 'package:ommeowash/custom_theme/custom_widgets.dart';

// import '../../helpers/indicator_value_list.dart';

// class SetLocationScreen extends StatefulWidget {
//   const SetLocationScreen({super.key});

//   @override
//   State<SetLocationScreen> createState() => _SetLocationScreenState();
// }



// class _SetLocationScreenState extends State<SetLocationScreen> {
//   GoogleMapController? _mapController;
//   LatLng? _pickedLocation;
//   LatLng _initialCameraPosition = const LatLng(
//     5.5600,
//     -0.2050,
//   ); // Default to Accra

//   @override
//   void initState() {
//     super.initState();
//     _determinePosition();
//   }

//   Future<void> _determinePosition() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     LocationPermission permission = await Geolocator.checkPermission();

//     if (!serviceEnabled || permission == LocationPermission.deniedForever) {
//       return; // handle permission denied
//     }

//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission != LocationPermission.whileInUse &&
//           permission != LocationPermission.always) {
//         return;
//       }
//     }

//     Position position = await Geolocator.getCurrentPosition();
//     setState(() {
//       _initialCameraPosition = LatLng(position.latitude, position.longitude);
//     });
//   }

//   void _onMapTap(LatLng position) {
//     setState(() {
//       _pickedLocation = position;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: scaffoldBackground,
//       appBar: AppBar(
//         leading: const BackButton(),
//         backgroundColor: scaffoldBackground,
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           LnProgressIndicator(value: indicatorValues[0]),
//           const Padding(
//             padding: EdgeInsets.all(16),
//             child: Text(
//               "Set Your Location",
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
//             ),
//           ),
//           Expanded(
//             child: GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target: _initialCameraPosition,
//                 zoom: 14,
//               ),
//               onTap: _onMapTap,
//               onMapCreated: (controller) => _mapController = controller,
//               markers:
//                   _pickedLocation != null
//                       ? {
//                         Marker(
//                           markerId: const MarkerId('picked-location'),
//                           position: _pickedLocation!,
//                         ),
//                       }
//                       : {},
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: OmeeoButton(
//               backgroundColor:
//                   _pickedLocation == null ? hintTextColor : lightPurple,
//               text: 'Continue',
//               onPressed:
//                   _pickedLocation == null
//                       ? null
//                       : () {
//                         // Save or pass the picked location
//                         context.push('/set_location/set_vehicle_reg');
//                       },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

